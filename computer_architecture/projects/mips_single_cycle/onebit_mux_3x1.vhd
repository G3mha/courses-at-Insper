library ieee;
use ieee.std_logic_1164.all;

entity onebit_mux_3x1 is
  generic (
	 dataWidth	: natural := 32
  );

  port (
    A, B, C : in std_logic;
    sel : in std_logic_vector(1 downto 0);
    output : out std_logic
  );
end entity;

architecture comportamento of onebit_mux_3x1 is
  begin
    output <= C when (sel = "10") else 
              B when (sel = "01") else 
              A;
end architecture;
