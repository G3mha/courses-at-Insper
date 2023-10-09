library ieee;
use ieee.std_logic_1164.all;

entity topLevel is
  -- Total de bits das entradas e saidas
  generic ( larguraDados            : natural := 8; -- 2^8 = 256 valores
            larguraEnderecos        : natural := 9; -- 2^9 = 512 enderecos
            larguraInstrucoes       : natural := 13; -- opCode | acessa memória? | endereço/valor
				    larguraSinaisDeControle : natural := 7; -- habEscritaMEM | habLeituraMEM | Operacao_ULA_2_bits | Habilita_A | SelMUX | SelMUX_JMP
            simulacao               : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50         : in std_logic;
    KEY              : in std_logic_vector(3 downto 0);
    PC_OUT           : out std_logic_vector(larguraEnderecos-1 downto 0);
    LEDR             : out std_logic_vector(9 downto 0);
	 EntradaB_ULA     : out std_logic_vector(larguraDados-1 downto 0);
	 Palavra_Controle : out std_logic_vector(larguraSinaisDeControle-1 downto 0)
  );
end entity;


architecture arquitetura of topLevel is

  -- Instruction
  signal instruction   : std_logic_vector (12 downto 0);
  alias opCode         : std_logic_vector (3 downto 0) is instruction(12 downto 9);
  alias imediato_addr  : std_logic_vector (8 downto 0) is instruction(8 downto 0);
  alias imediato_value : std_logic_vector (7 downto 0) is instruction(7 downto 0);

  -- Decoder
  signal Sinais_Controle : std_logic_vector (larguraSinaisDeControle - 1 downto 0);

  -- MUX
  signal SelMUX  : std_logic;
  signal MUX_out : std_logic_vector (larguraDados-1 downto 0);

  -- MUX JMP
  signal SelMUX_JMP : std_logic;
  signal MUX_out_JMP : std_logic_vector (larguraEnderecos-1 downto 0);
  
  -- RAM
  signal RAM_out       : std_logic_vector (larguraDados-1 downto 0);
  alias  RAM_Habilita  : std_logic is instruction(8);
  signal habEscritaMEM : std_logic;
  signal habLeituraMEM : std_logic;

  -- RegA
  signal Habilita_A : std_logic;
  signal CLK        : std_logic;
  signal RegA_out   : std_logic_vector (larguraDados-1 downto 0);

  -- PC
  signal proxPC   : std_logic_vector (larguraEnderecos-1 downto 0);
  signal Endereco : std_logic_vector (larguraEnderecos-1 downto 0);

  -- ULA
  signal ULA_out       : std_logic_vector (larguraDados-1 downto 0);
  signal ULA_operation : std_logic_vector (1 downto 0);

begin

-- Instanciando os componentes:

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;

PC : entity work.registradorGenerico  generic map (larguraDados => larguraEnderecos)
          port map (DIN => MUX_out_JMP, DOUT => Endereco, ENABLE => '1', CLK => CLK, RST => '0');

incrementaPC :  entity work.somaConstante  generic map (larguraDados => larguraEnderecos, constante => 1)
        port map (entrada => Endereco, saida => proxPC);

MUX_JMP : entity work.muxGenerico2x1  generic map (larguraDados => larguraEnderecos)
        port map(entradaA_MUX => proxPC,
                 entradaB_MUX => imediato_addr,
                 seletor_MUX  => SelMUX_JMP,
                 saida_MUX    => MUX_out_JMP);

ROM : entity work.memoriaROM  generic map (dataWidth => larguraInstrucoes, addrWidth => larguraEnderecos)
          port map (Endereco => Endereco, Dado => instruction);

MUX_ULA :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
        port map(entradaA_MUX => RAM_out,
                 entradaB_MUX => imediato_value,
                 seletor_MUX  => SelMUX,
                 saida_MUX    => MUX_out);

REGA : entity work.registradorGenerico  generic map (larguraDados => larguraDados)
          port map (DIN => ULA_out, DOUT => RegA_out, ENABLE => Habilita_A, CLK => CLK, RST => '0');

RAM1 : entity work.memoriaRAM   generic map (dataWidth => larguraDados, addrWidth => larguraEnderecos-1)
          port map (addr => imediato_value, we => habEscritaMEM, re => habLeituraMEM, habilita  => RAM_Habilita, dado_in => RegA_out, dado_out => RAM_out, clk => CLK);

ULA1 : entity work.ULASomaSub  generic map(larguraDados => larguraDados)
          port map (entradaA => RegA_out, entradaB => MUX_out, saida => ULA_out, seletor => ULA_operation);

DEC : entity work.decoderGeneric  port map (entrada => opCode, saida => Sinais_Controle);


habEscritaMEM <= Sinais_Controle(0);
habLeituraMEM <= Sinais_Controle(1);
ULA_operation <= Sinais_Controle(3 downto 2);
Habilita_A <= Sinais_Controle(4);
SelMUX <= Sinais_Controle(5);
SelMUX_JMP <= Sinais_Controle(6);

-- A ligacao dos LEDs: (DONE)
LEDR (9) <= ULA_operation(1);
LEDR (8) <= ULA_operation(0);
LEDR (7 downto 0) <= RegA_out;

PC_OUT <= Endereco;
EntradaB_ULA <= MUX_out;
Palavra_Controle <= Sinais_Controle;

end architecture;
