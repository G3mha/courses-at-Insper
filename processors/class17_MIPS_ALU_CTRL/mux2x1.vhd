library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
  generic (
	 dataWidth	: natural := 32
  );

  port (
    input_A, input_B : in std_logic_vector((dataWidth-1) downto 0);
    sel : in std_logic;
    output : out std_logic_vector((dataWidth-1) downto 0)
  );
end entity;

architecture comportamento of mux2x1 is
  begin
    output <= input_B when (sel = '1') else input_A;
end architecture;
