library ieee;
use ieee.std_logic_1164.all;
entity COMP4 is port (
	ent: in std_logic_vector(2 downto 0);
	s: out std_logic);
end COMP4;

architecture arq of COMP4 is
begin
    process(ent)
    begin
	    if ent = "100" then
	        s <= '1';
	    else
	        s <= '0';
	    end if;
	end process;
end arq;





