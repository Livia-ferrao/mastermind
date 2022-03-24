library ieee;
use ieee.std_logic_1164.all;

entity SELECTOR is port(

   E1, E2, R1, E5: in  std_logic;
   SEL_MUX       : out std_logic_vector(1 downto 0));
    
end selector;


architecture arc_selector of SELECTOR is begin

 SEL_MUX <="00" when E1 = '1' else
          "01" when E2 = '1' else
          "10" when R1 = '1' else
          "11" when E5 = '1' else
		  "01";
	
end arc_selector;