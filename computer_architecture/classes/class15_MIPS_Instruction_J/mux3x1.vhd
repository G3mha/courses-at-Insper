library ieee;
use ieee.std_logic_1164.all;

entity mux3x1 is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 8);
  port (
    input_A, input_B, input_C : in std_logic_vector((larguraDados-1) downto 0);
    sel : in std_logic_vector(1 downto 0);
    output : out std_logic_vector((larguraDados-1) downto 0)
  );
end entity;

architecture comportamento of mux3x1 is
  begin
    output <= input_C when (sel = "10") else 
	           input_B when (sel = "01") else
				  input_A;
end architecture;
