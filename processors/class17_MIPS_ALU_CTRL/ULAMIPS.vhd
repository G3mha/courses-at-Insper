library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ULAMIPS is
	generic   (
		data_width  : natural :=  32
	);

	port   (
		-- Input ports
		inputA, inputB : in  std_logic_vector(data_width - 1 downto 0);
		inverteB       : in  std_logic;
		selectMUX      : in  std_logic_vector(1 downto 0);
		
		-- Output ports
		output_ALU     : out std_logic_vector(data_width - 1 downto 0)
	);
end entity;


architecture arch_name of ULAMIPS is

	signal carry_out_0: std_logic;
	signal carry_out_1: std_logic;
	signal carry_out_2: std_logic;
	signal carry_out_3: std_logic;
	signal carry_out_4: std_logic;
	signal carry_out_5: std_logic;
	signal carry_out_6: std_logic;
	signal carry_out_7: std_logic;
	signal carry_out_8: std_logic;
	signal carry_out_9: std_logic;
	signal carry_out_10 : std_logic;
	signal carry_out_11 : std_logic;
	signal carry_out_12 : std_logic;
	signal carry_out_13 : std_logic;
	signal carry_out_14 : std_logic;
	signal carry_out_15 : std_logic;
	signal carry_out_16 : std_logic;
	signal carry_out_17 : std_logic;
	signal carry_out_18 : std_logic;
	signal carry_out_19 : std_logic;
	signal carry_out_20 : std_logic;
	signal carry_out_21 : std_logic;
	signal carry_out_22 : std_logic;
	signal carry_out_23 : std_logic;
	signal carry_out_24 : std_logic;
	signal carry_out_25 : std_logic;
	signal carry_out_26 : std_logic;
	signal carry_out_27 : std_logic;
	signal carry_out_28 : std_logic;
	signal carry_out_29 : std_logic;
	signal carry_out_30 : std_logic;
	signal overflow_out_31 : std_logic;


	begin

	BIT31 : entity work.bitWithOverflow port map (entradaA => inputA(31), entradaB => inputB(31), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_30, overflow => overflow_out_31, saida => output_ALU(31));

	BIT30 : entity work.bit port map (entradaA => inputA(30), entradaB => inputB(30), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_29, carry_out => carry_out_30, saida => output_ALU(30));

	BIT29 : entity work.bit port map (entradaA => inputA(29), entradaB => inputB(29), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_28, carry_out => carry_out_29, saida => output_ALU(29));

	BIT28 : entity work.bit port map (entradaA => inputA(28), entradaB => inputB(28), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_27, carry_out => carry_out_28, saida => output_ALU(28));

	BIT27 : entity work.bit port map (entradaA => inputA(27), entradaB => inputB(27), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_26, carry_out => carry_out_27, saida => output_ALU(27));	

	BIT26 : entity work.bit port map (entradaA => inputA(26), entradaB => inputB(26), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_25, carry_out => carry_out_26, saida => output_ALU(26));

	BIT25 : entity work.bit port map (entradaA => inputA(25), entradaB => inputB(25), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_24, carry_out => carry_out_25, saida => output_ALU(25));

	BIT24 : entity work.bit port map (entradaA => inputA(24), entradaB => inputB(24), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_23, carry_out => carry_out_24, saida => output_ALU(24));

	BIT23 : entity work.bit port map (entradaA => inputA(23), entradaB => inputB(23), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_22, carry_out => carry_out_23, saida => output_ALU(23));

	BIT22 : entity work.bit port map (entradaA => inputA(22), entradaB => inputB(22), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_21, carry_out => carry_out_22, saida => output_ALU(22));

	BIT21 : entity work.bit port map (entradaA => inputA(21), entradaB => inputB(21), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_20, carry_out => carry_out_21, saida => output_ALU(21));

	BIT20 : entity work.bit port map (entradaA => inputA(20), entradaB => inputB(20), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_19, carry_out => carry_out_20, saida => output_ALU(20));

	BIT19 : entity work.bit port map (entradaA => inputA(19), entradaB => inputB(19), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_18, carry_out => carry_out_19, saida => output_ALU(19));

	BIT18 : entity work.bit port map (entradaA => inputA(18), entradaB => inputB(18), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_17, carry_out => carry_out_18, saida => output_ALU(18));

	BIT17 : entity work.bit port map (entradaA => inputA(17), entradaB => inputB(17), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_16, carry_out => carry_out_17, saida => output_ALU(17));

	BIT16 : entity work.bit port map (entradaA => inputA(16), entradaB => inputB(16), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_15, carry_out => carry_out_16, saida => output_ALU(16));

	BIT15 : entity work.bit port map (entradaA => inputA(15), entradaB => inputB(15), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_14, carry_out => carry_out_15, saida => output_ALU(15));

	BIT14 : entity work.bit port map (entradaA => inputA(14), entradaB => inputB(14), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_13, carry_out => carry_out_14, saida => output_ALU(14));

	BIT13 : entity work.bit port map (entradaA => inputA(13), entradaB => inputB(13), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_12, carry_out => carry_out_13, saida => output_ALU(13));

	BIT12 : entity work.bit port map (entradaA => inputA(12), entradaB => inputB(12), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_11, carry_out => carry_out_12, saida => output_ALU(12));

	BIT11 : entity work.bit port map (entradaA => inputA(11), entradaB => inputB(11), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_10, carry_out => carry_out_11, saida => output_ALU(11));

	BIT10 : entity work.bit port map (entradaA => inputA(10), entradaB => inputB(10), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_9, carry_out => carry_out_10, saida => output_ALU(10));

	BIT9 : entity work.bit port map (entradaA => inputA(9), entradaB => inputB(9), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_8, carry_out => carry_out_9, saida => output_ALU(9));

	BIT8 : entity work.bit port map (entradaA => inputA(8), entradaB => inputB(8), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_7, carry_out => carry_out_8, saida => output_ALU(8));

	BIT7 : entity work.bit port map (entradaA => inputA(7), entradaB => inputB(7), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_6, carry_out => carry_out_7, saida => output_ALU(7));

	BIT6 : entity work.bit port map (entradaA => inputA(6), entradaB => inputB(6), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_5, carry_out => carry_out_6, saida => output_ALU(6));

	BIT5 : entity work.bit port map (entradaA => inputA(5), entradaB => inputB(5), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_4, carry_out => carry_out_5, saida => output_ALU(5));

	BIT4 : entity work.bit port map (entradaA => inputA(4), entradaB => inputB(4), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_3, carry_out => carry_out_4, saida => output_ALU(4));

	BIT3 : entity work.bit port map (entradaA => inputA(3), entradaB => inputB(3), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_2, carry_out => carry_out_3, saida => output_ALU(3));

	BIT2 : entity work.bit port map (entradaA => inputA(2), entradaB => inputB(2), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_1, carry_out => carry_out_2, saida => output_ALU(2));

	BIT1 : entity work.bit port map (entradaA => inputA(1), entradaB => inputB(1), slt => '0', inverteB => inverteB, selMUX => selectMUX, carry_in => carry_out_0, carry_out => carry_out_1, saida => output_ALU(1));

	BIT0 : entity work.bit port map (entradaA => inputA(0), entradaB => inputB(0), slt => overflow_out_31, inverteB => inverteB, selMUX => selectMUX, carry_in => inverteB, carry_out => carry_out_0, saida => output_ALU(0));

end architecture;