library ieee;
use ieee.std_logic_1164.all;

entity bitWithOverflow is
  port (
    entradaA, entradaB, slt, inverteB, carry_in : in std_logic;
	 selMUX : in std_logic_vector(1 downto 0);
    overflow, saida : out std_logic
  );
end entity;

architecture comportamento of bitWithOverflow is

    signal entradaB_invertida : std_logic;
    signal mux_not_out : std_logic;
    signal and_out : std_logic;
    signal or_out : std_logic;
    signal adder_out : std_logic;
    signal carry_out : std_logic;
    signal xor1_out : std_logic;

  begin
    
    gateNOT : entity work.gateNOT port map (A => entradaB, output => entradaB_invertida);
    
    MUX_NOT : entity work.mux2x1 port map (entradaA_MUX => entradaB, entradaB_MUX => entradaB_invertida, seletor_MUX => inverteB, saida_MUX => mux_not_out);

    gateAND : entity work.gateAND port map (A => entradaA, B => mux_not_out, output => and_out);

    gateOR  : entity work.gateOR port map (A => entradaA, B => mux_not_out, output => or_out);

    ADDER   : entity work.genericAdder port map (entradaA => entradaA, entradaB => mux_not_out, carry_in => carry_in, carry_out => carry_out, saida => adder_out);

    MUX_OUT : entity work.mux4x1 port map (entradaA_MUX => and_out, entradaB_MUX => or_out, entradaC_MUX => adder_out, entradaD_MUX => slt, seletor_MUX => selMUX, saida_MUX => saida);

    gateXOR1 : entity work.gateXOR port map (A => carry_out, B => carry_in, output => xor1_out);
    
    gateXOR2 : entity work.gateXOR port map (A => xor1_out, B => adder_out, output => overflow);

end architecture;
