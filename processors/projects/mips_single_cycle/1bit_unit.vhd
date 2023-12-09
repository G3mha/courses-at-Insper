library ieee;
use ieee.std_logic_1164.all;

entity 1bit_unit is
  port (
    A, B, slt, inverteB, carry_in : in std_logic;
    sel : in std_logic_vector(1 downto 0);
    carry_out, output : out std_logic
  );
end entity;

architecture comportamento of 1bit_unit is
    signal mux_not_out : std_logic;
    signal adder_out : std_logic;
  begin
    MUX_NOT : entity work.1bit_mux_2x1 port map (A => B, B => not(B), sel => inverteB, output => mux_not_out);
    ADDER   : entity work.1bit_adder port map (A => A, B => mux_not_out, carry_in => carry_in, carry_out => carry_out, output => adder_out);
    MUX_OUT : entity work.1bit_mux_4x1 port map (A => (A and mux_not_out), B => (A or mux_not_out), C => adder_out, D => slt, sel => sel, output => output);
end architecture;
