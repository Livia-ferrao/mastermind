library IEEE;
use IEEE.Std_Logic_1164.all;

entity mastermind is port (
    Sw                          : in  std_logic_vector(15 downto 0);
    Clock1, Clock500            : in  std_logic;
    KEY0, KEY1                  : in  std_logic;
    ledr                        : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3      : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7      : out std_logic_vector(6 downto 0));
end mastermind;

architecture jogo of mastermind is
signal R1, R2, E1, E2, E3, E4, E5: std_logic;
signal end_game, end_time, end_round: std_logic;
signal enter, reset: std_logic;

component ButtonSync is port(
    KEY0, KEY1, CLK: in  std_logic;
    Enter, Reset   : out std_logic);
end component;

component controle is port (
  clock: in std_logic;
  reset, enter: in std_logic;
  end_game, end_time, end_round: in std_logic;
  R1, R2: out std_logic;
  E1, E2, E3, E4, E5: out std_logic);
end component;

component datapath is port( 
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
end component;

begin 
   botao: ButtonSync port map(KEY0 => KEY0,
                              KEY1 => KEY1,
                              CLK => Clock500,
                              enter => enter,
                              Reset => reset);
                              
    control: controle port map(clock => Clock500,
                              reset => reset,
                              enter => enter,
                              end_game => end_game,
                              end_time => end_time,
                              end_round => end_round,
                              R1 => R1,
                              R2 => R2,
                              E1 => E1,
                              E2 => E2,
                              E3 => E3,
                              E4 => E4,
                              E5 => E5);
    
    data: datapath port map(Switches => Sw,
                            Clock1 => Clock1,
                            Clock500 => Clock500,
                            R1 => R1,
                            R2 => R2,
                            E1 => E1,
                            E2 => E2,
                            E3 => E3,
                            E4 => E4,
                            E5 => E5,
                            ledr => ledr,
                            hex0 => hex0,
                            hex1 => hex1,
                            hex2 => hex2,
                            hex3 => hex3,
                            hex4 => hex4,
                            hex5 => hex5,
                            hex6 => hex6,
                            hex7 => hex7,
                            end_game => end_game,
                            end_time => end_time,
                            end_round => end_round);
   
end jogo;











