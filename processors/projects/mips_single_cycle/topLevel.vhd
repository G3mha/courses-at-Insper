library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity topLevel is
	generic   (
		data_width  : natural :=  32;
		addr_width  : natural :=  32;
		simulacao   : boolean := FALSE -- to record on board, use FALSE
	);

	port   (
		-- Input ports
		CLOCK_50     : in std_logic;
      KEY          : in std_logic_vector(3 downto 0);
		SW           : in std_logic_vector(9 downto 0);
		FPGA_RESET_N : in std_logic;
		
		-- Output ports
      LEDR       : out std_logic_vector(9 downto 0);
      HEX0       : out std_logic_vector(6 downto 0);
      HEX1       : out std_logic_vector(6 downto 0);
      HEX2       : out std_logic_vector(6 downto 0);
      HEX3       : out std_logic_vector(6 downto 0);
		MUX_OUT    : out std_logic_vector(data_width - 1 downto 0)
	);
end entity;


architecture arch_name of topLevel is
    signal CLK                  : std_logic;
    signal RESET                : std_logic;
    signal pc_out               : std_logic_vector(data_width - 1 downto 0);
    signal pc_out4        : std_logic_vector(data_width - 1 downto 0);
    signal rom_out              : std_logic_vector(data_width - 1 downto 0);
        alias opcode            : std_logic_vector(5  downto 0) is rom_out(31 downto 26);
        alias rs                : std_logic_vector(4  downto 0) is rom_out(25 downto 21);
        alias rt                : std_logic_vector(4  downto 0) is rom_out(20 downto 16);
        alias rd                : std_logic_vector(4  downto 0) is rom_out(15 downto 11);
        alias immediate         : std_logic_vector(15 downto 0) is rom_out(15 downto  0);
        alias jmp_address       : std_logic_vector(25 downto 0) is rom_out(25 downto  0);
        alias funct             : std_logic_vector(5  downto 0) is rom_out(5  downto  0);
    signal r31                  : "11111";
    signal control_word         : std_logic_vector(13 downto 0);
        alias jr                : std_logic is control_word(13);
        alias sel_mux_pc4_jmp   : std_logic is control_word(12);
        alias sel_mux_rt_rd     : std_logic_vector(1 downto 0) is control_word(11 downto 10);
        alias sel_ori_andi      : std_logic is control_word(9);
        alias enable_reg_wr     : std_logic is control_word(8);
        alias sel_mux_rt_imm    : std_logic is control_word(7)
        alias sel_type_r        : std_logic is control_word(6);
        alias sel_mux_ula_rom   : std_logic_vector(1 downto 0) is control_word(5 downto 4);
        alias beq               : std_logic is control_word(3);
        alias bne               : std_logic is control_word(2);
        alias enable_rom_rd     : std_logic is control_word(1);
        alias enable_rom_wr     : std_logic is control_word(0);
    signal mux_rt_rd_out 	    : std_logic_vector(4 downto 0);
    signal rs_data              : std_logic_vector(data_width - 1 downto 0);
    signal rt_data              : std_logic_vector(data_width - 1 downto 0);
    signal mux_rt_imm_out       : std_logic_vector(data_width - 1 downto 0);

	signal mux_rt_rd_out_s      : std_logic_vector(4 downto 0);
	signal adder_out_s          : std_logic_vector(data_width - 1 downto 0);
	signal im_extend_s          : std_logic_vector(data_width - 1 downto 0);
	signal im_ext_sl2_s         : std_logic_vector(data_width - 1 downto 0);
	signal and_out_s            : std_logic;
	signal mux_pc_out           : std_logic_vector(data_width - 1 downto 0);
	signal rs_alu_A_s		       : std_logic_vector(data_width - 1 downto 0);
	signal rt_alu_B_s		       : std_logic_vector(data_width - 1 downto 0);
	signal ram_out_s            : std_logic_vector(data_width - 1 downto 0);
	signal mux_rt_imm_out_s     : std_logic_vector(data_width - 1 downto 0);
	signal alu_out_s		       : std_logic_vector(data_width - 1 downto 0);
	signal mux_alu_ram_out_s    : std_logic_vector(data_width - 1 downto 0);
	signal flag_zero_s          : std_logic;
	signal mux_jmp_out_s        : std_logic_vector(data_width - 1 downto 0);
	signal concat_out         : std_logic_vector(data_width - 1 downto 0);
   signal mux_hex_out_s        : std_logic_vector(data_width - 1 downto 0);
	signal display_HEX_0        : std_logic_vector(6 downto 0);
	signal display_HEX_1        : std_logic_vector(6 downto 0);
	signal display_HEX_2        : std_logic_vector(6 downto 0);
	signal display_HEX_3        : std_logic_vector(6 downto 0);
	signal type_r               : std_logic;
	signal mux_ctrl_out         : std_logic_vector(3 downto 0);
	
	
	begin

	gravar:  if simulacao generate
	CLK <= KEY(0);
	RESET <= '0';
	else generate
	EDGE_DETECT_CLK   : work.edgeDetector(bordaSubida)
			                  port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
	
	EDGE_DETECT_RESET : work.edgeDetector(bordaSubida)
			                  port map (clk => CLOCK_50, entrada => (NOT FPGA_RESET_N), saida => RESET);
	end generate;

    PC           : entity work.genericRegister port map (input => mux_prox_pc_out, output => pc_out, ENABLE => '1', CLK => CLK, RST => RESET);

    INC_PC4      : entity work.constantSum port map (input => pc_out, output => pc_out4);

    ROM          : entity work.ROMMIPS port map (address => pc_out, data => rom_out);

    CONTROL_UNIT : entity work.instructionDecoder port map (opcode => opcode, funct => funct, output => control_word);

    MUX_RT_RD    : entity work.mux_3x1 generic map (data_width => 5)
	                    port map (A => rt, B => rd, C => r31, sel => sel_mux_rt_rd, output => mux_rt_rd_out);

    REG_BANK     : entity work.registerBank port map (CLK => CLK, A => rs, B => rt, C => mux_rt_rd_out, data_to_write => mux_alu_ram_out, enable_write => enable_reg_wr, outputA => rs_data, outputB => rt_data);

    

    MUX_RT_IMM   : entity work.mux_2x1 port map (A => rt_data, B => /, sel => sel_mux_rt_imm, output => mux_rt_imm_out);

	MUX_PROX_PC  : entity work.mux_2x1 port map (A => mux_jmp_out, B => r1_out, sel => jr, output => mux_prox_pc_out);

	CONCAT       : entity work.concatJMP port map(immediate => immediate_jmp_s, pc_plus_4 => pc_out_plus_4_s, output => concat_out);
	
	EXT_SIGNAL   : entity work.extendGenericSignal   generic map (larguraDadoEntrada => 16, larguraDadoSaida => addr_width)
                    port map (input => immediate_s, output => im_extend_s);

	SHIFT_LEFT2  : entity work.shiftLeft2 port map (input => im_extend_s, output => im_ext_sl2_s);
						
	ADD_IM_PC4   : entity work.genericAdder  generic map (larguraDados => addr_width)
                     port map(entradaA => pc_out_plus_4_s, entradaB => im_ext_sl2_s, saida => adder_out_s);

	GATE_AND     : entity work.gateAND port map (A => flag_zero_s, B => beq_s, output => and_out_s);
   
	MUX_PC       : entity work.mux2x1 generic map (dataWidth => addr_width)
 					      port map(input_A => pc_out_plus_4_s, input_B => adder_out_s, sel => and_out_s, output => mux_pc_out_s);

	
	CONTROL_UNIT : entity work.instructionDecoder port map (opcode_i => opcode_s, funct_i => funct_s, output => control_s, typeR => type_r);
	
	ALU_CTRL     : entity work.ALUctrl port map (opcode => opcode_s, funct => funct_s, type_R => type_r, output => mux_ctrl_out);
	
	MUX_RT_RD    : entity work.mux2x1 generic map (dataWidth => 5)
	 					   port map(input_A => rt_s, input_B => rd_s, sel => sel_mux_rt_rd_s, output => mux_rt_rd_out_s);

	REG_BANK     : entity work.registerBank generic map (larguraDados => addr_width)
						   port map (clk => CLK, enderecoA => rs_s, enderecoB => rt_s, enderecoC => mux_rt_rd_out_s, dadoEscritaC => mux_alu_ram_out_s, escreveC => wb_reg_s, saidaA => rs_alu_A_s, saidaB => rt_alu_B_s);

	MUX_RT_IMM   : entity work.mux2x1 generic map (dataWidth => addr_width)
 					      port map(input_A => rt_alu_B_s, input_B => im_extend_s, sel => sel_mux_rt_imm_s, output => mux_rt_imm_out_s);

	ALU 		    : entity work.ALUMIPS generic map(data_width => addr_width)
					      port map (input_A => rs_alu_A_s, input_B => mux_rt_imm_out_s, operation => mux_ctrl_out, output => alu_out_s, flag_zero => flag_zero_s);

	MUX_ALU_RAM  : entity work.mux2x1 generic map (dataWidth => addr_width)
 					      port map(input_A => alu_out_s, input_B => ram_out_s, sel => sel_mux_alu_ram_s, output => mux_alu_ram_out_s);

	-- Why is it 6?
	RAM          : entity work.RAMMIPS generic map (dataWidth => data_width, addrWidth => addr_width, memoryAddrWidth => 6)
                     port map (addr => alu_out_s, we => wr_ram_s, re => rd_ram_s, habilita  => '1', input => rt_alu_B_s, output => ram_out_s, clk => CLK);
	
	MUX_HEX      : entity work.mux3x1 generic map (dataWidth => addr_width)
 					      port map(input_A => alu_out_s, input_B => rt_alu_B_s, input_C => ram_out_s, sel => (SW(1) & SW(0)), output => mux_hex_out_s);	

   DEC_HEX0     : entity work.hexTo7seg
                     port map(dadoHex => mux_hex_out_s(3 downto 0), apaga => '0', negativo => '0', overFlow => '0', saida7seg => display_HEX_0);

   DEC_HEX1     : entity work.hexTo7seg
                     port map(dadoHex => mux_hex_out_s(7 downto 4), apaga => '0', negativo => '0', overFlow => '0', saida7seg => display_HEX_1);

   DEC_HEX2     : entity work.hexTo7seg
                     port map(dadoHex => mux_hex_out_s(11 downto 8), apaga => '0', negativo => '0', overFlow => '0', saida7seg => display_HEX_2);

   DEC_HEX3     : entity work.hexTo7seg
                     port map(dadoHex => mux_hex_out_s(15 downto 12), apaga => '0', negativo => '0', overFlow => '0', saida7seg => display_HEX_3);

   LEDR(9 downto 0) <= pc_out_s(9 downto 0);
	HEX0 <= display_HEX_0;
   HEX1 <= display_HEX_1;
   HEX2 <= display_HEX_2;
   HEX3 <= display_HEX_3;
	MUX_OUT <= mux_hex_out_s;

end architecture;