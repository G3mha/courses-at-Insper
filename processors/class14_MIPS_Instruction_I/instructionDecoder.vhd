library ieee;
use ieee.std_logic_1164.all;

entity instructionDecoder is
  port ( input : in std_logic_vector(5 downto 0);
         output : out std_logic_vector(5 downto 0)
  );
end entity;

architecture comportamento of instructionDecoder is

  constant LW  : std_logic_vector(5 downto 0) := "100011";
  constant SW  : std_logic_vector(5 downto 0) := "101011";
  constant BEQ : std_logic_vector(5 downto 0) := "000100";  
  
  begin
  output <= "011001" when input = SW  else
				"111010" when input = LW  else
				"000100" when input = BEQ else
				"000000";  -- NOP for unidentified inputs
end architecture;