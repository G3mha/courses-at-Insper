library ieee;
use ieee.std_logic_1164.all;

entity instructionDecoder is
  port ( opcode : in  std_logic_vector(5  downto 0);
         funct  : in  std_logic_vector(5  downto 0);
         output : out std_logic_vector(11 downto 0);
      );
end entity;

architecture comportamento of instructionDecoder is

  constant LW   : std_logic_vector(5 downto 0) := "100011"; -- 23
  constant SW   : std_logic_vector(5 downto 0) := "101011"; -- 2b
  constant BEQ  : std_logic_vector(5 downto 0) := "000100"; -- 04
  constant BNE  : std_logic_vector(5 downto 0) := "000101"; -- 05
  constant ADDr : std_logic_vector(5 downto 0) := "100000"; -- 20
  constant ADDi : std_logic_vector(5 downto 0) := "001000"; -- 08
  constant SUBr : std_logic_vector(5 downto 0) := "100010"; -- 22
  constant ORr  : std_logic_vector(5 downto 0) := "100101"; -- 25
  constant ORi  : std_logic_vector(5 downto 0) := "001101"; -- 0d
  constant ANDr : std_logic_vector(5 downto 0) := "100100"; -- 24
  constant ANDi : std_logic_vector(5 downto 0) := "001100"; -- 0c
  constant JMP  : std_logic_vector(5 downto 0) := "000010"; -- 02
  constant JAL  : std_logic_vector(5 downto 0) := "000011"; -- 03
  constant JR   : std_logic_vector(5 downto 0) := "001000"; -- 08
  constant LUI  : std_logic_vector(5 downto 0) := "001111"; -- 0f
  constant SLT  : std_logic_vector(5 downto 0) := "101010"; -- 2a
  constant SLTi : std_logic_vector(5 downto 0) := "001010"; -- 0a
  
  begin
	
	output <= "011000010000" when (opcode_i = "000000" and funct_i  = SUM) else
	          "011000000000" when (opcode_i = "000000" and funct_i  = SUB) else
				 "000100010001" when (opcode_i =  SW) else
				 "001100011010" when (opcode_i =  LW) else
				 "000100000100" when (opcode_i = BEQ) else
				 "100000000000" when (opcode_i = JMP) else
				 "000000000000";  -- NOP for unidentified inputs
				 
	typeR <= '1' when (opcode_i = "000000") else '0';

end architecture;




