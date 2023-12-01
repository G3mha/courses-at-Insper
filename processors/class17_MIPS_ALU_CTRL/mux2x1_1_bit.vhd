library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_1_bit is
  generic (
	 dataWidth	: natural := 32
  );

  port (
    input_A, input_B : in std_logic;
    sel : in std_logic;
    output : out std_logic
  );
end entity;

architecture comportamento of mux2x1_1_bit is
  begin
    output <= input_B when (sel = '1') else input_A;
end architecture;
