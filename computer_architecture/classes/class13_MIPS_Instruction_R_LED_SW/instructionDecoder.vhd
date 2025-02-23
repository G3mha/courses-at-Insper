library ieee;
use ieee.std_logic_1164.all;

entity instructionDecoder is
  port ( input : in std_logic_vector(5 downto 0);
         output : out std_logic_vector(1 downto 0)
  );
end entity;

architecture comportamento of instructionDecoder is

  constant SUM  : std_logic_vector(5 downto 0) := "100000";
  constant SUB  : std_logic_vector(5 downto 0) := "100010";

  begin
output <= "11" when input = SUM else
          "10" when input = SUB else
          "00";  -- NOP for unidentified inputs
end architecture;