library ieee;
use ieee.std_logic_1164.all;

entity instructionDecoder is
  port ( opcode_i : in  std_logic_vector(5  downto 0);
         funct_i  : in  std_logic_vector(5  downto 0);
         output   : out std_logic_vector(10 downto 0)
  );
end entity;

architecture comportamento of instructionDecoder is

  constant LW  : std_logic_vector(5 downto 0) := "100011";
  constant SW  : std_logic_vector(5 downto 0) := "101011";
  constant BEQ : std_logic_vector(5 downto 0) := "000100";  
  constant SUM : std_logic_vector(5 downto 0) := "100000";
  constant SUB : std_logic_vector(5 downto 0) := "100010";
  
  signal it : std_logic; -- R = 1 and I = 0
  
  begin
	
	it <= '1' when (opcode_i = "000000") else '0';
	
	output <= "11000010000" when (funct_i  = SUM and it = '1') else
	          "11000000000" when (funct_i  = SUB and it = '1') else
				 "00100010001" when (opcode_i = SW  and it = '0') else
				 "01100011010" when (opcode_i = LW  and it = '0') else
				 "00100000100" when (opcode_i = BEQ and it = '0') else
				 "00000000000";  -- NOP for unidentified inputs

end architecture;




