library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter_round is port ( 
  Reset: in std_logic;
  En: in std_logic;
  CLK: in std_logic;
  saida: out std_logic_vector(3 downto 0);
  end_round: out std_logic);
end counter_round;

architecture cont of counter_round is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin
  process(CLK, Reset, En)
  begin
    if (Reset = '1') then
			cnt <= "0000";
			end_round <= '0';
    elsif (CLK'event and CLK = '1' and En='1') then	
      cnt <= cnt + "0001";
    end if;
    
    if cnt = "1111" then
        end_round <= '1';
    end if;
  end process;
  
  saida <= cnt;
end cont;
