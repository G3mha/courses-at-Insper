library ieee;
use ieee.std_logic_1164.all;

entity instructionDecoder is
  port ( opcode_i : in  std_logic_vector(5  downto 0);
         funct_i  : in  std_logic_vector(5  downto 0);
         output   : out std_logic_vector(11 downto 0)
  );
end entity;

architecture comportamento of instructionDecoder is

  constant LW  : std_logic_vector(5 downto 0) := "100011";
  constant SW  : std_logic_vector(5 downto 0) := "101011";
  constant BEQ : std_logic_vector(5 downto 0) := "000100";  
  constant SUM : std_logic_vector(5 downto 0) := "100000";
  constant SUB : std_logic_vector(5 downto 0) := "100010";
  constant JMP : std_logic_vector(5 downto 0) := "000010";
  
  begin
	
	output <= "011000010000" when (opcode_i = "000000" and funct_i  = SUM) else
	          "011000000000" when (opcode_i = "000000" and funct_i  = SUB) else
				 "000100010001" when (opcode_i =  SW) else
				 "001100011010" when (opcode_i =  LW) else
				 "000100000100" when (opcode_i = BEQ) else
				 "100000000000" when (opcode_i = JMP) else
				 "000000000000";  -- NOP for unidentified inputs

end architecture;




