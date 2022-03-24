library ieee;
use ieee.std_logic_1164.all;

entity ROM0 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));

end ROM0;

architecture Rom_Arch of ROM0 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0000000100100011",  --0123
    01 => "0000000100110010",  --0132
    02 => "0000001000010011",  --0213
    03 => "0000001000110001",  --0231
    04 => "0000001100010010",  --0312
    05 => "0000001100100001",  --0321
    06 => "0001000000100011",  --1023
    07 => "0001000000110010",  --1032
    08 => "0001001000000011",  --1203
    09 => "0001001000110000",  --1230
    10 => "0001001100000010",  --1302
    11 => "0001001100100000",  --1320
    12 => "0010000000010011",  --2013
    13 => "0010000000110001",  --2031
    14 => "0010000100000011",  --2103
    15 => "0010000100110000"); --2130


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