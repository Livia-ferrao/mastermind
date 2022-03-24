library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplex16 is
port
(   A: in std_logic_vector(15 downto 0);
    B: in std_logic_vector(15 downto 0);
    C: in std_logic_vector(15 downto 0);
    D: in std_logic_vector(15 downto 0);
    SEL: in std_logic_vector(1 downto 0);
    S: out std_logic_vector(15 downto 0)
    );
end multiplex16;

architecture mux of multiplex16 is

begin
    S <= A when SEL = "00" else
         B when SEL = "01" else
         C when SEL = "10" else
         D;
end mux;