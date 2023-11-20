library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- IEEE library for arithmetic functions

entity ALUSumSub is
    generic ( larguraDados : natural := 4 );
    port (
      entradaA, entradaB : in  std_logic_vector((larguraDados-1) downto 0);
      selector           : in  std_logic_vector(3 downto 0);
      saida              : out std_logic_vector((larguraDados-1) downto 0);
		flag_zero          : out std_logic
    );
end entity;

architecture comportamento of ALUSumSub is
   signal soma      : std_logic_vector((larguraDados-1) downto 0);
   signal subtracao : std_logic_vector((larguraDados-1) downto 0);
    begin
      soma      <= std_logic_vector(unsigned(entradaA) + unsigned(entradaB));
      subtracao <= std_logic_vector(unsigned(entradaA) - unsigned(entradaB));
      saida <= soma when (selector = "0001") else subtracao;
		flag_zero <= '1' when unsigned(saida) = 0 else '0';
end architecture;