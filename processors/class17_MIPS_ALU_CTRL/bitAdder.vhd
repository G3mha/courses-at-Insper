library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- IEEE library for arithmetic functions

entity bitAdder is
    port
    (
        entradaA, entradaB, carry_in : in std_logic;
        carry_out, saida : out std_logic
    );
end entity;

architecture comportamento of bitAdder is
    signal xor1_out, and1_out, and2_out : std_logic;
    begin
        AND1 : entity work.gateAND port map (A => entradaA, B => entradaB, output => and1_out);
        XOR1 : entity work.gateXOR port map (A => entradaA, B => entradaB, output => xor1_out);
        AND2 : entity work.gateAND port map (A => xor1_out, B => carry_in, output => and2_out);
        OR1  : entity work.gateOR port map (A => and1_out, B => and2_out, output => carry_out);
        XOR2 : entity work.gateXOR port map (A => carry_in, B => xor1_out, output => saida);
end architecture;