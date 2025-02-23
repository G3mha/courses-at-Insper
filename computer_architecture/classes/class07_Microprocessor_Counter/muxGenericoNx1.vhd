LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity muxGenericoNx1 is
  generic ( larguraEntrada : natural := 16;
        larguraSelecao : natural := 4;
        invertido : boolean := FALSE);
  port (
    entrada_MUX : in  std_logic_vector(larguraEntrada-1 downto 0);
    seletor_MUX : in  std_logic_vector(larguraSelecao-1 downto 0);
    saida_MUX   : out std_logic
  );
end entity;

architecture Behavioral of muxGenericoNx1 is
begin
tipo: if invertido generate
    saida_MUX <= entrada_MUX((larguraEntrada-1) - to_integer(unsigned(seletor_MUX)));
  else generate
    saida_MUX <= entrada_MUX(to_integer(unsigned(seletor_MUX)));
  end generate;
end architecture;
