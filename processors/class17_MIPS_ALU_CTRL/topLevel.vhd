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
	signal pc_out_s 	          : std_logic_vector(data_width - 1 downto 0);
	signal pc_out_plus_4_s      : std_logic_vector(data_width - 1 downto 0);
	signal mux_rt_rd_out_s      : std_logic_vector(4 downto 0);
	signal adder_out_s          : std_logic_vector(data_width - 1 downto 0);
	signal rom_out_s            : std_logic_vector(data_width - 1 downto 0);
	    alias opcode_s          : std_logic_vector(5  downto 0) is rom_out_s(31 downto 26);
	    alias rs_s		          : std_logic_vector(4  downto 0) is rom_out_s(25 downto 21);
	    alias rt_s	             : std_logic_vector(4  downto 0) is rom_out_s(20 downto 16);
		 alias rd_s              : std_logic_vector(4  downto 0) is rom_out_s(15 downto 11);
	    alias immediate_s	    : std_logic_vector(15 downto 0) is rom_out_s(15 downto  0);
		 alias immediate_jmp_s   : std_logic_vector(25 downto 0) is rom_out_s(25 downto  0);
		 alias funct_s           : std_logic_vector(5  downto 0) is rom_out_s(5  downto  0);
	signal im_extend_s          : std_logic_vector(data_width - 1 downto 0);
	signal im_ext_sl2_s         : std_logic_vector(data_width - 1 downto 0);
	signal and_out_s            : std_logic;
	signal mux_pc_out_s         : std_logic_vector(data_width - 1 downto 0);
	signal rs_alu_A_s		       : std_logic_vector(data_width - 1 downto 0);
	signal rt_alu_B_s		       : std_logic_vector(data_width - 1 downto 0);
	signal ram_out_s            : std_logic_vector(data_width - 1 downto 0);
	signal mux_rt_imm_out_s     : std_logic_vector(data_width - 1 downto 0);
	signal alu_out_s		       : std_logic_vector(data_width - 1 downto 0);
	signal mux_alu_ram_out_s    : std_logic_vector(data_width - 1 downto 0);
	signal flag_zero_s          : std_logic;
	signal mux_jmp_out_s        : std_logic_vector(data_width - 1 downto 0);
	signal concat_out_s         : std_logic_vector(data_width - 1 downto 0);
	signal control_s            : std_logic_vector(11 downto 0);
		 alias sel_mux_jmp_s     : std_logic is control_s(11);
		 alias sel_mux_rt_rd_s   : std_logic is control_s(10);
	    alias wb_reg_s          : std_logic is control_s(9);
	    alias sel_mux_rt_imm_s  : std_logic is control_s(8);
	    alias sel_alu_ctrl_s    : std_logic_vector(3 downto 0) is control_s(7 downto 4);
	    alias sel_mux_alu_ram_s : std_logic is control_s(3);
	    alias beq_s             : std_logic is control_s(2);
	    alias rd_ram_s          : std_logic is control_s(1);
	    alias wr_ram_s          : std_logic is control_s(0);
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

	MUX_JMP      : entity work.mux2x1 generic map (dataWidth => addr_width)
	                 port map (input_A => mux_pc_out_s, input_B => concat_out_s, sel => sel_mux_jmp_s, output => mux_jmp_out_s);
	
	PC           : entity work.genericRegister  generic map (larguraDados => addr_width)
		              port map (DIN => mux_jmp_out_s, DOUT => pc_out_s, ENABLE => '1', CLK => CLK, RST => RESET);

	-- We use 4 bytes address, so we need to multiply the address stepping by 4 to get the correct address in PC
	INC_PC4      : entity work.constantSum generic map (larguraDados => addr_width, constante => 4)
					     port map(entrada => pc_out_s, saida => pc_out_plus_4_s);

	CONCAT       : entity work.concatJMP port map(immediate => immediate_jmp_s, pc_plus_4 => pc_out_plus_4_s, output => concat_out_s);
	
	EXT_SIGNAL   : entity work.extendGenericSignal   generic map (larguraDadoEntrada => 16, larguraDadoSaida => addr_width)
                    port map (input => immediate_s, output => im_extend_s);

	SHIFT_LEFT2  : entity work.shiftLeft2 port map (input => im_extend_s, output => im_ext_sl2_s);
						
	ADD_IM_PC4   : entity work.genericAdder  generic map (larguraDados => addr_width)
                     port map(entradaA => pc_out_plus_4_s, entradaB => im_ext_sl2_s, saida => adder_out_s);

	GATE_AND     : entity work.gateAND port map (A => flag_zero_s, B => beq_s, output => and_out_s);
   
	MUX_PC       : entity work.mux2x1 generic map (dataWidth => addr_width)
 					      port map(input_A => pc_out_plus_4_s, input_B => adder_out_s, sel => and_out_s, output => mux_pc_out_s);

	-- We only need 64 (2^6) positions in ROM, so we use the 6 bits of the address
	ROM 		    : entity work.ROMMIPS generic map (dataWidth => data_width, addrWidth => addr_width, memoryAddrWidth => 6)
						   port map (Endereco => pc_out_s, Dado => rom_out_s);
	
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