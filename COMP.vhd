library ieee;
use ieee.std_logic_1164.all;
entity COMP is port (
	user: in std_logic_vector(3 downto 0);
	code: in std_logic_vector(3 downto 0);
	S: out std_logic_vector(2 downto 0));
end COMP;

architecture arq of COMP is
begin
    process(user, code)
    begin
	    if user = code then
	        S <= "001";
	    else
	        S <= "000";
	    end if;
	end process;
end arq;





