library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- IEEE library for arithmetic functions

entity genericAdder is
    generic
    (
        larguraDados : natural := 32
    );
    port
    (
        entradaA, entradaB: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
        saida:  out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
    );
end entity;

architecture comportamento of genericAdder is
    begin
        saida <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
end architecture;