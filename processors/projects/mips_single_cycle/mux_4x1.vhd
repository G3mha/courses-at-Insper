library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is
  generic (
	 data_width	: natural := 32
  );

  port (
    A, B, C, D : in std_logic_vector((data_width-1) downto 0);
    sel : in std_logic_vector(1 downto 0);
    output : out std_logic_vector((data_width-1) downto 0)
  );
end entity;

architecture comportamento of mux_4x1 is
  begin
    output <= D when (sel = "11") else 
              C when (sel = "10") else
              B when (sel = "01") else
              A;
end architecture;
