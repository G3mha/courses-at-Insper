library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALUMIPS is
    generic   (
        data_width  : natural :=  32
    );

    port   (
        A, B      : in  std_logic_vector(data_width - 1 downto 0);
        operation : in  std_logic_vector(3 downto 0);
        flag_zero : out std_logic;
        output    : out std_logic_vector(data_width - 1 downto 0)
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
    signal inverteA        : std_logic;
    signal inverteB        : std_logic;
    signal sel_mux         : std_logic_vector(1 downto 0);
    signal zero            : std_logic_vector(data_width-1 downto 0) := (others => '0');
    begin

    inverteA <= operation(3);
    inverteB <= operation(2);
    sel_mux  <= operation(1 downto 0);

    BIT31 : entity work.onebit_unit_overflow port map (entradaA => A(31), entradaB => B(31), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_30, overflow => overflow_out_31, output => output(31));

    BIT30 : entity work.onebit_unit port map (entradaA => A(30), entradaB => B(30), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_29, carry_out => carry_out_30, output => output(30));

    BIT29 : entity work.onebit_unit port map (entradaA => A(29), entradaB => B(29), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_28, carry_out => carry_out_29, output => output(29));

    BIT28 : entity work.onebit_unit port map (entradaA => A(28), entradaB => B(28), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_27, carry_out => carry_out_28, output => output(28));

    BIT27 : entity work.onebit_unit port map (entradaA => A(27), entradaB => B(27), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_26, carry_out => carry_out_27, output => output(27));    

    BIT26 : entity work.onebit_unit port map (entradaA => A(26), entradaB => B(26), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_25, carry_out => carry_out_26, output => output(26));

    BIT25 : entity work.onebit_unit port map (entradaA => A(25), entradaB => B(25), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_24, carry_out => carry_out_25, output => output(25));

    BIT24 : entity work.onebit_unit port map (entradaA => A(24), entradaB => B(24), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_23, carry_out => carry_out_24, output => output(24));

    BIT23 : entity work.onebit_unit port map (entradaA => A(23), entradaB => B(23), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_22, carry_out => carry_out_23, output => output(23));

    BIT22 : entity work.onebit_unit port map (entradaA => A(22), entradaB => B(22), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_21, carry_out => carry_out_22, output => output(22));

    BIT21 : entity work.onebit_unit port map (entradaA => A(21), entradaB => B(21), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_20, carry_out => carry_out_21, output => output(21));

    BIT20 : entity work.onebit_unit port map (entradaA => A(20), entradaB => B(20), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_19, carry_out => carry_out_20, output => output(20));

    BIT19 : entity work.onebit_unit port map (entradaA => A(19), entradaB => B(19), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_18, carry_out => carry_out_19, output => output(19));

    BIT18 : entity work.onebit_unit port map (entradaA => A(18), entradaB => B(18), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_17, carry_out => carry_out_18, output => output(18));

    BIT17 : entity work.onebit_unit port map (entradaA => A(17), entradaB => B(17), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_16, carry_out => carry_out_17, output => output(17));

    BIT16 : entity work.onebit_unit port map (entradaA => A(16), entradaB => B(16), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_15, carry_out => carry_out_16, output => output(16));

    BIT15 : entity work.onebit_unit port map (entradaA => A(15), entradaB => B(15), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_14, carry_out => carry_out_15, output => output(15));

    BIT14 : entity work.onebit_unit port map (entradaA => A(14), entradaB => B(14), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_13, carry_out => carry_out_14, output => output(14));

    BIT13 : entity work.onebit_unit port map (entradaA => A(13), entradaB => B(13), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_12, carry_out => carry_out_13, output => output(13));

    BIT12 : entity work.onebit_unit port map (entradaA => A(12), entradaB => B(12), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_11, carry_out => carry_out_12, output => output(12));

    BIT11 : entity work.onebit_unit port map (entradaA => A(11), entradaB => B(11), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_10, carry_out => carry_out_11, output => output(11));

    BIT10 : entity work.onebit_unit port map (entradaA => A(10), entradaB => B(10), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_9, carry_out => carry_out_10, output => output(10));

    BIT09 : entity work.onebit_unit port map (entradaA => A(9), entradaB => B(9), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_8, carry_out => carry_out_9, output => output(9));

    BIT08 : entity work.onebit_unit port map (entradaA => A(8), entradaB => B(8), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_7, carry_out => carry_out_8, output => output(8));

    BIT07 : entity work.onebit_unit port map (entradaA => A(7), entradaB => B(7), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_6, carry_out => carry_out_7, output => output(7));

    BIT06 : entity work.onebit_unit port map (entradaA => A(6), entradaB => B(6), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_5, carry_out => carry_out_6, output => output(6));

    BIT05 : entity work.onebit_unit port map (entradaA => A(5), entradaB => B(5), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_4, carry_out => carry_out_5, output => output(5));

    BIT04 : entity work.onebit_unit port map (entradaA => A(4), entradaB => B(4), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_3, carry_out => carry_out_4, output => output(4));

    BIT03 : entity work.onebit_unit port map (entradaA => A(3), entradaB => B(3), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_2, carry_out => carry_out_3, output => output(3));

    BIT02 : entity work.onebit_unit port map (entradaA => A(2), entradaB => B(2), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_1, carry_out => carry_out_2, output => output(2));

    BIT01 : entity work.onebit_unit port map (entradaA => A(1), entradaB => B(1), slt => '0', inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => carry_out_0, carry_out => carry_out_1, output => output(1));

    BIT00 : entity work.onebit_unit port map (entradaA => A(0), entradaB => B(0), slt => overflow_out_31, inverteA => inverteA, inverteB => inverteB, sel => sel_mux, carry_in => inverteB, carry_out => carry_out_0, output => output(0));

    flag_zero <= '1' when (output = zero) else '0';

end architecture;