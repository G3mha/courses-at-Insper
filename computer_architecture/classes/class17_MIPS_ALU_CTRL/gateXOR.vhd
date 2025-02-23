library ieee;
use ieee.std_logic_1164.all;

entity gateXOR is
  port (
    A      : in  std_logic;
    B      : in  std_logic;
    output : out std_logic
  );
end entity;

architecture comportamento of gateXOR is
begin
  output <= A xor B;
end architecture;
