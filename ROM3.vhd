library ieee;
use ieee.std_logic_1164.all;

entity ROM3 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));

end ROM3;

architecture Rom_Arch of ROM3 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0001010110010100",  --1594
    01 => "0001001010000011",  --1283
    02 => "0010011001111001",  --2679
    03 => "0010100000110101",  --2835
    04 => "0011000100101001",  --3129
    05 => "0011010001111000",  --3478
    06 => "0100000101110101",  --4175
    07 => "0100100100110001",  --4931
    08 => "0101001101101000",  --5368
    09 => "0101100100100111",  --5927
    10 => "0110000110000010",  --6182
    11 => "0110011101010001",  --6751
    12 => "0111100000100001",  --7821
    13 => "0111010001011001",  --7459
    14 => "1000001100100001",  --8321
    15 => "1001011101011000"); --9758


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