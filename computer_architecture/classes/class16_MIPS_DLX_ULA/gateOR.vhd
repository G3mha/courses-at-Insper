library ieee;
use ieee.std_logic_1164.all;

entity gateOR is
  port ( A      : in  std_logic;
         B      : in  std_logic;
         output : out std_logic
  );
end entity;

architecture comportamento of gateOR is

  begin

    output <= A or B;

end architecture;