library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
entity counter_time is port ( 
  Reset: in std_logic;
  En: in std_logic;
  CLK: in std_logic;
  saida: out std_logic_vector(3 downto 0);
  end_time: out std_logic);
end counter_time;
architecture cont of counter_time is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin
  process(CLK, Reset)
  begin
    if (Reset = '1') then
			cnt <= "0000";
    elsif (CLK'event and CLK = '1' and En='1') then	
      cnt <= cnt + "0001";
    end if;
    
  end process;
  end_time <= '1' when cnt= "1010" else '0';
  saida <= cnt;
end cont;
