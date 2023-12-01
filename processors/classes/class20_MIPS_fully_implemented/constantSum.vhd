library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity constantSum is
    generic
    (
        data_width : natural := 32;
        CONST : natural := 4
    );
    port
    (
        entrada: in  STD_LOGIC_VECTOR((data_width-1) downto 0);
        saida:   out STD_LOGIC_VECTOR((data_width-1) downto 0)
    );
end entity;

architecture comportamento of constantSum is
    begin
        saida <= std_logic_vector(unsigned(entrada) + CONST);
end architecture;