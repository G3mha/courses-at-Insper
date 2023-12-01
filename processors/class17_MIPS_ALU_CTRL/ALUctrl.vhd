library ieee;
use ieee.std_logic_1164.all;

entity ALUctrl is
  port ( opcode : in  std_logic_vector(5  downto 0);
         funct  : in  std_logic_vector(5  downto 0);
			type_R    : in  std_logic;
         output   : out std_logic_vector(3 downto 0)
  );
end entity;

architecture comportamento of ALUctrl is

  -- type I
  constant LW   : std_logic_vector(5 downto 0) := "100011";
  constant SW   : std_logic_vector(5 downto 0) := "101011";
  constant BEQ  : std_logic_vector(5 downto 0) := "000100";
  
  -- type R
  constant ANDr : std_logic_vector(5 downto 0) := "100100";
  constant ORr  : std_logic_vector(5 downto 0) := "100101";
  constant SLT  : std_logic_vector(5 downto 0) := "101010";
  constant SUM  : std_logic_vector(5 downto 0) := "100000";
  constant SUB  : std_logic_vector(5 downto 0) := "100010";
  
  -- type J
  constant JMP  : std_logic_vector(5 downto 0) := "000010";
  
  
  signal mux_out : std_logic_vector(5 downto 0);
  
  begin

	MUX_CTRL_ALU : entity work.mux2x1 generic map (dataWidth => 6)
		 					   port map(input_A => opcode, input_B => funct, sel => type_R, output => mux_out);

  output <=  "0000" when (mux_out = ANDr) else
             "0001" when (mux_out = ORr ) else
				 "0010" when (mux_out = SUM ) else
				 "0110" when (mux_out = SUB ) else
				 "0111" when (mux_out = SLT ) else
				 "0010" when (mux_out = LW  ) else
				 "0010" when (mux_out = SW  ) else
				 "0110" when (mux_out = BEQ ) else
				 "1111" when (mux_out = JMP ) else
	          "1111";  -- NOP for unidentified inputs

end architecture;




