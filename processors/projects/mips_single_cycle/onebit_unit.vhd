library ieee;
use ieee.std_logic_1164.all;

entity onebit_unit is
  port (
    A, B, slt, inverteA, inverteB, carry_in : in std_logic;
    sel : in std_logic_vector(1 downto 0);
    carry_out, output : out std_logic
  );
end entity;

architecture comportamento of onebit_unit is
  signal mux_not_a_out : std_logic;
  signal mux_not_b_out : std_logic;
  signal adder_out     : std_logic;
  begin
    MUX_NOT_A : entity work.onebit_mux_2x1 port map (A => A, B => not(A), sel => inverteA, output => mux_not_a_out);
    MUX_NOT_B : entity work.onebit_mux_2x1 port map (A => B, B => not(B), sel => inverteB, output => mux_not_b_out);
    ADDER     : entity work.onebit_adder port map (A => mux_not_a_out, B => mux_not_b_out, carry_in => carry_in, carry_out => carry_out, output => adder_out);
    MUX_OUT   : entity work.onebit_mux_4x1 port map (A => (mux_not_a_out and mux_not_b_out), B => (mux_not_a_out or mux_not_b_out), C => adder_out, D => slt, sel => sel, output => output);
end architecture;
