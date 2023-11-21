library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity topLevel is
	generic   (
		data_width  : natural :=  32;
		addr_width  : natural :=  32
	);

	port   (		
		-- Output ports
	  sum_out       : out std_logic_vector(data_width - 1 downto 0);
	  sub_out       : out std_logic_vector(data_width - 1 downto 0);
	  and_out       : out std_logic_vector(data_width - 1 downto 0);
	  or_out        : out std_logic_vector(data_width - 1 downto 0);
	  slt_true_out  : out std_logic_vector(data_width - 1 downto 0);
	  slt_false_out : out std_logic_vector(data_width - 1 downto 0)
	);
end entity;


architecture arch_name of topLevel is	
	
	signal A : std_logic_vector(data_width - 1 downto 0);
	signal B : std_logic_vector(data_width - 1 downto 0);


	begin

	SUM1 : entity work.ULAMIPS generic map (data_width => data_width)
				port map (inputA => A, inputB => B, inverteB => '0', selectMUX => "10", output_ALU => sum_out);

	SUB1 : entity work.ULAMIPS generic map (data_width => data_width)
				port map (inputA => A, inputB => B, inverteB => '1', selectMUX => "10", output_ALU => sub_out);

	AND1 : entity work.ULAMIPS generic map (data_width => data_width)
				port map (inputA => A, inputB => B, inverteB => '0', selectMUX => "00", output_ALU => and_out);

	OR1 : entity work.ULAMIPS generic map (data_width => data_width)
				port map (inputA => A, inputB => B, inverteB => '0', selectMUX => "01", output_ALU => or_out);

	SLT_TRUE : entity work.ULAMIPS generic map (data_width => data_width)
				port map (inputA => B, inputB => A, inverteB => '1', selectMUX => "11", output_ALU => slt_true_out);

	SLT_FALSE : entity work.ULAMIPS generic map (data_width => data_width)
				port map (inputA => A, inputB => B, inverteB => '1', selectMUX => "11", output_ALU => slt_false_out);
   
	A <= "00000000000000000000000000000011";
	B <= "00000000000000000000000000000010";

end architecture;