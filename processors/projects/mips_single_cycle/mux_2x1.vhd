library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is
  generic (
	 data_width	: natural := 32
  );

  port (
    A, B : in std_logic_vector((data_width-1) downto 0);
    sel : in std_logic;
    output : out std_logic_vector((data_width-1) downto 0)
  );
end entity;

architecture comportamento of mux_2x1 is
  begin
    output <= B when (sel = '1') else
              A;
end architecture;
