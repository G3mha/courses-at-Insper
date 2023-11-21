library ieee;
use ieee.std_logic_1164.all;

entity gateNOT is
  port ( A      : in  std_logic;
         output : out std_logic
  );
end entity;

architecture comportamento of gateNOT is

  begin

    output <= not A;

end architecture;