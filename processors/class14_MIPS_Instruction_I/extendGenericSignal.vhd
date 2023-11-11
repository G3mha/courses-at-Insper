library ieee;
use ieee.std_logic_1164.all;

entity extendGenericSignal is
    generic
    (
        larguraDadoEntrada : natural  :=    16;
        larguraDadoSaida   : natural  :=    32
    );
    port
    (
        input  : in  std_logic_vector(larguraDadoEntrada-1 downto 0);
        output : out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
end entity;

architecture comportamento of extendGenericSignal is
begin

    output <= (larguraDadoSaida-1 downto larguraDadoEntrada => input(larguraDadoEntrada-1) ) & input;

end architecture;
