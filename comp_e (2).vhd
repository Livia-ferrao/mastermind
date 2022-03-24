library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity comp_e is port(

    inc, inu: in  std_logic_vector(15 downto 0);
    E       : out std_logic_vector(2 downto 0));
    
end comp_e;

architecture arc_comp of comp_e is --comparador que retorna quantos digitos (codificados em BCD) entre dois vetores de 4 digitos sao iguais (parte do pressuposto que os 4 dígitos nunca se repetem)

	signal xnc15, xnc11, xnc7,xnc3 : std_logic_vector(11 downto 0);
	signal c3d, c2d, c1d, c0d, u3d, u2d, u1d, u0d: std_logic_vector(3 downto 0);
	signal Ac3, Ac2, Ac1, Ac0, Oc3, Oc2, Oc1, Oc0 : std_logic_vector(2 downto 0) := "000";

begin

	c3d <= inc(15 downto 12); --signals recebem os digitos, do mais significativo ao menos significativo
	c2d <= inc(11 downto  8);
	c1d <= inc( 7 downto  4);
	c0d <= inc( 3 downto  0);
	
	u3d <= inu(15 downto 12);
	u2d <= inu(11 downto  8);
	u1d <= inu( 7 downto  4);
	u0d <= inu( 3 downto  0);
	
	
	xnc15(11 downto  8) <= (c3d xnor u2d); --Vetor de 4 digitos recebe o xnor entre um digito do codigo e os 4 do usuario, para ver se sao iguais.
	xnc15( 7 downto  4) <= (c3d xnor u1d); --Se o resultado do xnor for "1111", os digitos comparados sao iguais.
	xnc15( 3 downto  0) <= (c3d xnor u0d);
	
	xnc11(11 downto  8) <= (c2d xnor u3d);
	xnc11( 7 downto  4) <= (c2d xnor u1d);
	xnc11( 3 downto  0) <= (c2d xnor u0d);
	
	xnc7 (11 downto  8) <= (c1d xnor u3d);
	xnc7 ( 7 downto  4) <= (c1d xnor u2d);
	xnc7 ( 3 downto  0) <= (c1d xnor u0d);
	
	xnc3 (11 downto  8) <= (c0d xnor u3d);
	xnc3 ( 7 downto  4) <= (c0d xnor u2d);
	xnc3 ( 3 downto  0) <= (c0d xnor u1d);
	
	 
	Ac3(2) <= (xnc15(11) and xnc15(10) and xnc15( 9) and xnc15( 8)); --Cada bit do vetor de 4 bits recebe '1' se o digito do codigo e do usuario sao iguais.
	Ac3(1) <= (xnc15( 7) and xnc15( 6) and xnc15( 5) and xnc15( 4)); --Um digito do codigo e do usuario ser iguais equivale aos 4 bits da saida do xnor ser "1111".
	Ac3(0) <= (xnc15( 3) and xnc15( 2) and xnc15( 1) and xnc15( 0));
	
	Ac2(2) <= (xnc11(11) and xnc11(10) and xnc11( 9) and xnc11( 8));
	Ac2(1) <= (xnc11( 7) and xnc11( 6) and xnc11( 5) and xnc11( 4));
	Ac2(0) <= (xnc11( 3) and xnc11( 2) and xnc11( 1) and xnc11( 0));
	
	Ac1(2) <= (xnc7 (11) and xnc7 (10) and xnc7 ( 9) and xnc7 ( 8));
	Ac1(1) <= (xnc7 ( 7) and xnc7 ( 6) and xnc7 ( 5) and xnc7 ( 4));
	Ac1(0) <= (xnc7 ( 3) and xnc7 ( 2) and xnc7 ( 1) and xnc7 ( 0));
	
	Ac0(2) <= (xnc3 (11) and xnc3 (10) and xnc3 ( 9) and xnc3 ( 8));
	Ac0(1) <= (xnc3 ( 7) and xnc3 ( 6) and xnc3 ( 5) and xnc3 ( 4));
	Ac0(0) <= (xnc3 ( 3) and xnc3 ( 2) and xnc3 ( 1) and xnc3 ( 0));
	
	
	Oc3(0) <= Ac3(2) or Ac3(1) or Ac3(0); --Como os digitos n se repetem, basta verificar se alguma das comparacoes 
	Oc2(0) <= Ac2(2) or Ac2(1) or Ac2(0); --de cada digito eh verdadeira para verificar se os digitos são iguais.
	Oc1(0) <= Ac1(2) or Ac1(1) or Ac1(0); --A saida eh colocada em um vetor de 3 bits para possibilitar a soma direta no final,
	Oc0(0) <= Ac0(2) or Ac0(1) or Ac0(0); --ela sempre sera "000" ou "001".
	
	
	E <= Oc3 + Oc2 + Oc1 + Oc0; --Apos avaliar quais dos digitos sao iguais, basta somar para saber quantos digitos sao iguais, ignorando a posição dos mesmos.

end arc_comp;
