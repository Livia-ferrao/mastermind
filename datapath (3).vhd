library ieee;
use ieee.std_Logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity datapath is port( 
    
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
    
end datapath;


architecture arc_data of datapath is

signal ent0_00, ent0_10, ent2_10: std_logic_vector(3 downto 0);
signal code, user, s_dec_term, rom0_s, rom1_s, rom2_s, rom3_s: std_logic_vector(15 downto 0);
signal result: std_logic_vector(7 downto 0);
signal h0_00, h0_01, h0_10, h0_11, h1_01, h1_11, h2_00, h2_01, h2_10, h2_11, h3_01, h3_11, h4_1, h6_1, h7_1: std_logic_vector(6 downto 0);
signal sel: std_logic_vector(5 downto 0);
signal time_0, X, s_soma, F: std_Logic_vector(3 downto 0);
signal P, P_reg, E, E_reg, somaP: std_logic_vector(2 downto 0);
signal sel_mux: std_logic_vector(1 downto 0);
signal end_gamee, end_timee: std_logic;
signal cmp0_s, cmp1_s, cmp2_s, cmp3_s: std_logic_vector(2 downto 0);


component SELECTOR is port(
   E1, E2, R1, E5: in  std_logic;
   SEL_MUX       : out std_logic_vector(1 downto 0));
end component;

component comp_e is port(
    inc, inu: in  std_logic_vector(15 downto 0);
    E       : out std_logic_vector(2 downto 0));
end component;

component Reg3 is port (
	CLK: in std_logic;
	EN: in std_logic;
	RST: in std_logic;
	D: in std_logic_vector(2 downto 0);
	Q: out std_logic_vector(2 downto 0) );
end component;

component Reg6 is port (
	CLK: in std_logic;
	EN: in std_logic;
	RST: in std_logic;
	D: in std_logic_vector(5 downto 0);
	Q: out std_logic_vector(5 downto 0) );
end component;

component Reg16 is port (
	CLK: in std_logic;
	EN: in std_logic;
	RST: in std_logic;
	D: in std_logic_vector(15 downto 0);
	Q: out std_logic_vector(15 downto 0) );
end component;

component dec7seg is
port (C:  in std_logic_vector(3 downto 0);
      saida:  out std_logic_vector(6 downto 0) );
end component;

component multiplex4 is port ( 
    A: in std_logic_vector(6 downto 0);
    B: in std_logic_vector(6 downto 0);
    C: in std_logic_vector(6 downto 0);
    D: in std_logic_vector(6 downto 0);
    SEL: in std_logic_vector(1 downto 0);
    S: out std_logic_vector(6 downto 0));
end component;

component multiplex2 is port(
    A: in std_logic_vector(6 downto 0);
    B: in std_logic_vector(6 downto 0);
    SEL: in std_logic;
    S: out std_logic_vector(6 downto 0)
    );
end component;

component multiplex16 is port(
    A: in std_logic_vector(15 downto 0);
    B: in std_logic_vector(15 downto 0);
    C: in std_logic_vector(15 downto 0);
    D: in std_logic_vector(15 downto 0);
    SEL: in std_logic_vector(1 downto 0);
    S: out std_logic_vector(15 downto 0));
end component;

component COMP is port (
	user: in std_logic_vector(3 downto 0);
	code: in std_logic_vector(3 downto 0);
	S: out std_logic_vector(2 downto 0));
end component;

component COMP4 is port (
	ent: in std_logic_vector(2 downto 0);
	s: out std_logic);
end component;

component counter_round is port ( 
  Reset: in std_logic;
  En: in std_logic;
  CLK: in std_logic;
  saida: out std_logic_vector(3 downto 0);
  end_round: out std_logic);
end component;

component counter_time is port ( 
  Reset: in std_logic;
  En: in std_logic;
  CLK: in std_logic;
  saida: out std_logic_vector(3 downto 0);
  end_time: out std_logic);
end component;

component ROM0 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM1 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM2 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM3 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component decotermo is port(
     X: in std_logic_vector(3 downto 0);
     S: out std_logic_vector(15 downto 0));
end component;

begin
    -- SOMA P
    P <= cmp0_s + cmp1_s + cmp2_s + cmp3_s;

    -- CALCULAR F
    F <= (not(X) + "0001") when 
            end_timee = '0' else
            "0000";
    result <= "000" & end_gamee & F;
    
    
    -- DECODIFICADOR_TERMOMETRICO
    DECODER_TERMOMETRICO: decotermo port map(X => X,
                                            S => s_dec_term);
    ledr <= s_dec_term when E1 = '0' else "0000000000000000";

    
    
    -- ROM0
    rom_0: ROM0 port map(address => sel(5 downto 2),
                                    data => rom0_s);
                                    
    -- ROM1
    rom_1:  ROM1 port map(address => sel(5 downto 2),
                                    data => rom1_s);
    
    -- ROM2
    rom_2: ROM2 port map(address => sel(5 downto 2),
                                    data => rom2_s);
    -- ROM3
    rom_3:  ROM3 port map(address => sel(5 downto 2),
                                    data => rom3_s);
    
    
    
    
    -- COUNTER_ROUND
    cnt_round: counter_round port map(Reset => R2,
                                En => E3,
                                CLK => Clock500,
                                saida => X,
                                end_round => end_round);
    
    -- COUNTER_TIME
    cnt_time: counter_time port map(Reset => R1,
                                En => E2,
                                CLK => Clock1,
                                saida => time_0,
                                end_time => end_timee);
    
    
    
    
    -- COMP_0
    comp_0: COMP port map(user => user(3 downto 0),
                        code => code(3 downto 0),
                        S => cmp0_s);
                        
    -- COMP_1
    comp_1: COMP port map(user => user(7 downto 4),
                        code => code(7 downto 4),
                        S => cmp1_s);
                        
    -- COMP_2
    comp_2: COMP port map(user => user(11 downto 8),
                        code => code(11 downto 8),
                        S => cmp2_s);                    
    -- COMP_3
    comp_3: COMP port map(user => user(15 downto 12),
                        code => code(15 downto 12),
                        S => cmp3_s);
    
    -- COMPARACÃO COM 4
    comp_4: COMP4 port map(ent => P,
                        S => end_gamee);
                        
                        
    
    -- Multiplexador4_0
    multi4_0: multiplex4 port map(A => h0_00,
                                B => h0_01,
                                C => h0_10,
                                D => h0_11,
                                Sel => sel_mux,
                                S => hex0);
    -- Multiplexador4_1
    multi4_1: multiplex4 port map(A => "1000111",
                                B => h1_01,
                                C => "0000110",
                                D => h1_11,
                                Sel => sel_mux,
                                S => hex1);
    -- Multiplexador4_2
    multi4_2: multiplex4 port map(A => h2_00,
                                B => h2_01,
                                C => h2_10,
                                D => h2_11,
                                Sel => sel_mux,
                                S => hex2);
    -- Multiplexador4_3
    multi4_3: multiplex4 port map(A => "1000110",
                                B => h3_01,
                                C => "0001100",
                                D => h3_11,
                                Sel => sel_mux,
                                S => hex3);
    -- Multiplexador2_4
    multi2_4: multiplex2 port map(A => "1111111",
                                B => h4_1,
                                Sel => E2,
                                S => hex4);
    
    -- Multiplexador2_5
    multi2_5: multiplex2 port map(A => "1111111",
                                B => "0000111",
                                Sel => E2,
                                S => hex5);
                                
    -- Multiplexador2_6
    multi2_6: multiplex2 port map(A => "1111111",
                                B => h6_1,
                                Sel => E5,
                                S => hex6);
    -- Multiplexador2_7
    multi2_7: multiplex2 port map(A => "1111111",
                                B => h7_1,
                                Sel => E5,
                                S => hex7);
                                
    -- Multiplexador16
    multi16: multiplex16 port map(A => rom0_s,
                                B => rom1_s,
                                C => rom2_s,
                                D => rom3_s,
                                Sel => sel(1 downto 0),
                                S => code);
                                
                                
    
    -- Decodificadores do multiplexador 0
    decod0_11: dec7seg port map(C => code(3 downto 0),
                              saida => h0_11);
                              
    ent0_10 <= ('0' & E_reg(2 downto 0));
    decod0_10: dec7seg port map(C => ent0_10,
                              saida => h0_10);
                              
    decod0_01: dec7seg port map(C => user(3 downto 0),
                              saida => h0_01);
                              
    ent0_00 <= ("00" & sel(1 downto 0));
    decod0_00: dec7seg port map(C => ent0_00,
                              saida => h0_00);
                              
    -- Decodificadores do multiplexador 1
                              
    decod1_11: dec7seg port map(C => code(7 downto 4),
                              saida => h1_11);
    
    decod1_01: dec7seg port map(C => user(7 downto 4),
                              saida => h1_01);
                              
    -- Decodificadores do multiplexador 2
                              
    decod2_11: dec7seg port map(C => code(11 downto 8),
                              saida => h2_11);
                              
    ent2_10 <= '0' & P_reg(2 downto 0);
    decod2_10: dec7seg port map(C => ent2_10,
                              saida => h2_10);
                              
    decod2_01: dec7seg port map(C => user(11 downto 8),
                              saida => h2_01);                          
                              
    decod2_00: dec7seg port map(C => sel(5 downto 2),
                              saida => h2_00);
                              
    -- Decodificadores do multiplexador 3
    decod3_11: dec7seg port map(C => code(15 downto 12),
                              saida => h3_11);
                              
    decod3_01: dec7seg port map(C => user(15 downto 12),
                              saida => h3_01);
                              
    -- Decodificadores do multiplexador 4
    decod4_1: dec7seg port map(C => time_0,
                              saida => h4_1);
    
    -- Decodificadores do multiplexador 6
    decod6_1: dec7seg port map(C => result(3 downto 0),
                              saida => h6_1);
    -- Decodificadores do multiplexador 7
    decod7_1: dec7seg port map(C => result(7 downto 4),
                              saida => h7_1);
    
    
    
    
    -- Seletor

    selector0: SELECTOR port map( E1=> E1,
                             E2 => E2,
                             R1 => R1,
                             E5 => E5,
                             SEL_MUX => sel_mux);
                             
    -- Comp_e
    
    comp_e0: comp_e port map( inc => code,
                             inu => user,
                             E => E);
                             
    
    -- Registradores
                             
    reg3_0: Reg3 port map( CLK => Clock500,
                        EN => E4,
                        RST => R2 ,
                        D => P,
                        Q=> P_reg);
                        
    reg3_1: Reg3 port map( CLK => Clock500,
                        EN => E4,
                        RST => R2 ,
                        D => E,
                        Q=> E_reg);
                        
    reg6_0: Reg6 port map( CLK => Clock500,
                        EN => E1,
                        RST => R2 ,
                        D => Switches(5 downto 0),
                        Q=> sel);
                        
    reg16_0: Reg16 port map( CLK => Clock500,
                        EN => E2,
                        RST => R2,
                        D => Switches(15 downto 0),
                        Q=> user);
                        

    end_game <= end_gamee; --ao interligar a saida do comp=4, usar o signal end_gamee para evitar erros
    end_time <= end_timee; --ao interligar a saida do counter_time, usar o signal end_timee para evitar erros


end arc_data;
