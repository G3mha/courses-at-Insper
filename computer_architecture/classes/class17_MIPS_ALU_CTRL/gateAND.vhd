library ieee;
use ieee.std_logic_1164.all;

entity gateAND is
  port ( A      : in  std_logic;
         B      : in  std_logic;
         output : out std_logic
  );
end entity;

architecture comportamento of gateAND is

  begin

    output <= A and B;

end architecture;