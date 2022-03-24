library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplex2 is port(
    A: in std_logic_vector(6 downto 0);
    B: in std_logic_vector(6 downto 0);
    SEL: in std_logic;
    S: out std_logic_vector(6 downto 0)
    );
end multiplex2;

architecture mux of multiplex2 is

begin
    S <= A when SEL = '0' else
         B;

end mux;