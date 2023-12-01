library ieee;
use ieee.std_logic_1164.all;

entity shiftLeft2 is
  port ( input  : in  std_logic_vector(31 downto 0);
         output : out std_logic_vector(31 downto 0)
  );
end entity;

architecture comportamento of shiftLeft2 is

  begin

    output <= input(29 downto 0) & "00";

end architecture;