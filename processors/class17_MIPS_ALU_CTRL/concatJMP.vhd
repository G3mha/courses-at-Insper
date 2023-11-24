library ieee;
use ieee.std_logic_1164.all;

entity concatJMP is
  port ( immediate : in  std_logic_vector(25 downto 0);
         pc_plus_4 : in  std_logic_vector(31 downto 0);
         output    : out std_logic_vector(31 downto 0)
  );
end entity;

architecture comportamento of concatJMP is

  begin

    output <= pc_plus_4(31 downto 28) & immediate & "00";

end architecture;