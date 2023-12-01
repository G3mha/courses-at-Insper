library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
  generic (
	 dataWidth	: natural := 32;
  );

  port (
    input_A, input_B, input_C, input_D : in std_logic_vector((dataWidth-1) downto 0);
    sel : in std_logic_vector(1 downto 0);
    output : out std_logic_vector((dataWidth-1) downto 0)
  );
end entity;

architecture comportamento of mux4x1 is
  begin
    output <= input_D when (sel = "11") else
	              input_C when (sel = "10") else
					  input_B when (sel = "01") else 
					  input_A;
end architecture;
