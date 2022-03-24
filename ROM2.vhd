library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));

end ROM2;

architecture Rom_Arch of ROM2 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0001011101100010",  --1762
    01 => "0001010001100101",  --1465
    02 => "0001001001000110",  --1246
    03 => "0010010100010111",  --2517
    04 => "0010011100010011",  --2713
    05 => "0010001100010101",  --2315
    06 => "0011010101110001",  --3571
    07 => "0011001001010110",  --3256
    08 => "0100010101100111",  --4567
    09 => "0100000100110010",  --4132
    10 => "0101011101100001",  --5761
    11 => "0101011001110100",  --5674
    12 => "0110011101000001",  --6741
    13 => "0110000101000010",  --6142
    14 => "0111001100010110",  --7316
    15 => "0111010001010001"); --7451


begin
   process (address)
   begin
     case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
       when "1010" => data <= my_rom(10);
       when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
       when "1101" => data <= my_rom(13);
       when "1110" => data <= my_rom(14);
       when others => data <= my_rom(15);
     end case;
  end process;
end architecture Rom_Arch;