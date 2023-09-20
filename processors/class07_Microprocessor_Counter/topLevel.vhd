library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topLevel is
  generic   (
    larguraDados : natural := 8;
    larguraEnderecos : natural := 9; -- 512 endereços de memoria de intrucao
	 larguraInstrucao : natural := 13; -- opcode + imediado
	 larguraRAM : natural := 6;
	 larguraSinalControle : natural := 12;
	 simulacao : boolean := FALSE -- para gravar na placa, altere de TRUE para FALSE
  );

  port   (
    -- Input ports
	 CLOCK_50 : in std_logic;
	 KEY: in std_logic_vector(3 downto 0);
	 FPGA_RESET_N : in std_logic;
	 HEX0 : OUT std_logic_vector(6 downto 0);
    -- Output ports
    LEDR :  out  std_logic_vector(9 downto 0)
  );
end entity;


architecture arch_name of topLevel is

  -- Declarations (optional):
 signal CLK : std_logic;
 signal Rd : std_logic;
 signal Wr : std_logic;
 signal DADO_Instruction_IN : std_logic_vector (larguraInstrucao-1 downto 0);
 signal ROM_Address_ENDERECO : std_logic_vector (larguraEnderecos-1 downto 0);
 signal RAM_Data_IN : std_logic_vector (larguraDados-1 downto 0);
 signal Data_OUT_RAM : std_logic_vector (larguraDados-1 downto 0);
 signal Data_Address : std_logic_vector (larguraEnderecos-1 downto 0);
 alias EnderecoDados_RAM : std_logic_vector(5 downto 0) is Data_Address(5 downto 0);
 alias Data_Address_Decodificador_8to6 : std_logic_vector(2 downto 0) is Data_Address (8 downto 6);
 alias Data_Address_Decodificador_2to0 : std_logic_vector(2 downto 0) is Data_Address (2 downto 0);
 signal OUT_DECODER_8to6 : std_logic_vector (7 downto 0);
 signal OUT_DECODER_2to0 : std_logic_vector (7 downto 0);
 alias bloco0_habilitaRAM : std_logic is OUT_DECODER_8to6(0);
 alias bloco1_habilitaRAM : std_logic is OUT_DECODER_8to6(1);
 alias bloco2_habilitaRAM : std_logic is OUT_DECODER_8to6(2);
 alias bloco3_habilitaRAM : std_logic is OUT_DECODER_8to6(3);
 alias bloco4_habilitaRAM : std_logic is OUT_DECODER_8to6(4);
 alias bloco5_habilitaRAM : std_logic is OUT_DECODER_8to6(5);
 alias bloco6_habilitaRAM : std_logic is OUT_DECODER_8to6(6);
 alias bloco7_habilitaRAM : std_logic is OUT_DECODER_8to6(7);
 alias decodoer_2to0_Endereco0 : std_logic is OUT_DECODER_2to0(0);
 alias decodoer_2to0_Endereco1 : std_logic is OUT_DECODER_2to0(1);
 alias decodoer_2to0_Endereco2 : std_logic is OUT_DECODER_2to0(2);
 alias leds7to0 : std_logic_vector (7 downto 0) is LEDR(7 downto 0);
 alias led8 : std_logic is LEDR (8);
 alias led9 : std_logic is LEDR (9);
 alias DATA_OUT_RAM_D0 : std_logic is Data_OUT_RAM(0);
 signal DECODER_HEX0 : std_logic_vector(6 downto 0);
 signal reset : std_logic;

begin

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);

else generate

detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;

reset <= NOT FPGA_RESET_N;

-- cpu (computador feito até agora)
CPU : entity work.CPU 
			 port map (Clock => CLK, Reset => reset, Rd => Rd, Wr => Wr, ROM_Address => ROM_Address_ENDERECO,
			 Instruction_IN => DADO_Instruction_IN, Data_IN => RAM_Data_IN, Data_OUT => Data_OUT_RAM, Data_Address => Data_Address);

-- memoria de instrucao
ROM : entity work.memoriaROM generic map (dataWidth => larguraInstrucao, addrWidth => larguraEnderecos)
          port map (Endereco => ROM_Address_ENDERECO, Dado => DADO_Instruction_IN);
			 
-- o port map completo da memoria RAM
RAM0 : entity work.memoriaRAM generic map (dataWidth => larguraDados, addrWidth => larguraRAM)
          port map (addr => EnderecoDados_RAM, we => Wr, re => Rd, habilita  => bloco0_habilitaRAM, dado_in => Data_OUT_RAM, dado_out => RAM_Data_IN, clk => CLK);

-- port map decoder
DECODER_8to6 :  entity work.decoder3x8 
			 port map(entrada => Data_Address_Decodificador_8to6, saida => OUT_DECODER_8to6);

DECODER_2to0 :  entity work.decoder3x8 
			 port map(entrada => Data_Address_Decodificador_2to0, saida => OUT_DECODER_2to0);

-- Registrador leds 0 a 7
RegLeds7to0 : entity work.registradorGenerico generic map (larguraDados => larguraDados)
          port map (DIN => Data_OUT_RAM, DOUT => leds7to0, ENABLE => (Wr and decodoer_2to0_Endereco0 and bloco4_habilitaRAM), CLK => CLK, RST => '0');

-- reg do led8
RegLed8 : entity work.registradorBinario
          port map (DIN => DATA_OUT_RAM_D0, DOUT => led8, ENABLE => (Wr and decodoer_2to0_Endereco1 and bloco4_habilitaRAM), CLK => CLK, RST => '0');

-- reg do led9 
RegLed9 : entity work.registradorBinario
          port map (DIN => DATA_OUT_RAM_D0, DOUT => led9, ENABLE => (Wr and decodoer_2to0_Endereco2 and bloco4_habilitaRAM), CLK => CLK, RST => '0');	 
 
pc_hex0 :  entity work.conversorHex7Seg
        port map(dadoHex => ROM_Address_ENDERECO(3 downto 0),
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => DECODER_HEX0);
					  
HEX0 <= DECODER_HEX0;
	
end architecture;