library ieee;
use ieee.std_logic_1164.all;

entity 1bit_mux_2x1 is
  generic (
	 dataWidth	: natural := 32
  );

  port (
    A, B : in std_logic;
    sel : in std_logic;
    output : out std_logic
  );
end entity;

architecture comportamento of 1bit_mux_2x1 is
  begin
    output <= B when (sel = '1') else 
              A;
end architecture;
