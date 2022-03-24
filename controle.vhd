library ieee;
use ieee.std_logic_1164.all;
entity controle is port (
  clock: in std_logic;
  reset, enter: in std_logic;
  end_game, end_time, end_round: in std_logic;
  R1, R2: out std_logic;
  E1, E2, E3, E4, E5: out std_logic);
end controle;

architecture fsmarq of controle is
  type STATES is (Init, Setup, Play, Count_Round, Check, Wait1, Result);
  signal EAtual, PEstado: STATES;
begin
  process(clock,reset)
  begin
    if (reset = '1') then
	  EAtual <= Init;
	elsif (clock'event AND clock = '1') then 
  	  EAtual <= PEstado;
	end if;
  end process;
process(EAtual, enter, end_game, end_time, end_round)
  begin
    case EAtual is
      when Init =>
        PEstado <= Setup;
        R1 <= '1';
        R2 <= '1';
        E1 <= '0';
        E2 <= '0';
		E3 <= '0';
		E4 <= '0';
		E5 <= '0';
		
	  when Setup=> 
	      R1 <= '0';
		  R2 <= '0';
		  E1 <= '1';
		  E2 <= '0';
		  E3 <= '0';
		  E4 <= '0';
		  E5 <= '0';
		  if enter = '1' then
		    PEstado <= Play;
		  else
		    PEstado <= Setup;
		  end if;
		  
	when Play =>
	      R1 <= '0';
	      R2 <= '0';
	      E1 <= '0';
		  E2 <= '1';
		  E3 <= '0';
		  E4 <= '0';
		  E5 <= '0';
                
	   if enter = '1' then
	        PEstado <= Count_Round;
	        
	   elsif end_time = '1' then
	        PEstado <= Result;
	   else
	        PEstado <= Play;
	   end if;
	   
	when Count_Round =>
	    PEstado <= Check;
	    R1 <= '0';
	    R2 <= '0';
	    E1 <= '0';
		E2 <= '0';
		E3 <= '1';
		E4 <= '0';
		E5 <= '0';
	
	when Check =>
	    R1 <= '0';
	    R2 <= '0';
	    E1 <= '0';
		E2 <= '0';
		E3 <= '0';
		E4 <= '1';
		E5 <= '0';
	    if end_round = '1' or end_game = '1' then
	        PEstado <= Result;
	    else
	        PEstado <= Wait1;
	    end if;
	    
	when Wait1 =>
	    R1 <= '1';
	    R2 <= '0';
	    E1 <= '0';
		E2 <= '0';
		E3 <= '0';
		E4 <= '0';
		E5 <= '0';
	    if enter = '1' then
	        PEstado <= Play;
	    else
	        PEstado <= Wait1;
	    end if;
	    
	when Result =>
	    R1 <= '0';
	    R2 <= '0';
	    E1 <= '0';
		E2 <= '0';
		E3 <= '0';
		E4 <= '0';
		E5 <= '1';
	    if enter = '1' then
	        PEstado <= Init;
	    else
	        PEstado <= Result;
	    end if;
    end case;
  end process;
end fsmarq;






