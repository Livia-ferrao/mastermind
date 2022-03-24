library ieee;
use ieee.std_logic_1164.all;
entity Reg6 is port (
	CLK: in std_logic;
	EN: in std_logic;
	RST: in std_logic;
	D: in std_logic_vector(5 downto 0);
	Q: out std_logic_vector(5 downto 0));
end Reg6;

architecture reg of Reg6 is
begin
	process(CLK, D)
	begin
		if (RST = '1') then
			Q <= "000000";
		elsif (CLK'event and CLK = '1') then
			if (EN = '1') then
				Q <= D;
			end if;
		end if;
	end process;
end reg;