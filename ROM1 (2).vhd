library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));

end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0001010101000010",  --1542
    01 => "0001001000110101",  --1235
    02 => "0010010000010011",  --2413
    03 => "0010000101010100",  --2154
    04 => "0010010101000001",  --2541
    05 => "0001010001010011",  --1453
    06 => "0001001001010100",  --1254
    07 => "0100001001010001",  --4251
    08 => "0101010000010011",  --5413
    09 => "0101001001000001",  --5241
    10 => "0011010100010100",  --3514
    11 => "0011001001000001",  --3241
    12 => "0011010000100101",  --3425
    13 => "0100001100100001",  --4321
    14 => "0100010100010010",  --4512
    15 => "0001001001010011"); --1253


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