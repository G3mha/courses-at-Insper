library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALUMIPS is
	generic   (
		data_width  : natural :=  32
	);

	port   (
		input_A, input_B : in  std_logic_vector(data_width - 1 downto 0);
		operation        : in  std_logic_vector(3 downto 0);
		
		flag_zero        : out std_logic;
		output           : out std_logic_vector(data_width - 1 downto 0)
	);
end entity;


architecture arch_name of ALUMIPS is

	signal carry_out_0     : std_logic;
	signal carry_out_1     : std_logic;
	signal carry_out_2     : std_logic;
	signal carry_out_3     : std_logic;
	signal carry_out_4     : std_logic;
	signal carry_out_5     : std_logic;
	signal carry_out_6     : std_logic;
	signal carry_out_7     : std_logic;
	signal carry_out_8     : std_logic;
	signal carry_out_9     : std_logic;
	signal carry_out_10    : std_logic;
	signal carry_out_11    : std_logic;
	signal carry_out_12    : std_logic;
	signal carry_out_13    : std_logic;
	signal carry_out_14    : std_logic;
	signal carry_out_15    : std_logic;
	signal carry_out_16    : std_logic;
	signal carry_out_17    : std_logic;
	signal carry_out_18    : std_logic;
	signal carry_out_19    : std_logic;
	signal carry_out_20    : std_logic;
	signal carry_out_21    : std_logic;
	signal carry_out_22    : std_logic;
	signal carry_out_23    : std_logic;
	signal carry_out_24    : std_logic;
	signal carry_out_25    : std_logic;
	signal carry_out_26    : std_logic;
	signal carry_out_27    : std_logic;
	signal carry_out_28    : std_logic;
	signal carry_out_29    : std_logic;
	signal carry_out_30    : std_logic;
	signal overflow_out_31 : std_logic;
	signal inverte_B       : std_logic;
	signal sel_MUX         : std_logic_vector(1 downto 0);
	signal zero            : std_logic_vector(data_width-1 downto 0) := (others=>'0');
	
	begin

    inverte_B <= operation(2);
	sel_MUX   <= operation(1 downto 0);

	BIT31 : entity work.bitWithOverflow port map (entradaA => input_A(31), entradaB => input_B(31), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_30, overflow => overflow_out_31, saida => output(31));

	BIT30 : entity work.bit port map (entradaA => input_A(30), entradaB => input_B(30), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_29, carry_out => carry_out_30, saida => output(30));

	BIT29 : entity work.bit port map (entradaA => input_A(29), entradaB => input_B(29), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_28, carry_out => carry_out_29, saida => output(29));

	BIT28 : entity work.bit port map (entradaA => input_A(28), entradaB => input_B(28), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_27, carry_out => carry_out_28, saida => output(28));

	BIT27 : entity work.bit port map (entradaA => input_A(27), entradaB => input_B(27), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_26, carry_out => carry_out_27, saida => output(27));	

	BIT26 : entity work.bit port map (entradaA => input_A(26), entradaB => input_B(26), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_25, carry_out => carry_out_26, saida => output(26));

	BIT25 : entity work.bit port map (entradaA => input_A(25), entradaB => input_B(25), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_24, carry_out => carry_out_25, saida => output(25));

	BIT24 : entity work.bit port map (entradaA => input_A(24), entradaB => input_B(24), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_23, carry_out => carry_out_24, saida => output(24));

	BIT23 : entity work.bit port map (entradaA => input_A(23), entradaB => input_B(23), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_22, carry_out => carry_out_23, saida => output(23));

	BIT22 : entity work.bit port map (entradaA => input_A(22), entradaB => input_B(22), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_21, carry_out => carry_out_22, saida => output(22));

	BIT21 : entity work.bit port map (entradaA => input_A(21), entradaB => input_B(21), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_20, carry_out => carry_out_21, saida => output(21));

	BIT20 : entity work.bit port map (entradaA => input_A(20), entradaB => input_B(20), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_19, carry_out => carry_out_20, saida => output(20));

	BIT19 : entity work.bit port map (entradaA => input_A(19), entradaB => input_B(19), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_18, carry_out => carry_out_19, saida => output(19));

	BIT18 : entity work.bit port map (entradaA => input_A(18), entradaB => input_B(18), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_17, carry_out => carry_out_18, saida => output(18));

	BIT17 : entity work.bit port map (entradaA => input_A(17), entradaB => input_B(17), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_16, carry_out => carry_out_17, saida => output(17));

	BIT16 : entity work.bit port map (entradaA => input_A(16), entradaB => input_B(16), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_15, carry_out => carry_out_16, saida => output(16));

	BIT15 : entity work.bit port map (entradaA => input_A(15), entradaB => input_B(15), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_14, carry_out => carry_out_15, saida => output(15));

	BIT14 : entity work.bit port map (entradaA => input_A(14), entradaB => input_B(14), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_13, carry_out => carry_out_14, saida => output(14));

	BIT13 : entity work.bit port map (entradaA => input_A(13), entradaB => input_B(13), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_12, carry_out => carry_out_13, saida => output(13));

	BIT12 : entity work.bit port map (entradaA => input_A(12), entradaB => input_B(12), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_11, carry_out => carry_out_12, saida => output(12));

	BIT11 : entity work.bit port map (entradaA => input_A(11), entradaB => input_B(11), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_10, carry_out => carry_out_11, saida => output(11));

	BIT10 : entity work.bit port map (entradaA => input_A(10), entradaB => input_B(10), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_9, carry_out => carry_out_10, saida => output(10));

	BIT9 : entity work.bit port map (entradaA => input_A(9), entradaB => input_B(9), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_8, carry_out => carry_out_9, saida => output(9));

	BIT8 : entity work.bit port map (entradaA => input_A(8), entradaB => input_B(8), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_7, carry_out => carry_out_8, saida => output(8));

	BIT7 : entity work.bit port map (entradaA => input_A(7), entradaB => input_B(7), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_6, carry_out => carry_out_7, saida => output(7));

	BIT6 : entity work.bit port map (entradaA => input_A(6), entradaB => input_B(6), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_5, carry_out => carry_out_6, saida => output(6));

	BIT5 : entity work.bit port map (entradaA => input_A(5), entradaB => input_B(5), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_4, carry_out => carry_out_5, saida => output(5));

	BIT4 : entity work.bit port map (entradaA => input_A(4), entradaB => input_B(4), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_3, carry_out => carry_out_4, saida => output(4));

	BIT3 : entity work.bit port map (entradaA => input_A(3), entradaB => input_B(3), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_2, carry_out => carry_out_3, saida => output(3));

	BIT2 : entity work.bit port map (entradaA => input_A(2), entradaB => input_B(2), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_1, carry_out => carry_out_2, saida => output(2));

	BIT1 : entity work.bit port map (entradaA => input_A(1), entradaB => input_B(1), slt => '0', inverteB => inverte_B, selMUX => sel_MUX, carry_in => carry_out_0, carry_out => carry_out_1, saida => output(1));

	BIT08 : entity work.bit port map (entradaA => input_A(0), entradaB => input_B(0), slt => overflow_out_31, inverteB => inverte_B, selMUX => sel_MUX, carry_in => inverte_B, carry_out => carry_out_0, saida => output(0));

    flag_zero <= '1' when (output = zero) else '0';

end architecture;