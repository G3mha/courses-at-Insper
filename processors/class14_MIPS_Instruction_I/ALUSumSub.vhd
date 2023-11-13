library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- IEEE library for arithmetic functions

entity ALUSumSub is
    generic ( larguraDados : natural := 4 );
    port (
      entradaA, entradaB:  in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      seletor:  in STD_LOGIC;
      saida     : out STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		flag_zero : out std_logic
    );
end entity;

architecture comportamento of ALUSumSub is
   signal soma :      STD_LOGIC_VECTOR((larguraDados-1) downto 0);
   signal subtracao : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
    begin
      soma      <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
      subtracao <= STD_LOGIC_VECTOR(unsigned(entradaA) - unsigned(entradaB));
      saida <= soma when (seletor = '1') else subtracao;
		flag_zero <= '1' when unsigned(saida) = 0 else '0';
end architecture;