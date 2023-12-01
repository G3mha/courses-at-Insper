library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topLevel is
  port   (
    -- Input ports
    dataIN  :  in  std_logic_vector(9 downto 0);
    dataOUT :  out  std_logic_vector(7 downto 0)
 );
end entity;


architecture topLevel of topLevel is

begin

MemoriaROM : entity work.memoriaROM port map (Endereco => dataIN, Dado => dataOUT);
end architecture;
