library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity topLevel is
	generic   (
		data_width  : natural :=  32;
		addr_width  : natural :=  32
	);

	port   (
		-- Input ports
		clock_50_i : in  std_logic;
		sel_alu_i    : in  std_logic;
		wr_i        : in  std_logic;
		-- Output ports
		pc_out_o	  : out std_logic_vector(addr_width - 1 downto 0);
		opcode_o   : out std_logic_vector(5 downto 0);
		rs_o	  : out std_logic_vector(4 downto 0);
		rt_o    : out std_logic_vector(4 downto 0);
		rd_o	  : out std_logic_vector(4 downto 0);
		funct_o	  : out std_logic_vector(5 downto 0);
		rs_out_o	  : out std_logic_vector(data_width - 1 downto 0);
		rt_out_o	  : out std_logic_vector(data_width - 1 downto 0);
		alu_out_o  : out std_logic_vector(data_width - 1 downto 0)
	);
end entity;


architecture arch_name of topLevel is
	signal pc_out_s 	  : std_logic_vector(data_width - 1 downto 0);
	signal pc_out_plus_4_s  : std_logic_vector(data_width - 1 downto 0);
	signal rom_out_s		  : std_logic_vector(data_width - 1 downto 0);
		alias  opcode_s				  : std_logic_vector(5 downto 0) is rom_out_s(31 downto 26);
		alias  rs_s				  : std_logic_vector(4 downto 0) is rom_out_s(25 downto 21);
		alias  rt_s				  : std_logic_vector(4 downto 0) is rom_out_s(20 downto 16);
		alias  rd_s				  : std_logic_vector(4 downto 0) is rom_out_s(15 downto 11);
		alias  funct_s		  : std_logic_vector(5 downto 0) is rom_out_s(5  downto  0);
	signal rs_alu_A_s		  : std_logic_vector(data_width - 1 downto 0);
	signal rt_alu_B_s		  : std_logic_vector(data_width - 1 downto 0); 
	signal alu_out_s		  : std_logic_vector(data_width - 1 downto 0); 

	begin

	PC : entity work.genericRegister  generic map (larguraDados => addr_width)
			port map (DIN => pc_out_plus_4_s, DOUT => pc_out_s, ENABLE => '1', CLK => clock_50_i, RST => '0');

	-- We use 4 bytes address, so we need to multiply the address by 4 to get the correct address in PC
	INC_PC_4 :  entity work.constantSum generic map (larguraDados => addr_width, constante => 4)
						port map(entrada => pc_out_s, saida => pc_out_plus_4_s);

	-- We only need 64 (2^6) positions in ROM, so we use the 6 bits of the address
	ROM 		  : entity work.ROMmemory generic map (dataWidth => data_width, addrWidth => addr_width, memoryAddrWidth => 6)
						port map (Endereco => pc_out_s, Dado => rom_out_s);

	REG_BANK : entity work.registerBank generic map (larguraDados => addr_width)
						port map (clk => clock_50_i, enderecoA => rs_s, enderecoB => rt_s, enderecoC => rd_s, dadoEscritaC => alu_out_s, escreveC => wr_i, saidaA => rs_alu_A_s, saidaB => rt_alu_B_s);

	ALU 			: entity work.ALUSumSub generic map(larguraDados => addr_width)
						port map (entradaA => rs_alu_A_s, entradaB =>  rt_alu_B_s, saida => alu_out_s, seletor => sel_alu_i);

	pc_out_o  <= pc_out_s;
	opcode_o  <= opcode_s;
	rs_o   <= rs_s;
	rt_o   <= rt_s;
	rd_o	  <= rd_s;
	funct_o	  <= funct_s;
	rs_out_o  <= rs_alu_A_s;
	rt_out_o  <= rt_alu_B_s;
	alu_out_o <= alu_out_s;

end architecture;