library IEEE;
use IEEE.Std_Logic_1164.all;

entity dec7seg is
port (C:  in std_logic_vector(3 downto 0);
      saida:  out std_logic_vector(6 downto 0) );
end dec7seg;

architecture decod of dec7seg is
begin 
  saida <= "1000000" when C = "0000" else    -- 0
           "1111001" when C = "0001" else    -- 1
           "0100100" when C = "0010" else    -- 2
           "0110000" when C = "0011" else    -- 3
           "0011001" when C = "0100" else    -- 4
           "0010010" when C = "0101" else    -- 5
           "0000010" when C = "0110" else    -- 6
           "1111000" when C = "0111" else    -- 7
           "0000000" when C = "1000" else    -- 8
           "0010000" when C = "1001" else    -- 9
           "0001000" when C = "1010" else    -- 10(A)
           "0000011" when C = "1011" else    -- 11(B)
           "1000110" when C = "1100" else    -- 12(C)
           "0100001" when C = "1101" else    -- 13(D)
           "0000110" when C = "1110" else    -- 14(E)
           "0001110";
end decod;
