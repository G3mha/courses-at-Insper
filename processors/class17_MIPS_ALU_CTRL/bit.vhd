library ieee;
use ieee.std_logic_1164.all;

entity bit is
  port (
    entradaA, entradaB, slt, inverteB, carry_in : in std_logic;
	 selMUX : in std_logic_vector(1 downto 0);
    carry_out, saida : out std_logic
  );
end entity;

architecture comportamento of bit is

    signal entradaB_invertida : std_logic;
    signal mux_not_out : std_logic;
    signal and_out : std_logic;
    signal or_out : std_logic;
    signal adder_out : std_logic;

  begin
    
    gateNOT : entity work.gateNOT port map (A => entradaB, output => entradaB_invertida);
    
    MUX_NOT : entity work.mux2x1_1_bit port map (input_A => entradaB, input_B => entradaB_invertida, sel => inverteB, output => mux_not_out);

    gateAND : entity work.gateAND port map (A => entradaA, B => mux_not_out, output => and_out);

    gateOR  : entity work.gateOR port map (A => entradaA, B => mux_not_out, output => or_out);

    ADDER   : entity work.bitAdder port map (entradaA => entradaA, entradaB => mux_not_out, carry_in => carry_in, carry_out => carry_out, saida => adder_out);

    MUX_OUT : entity work.mux4x1_1_bit port map (input_A => and_out, input_B => or_out, input_C => adder_out, input_D => slt, sel => selMUX, output => saida);

end architecture;
