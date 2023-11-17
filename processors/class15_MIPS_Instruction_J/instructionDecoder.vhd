library ieee;
use ieee.std_logic_1164.all;

entity instructionDecoder is
  port ( input_opcode : in  std_logic_vector(5 downto 0);
         input_funct  : in  std_logic_vector(5 downto 0);
         output       : out std_logic_vector(5 downto 0)
  );
end entity;

architecture comportamento of instructionDecoder is

  constant LW  : std_logic_vector(5 downto 0) := "100011";
  constant SW  : std_logic_vector(5 downto 0) := "101011";
  constant BEQ : std_logic_vector(5 downto 0) := "000100";  
  constant SUM : std_logic_vector(5 downto 0) := "100000";
  constant SUB : std_logic_vector(5 downto 0) := "100010";
  
  begin
  if (input_opcode = "000000") then
    output <= "" when input_funct = SUM else
              "" when input_funct = SUB else
              "000000";  -- NOP for unidentified inputs
  else
    output <= "" when input = SW else
              "" when input = LW else
              "" when input = BEQ else
              "000000";  -- NOP for unidentified inputs
  end if;
end architecture;