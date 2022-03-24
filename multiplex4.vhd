library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplex4 is
port
(   A: in std_logic_vector(6 downto 0);
    B: in std_logic_vector(6 downto 0);
    C: in std_logic_vector(6 downto 0);
    D: in std_logic_vector(6 downto 0);
    SEL: in std_logic_vector(1 downto 0);
    S: out std_logic_vector(6 downto 0)
    );
end multiplex4;

architecture mux of multiplex4 is

begin
    S <= A when SEL = "00" else
         B when SEL = "01" else
         C when SEL = "10" else
         D;
end mux;