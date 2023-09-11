library ieee;
use ieee.std_logic_1164.all;

entity topLevel is
  -- Total de bits das entradas e saidas
  generic ( larguraDados      : natural := 8; -- 2^8 = 256 valores
            larguraEnderecos  : natural := 9; -- 2^9 = 512 enderecos
            larguraInstrucoes : natural := 13; -- opCode | acessa memória? | endereço/valor
					  simulacao         : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50 : in std_logic;
    KEY      : in std_logic_vector(3 downto 0);
    SW       : in std_logic_vector(9 downto 0);
    PC_OUT   : out std_logic_vector(larguraEnderecos-1 downto 0);
    LEDR     : out std_logic_vector(9 downto 0)
  );
end entity;


architecture arquitetura of topLevel is

  -- Instruction
  signal instruction      : std_logic_vector (12 downto 0);
  alias opCode            : std_logic_vector (3 downto 0) is Instrucao(12 downto 9);
  alias RAM_addr          : std_logic_vector (8 downto 0) is Instrucao(8 downto 0);
  alias instruction_value : std_logic_vector (7 downto 0) is Instrucao(7 downto 0);

  -- MUX
  signal SelMUX  : std_logic;
  signal MUX_out : std_logic_vector (larguraDados-1 downto 0);
  
  -- RAM
  signal RAM_out : std_logic_vector (larguraDados-1 downto 0);

  -- RegA
  signal Habilita_A : std_logic;
  signal CLK        : std_logic;
  signal RegA_out   : std_logic_vector (larguraDados-1 downto 0);

  -- PC
  signal proxPC   : std_logic_vector (8 downto 0);
  signal Endereco : std_logic_vector (8 downto 0);

  -- ULA
  signal ULA_out       : std_logic_vector (larguraDados-1 downto 0);
  signal ULA_operation : std_logic_vector (1 downto 0);

  signal chavesX_ULA_B : std_logic_vector (larguraDados-1 downto 0);
  signal REG1_ULA_A : std_logic_vector (larguraDados-1 downto 0);
  signal Saida_ULA : std_logic_vector (larguraDados-1 downto 0);
  signal Sinais_Controle : std_logic_vector (3 downto 0);
  signal Chave_Operacao_ULA : std_logic;
  signal Reset_A : std_logic;

begin

-- Instanciando os componentes:

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;

-- O port map completo do MUX.
MUX1 :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
        port map(entradaA_MUX => RAM_out,
                 entradaB_MUX => instruction_value,
                 seletor_MUX  => SelMUX,
                 saida_MUX    => MUX_out);

-- O port map completo do Acumulador.
REGA : entity work.registradorGenerico  generic map (larguraDados => larguraDados)
          port map (DIN => ULA_out, bDOUT => RegA_out, ENABLE => Habilita_A, CLK => CLK, RST => '0');

-- O port map completo do Program Counter.
PC : entity work.registradorGenerico  generic map (larguraDados => larguraEnderecos)
          port map (DIN => proxPC, DOUT => Endereco, ENABLE => '1', CLK => CLK, RST => '0');

incrementaPC :  entity work.somaConstante  generic map (larguraDados => larguraEnderecos, constante => 1)
        port map (entrada => Endereco, saida => proxPC);

-- O port map completo da ULA:
ULA1 : entity work.ULASomaSub  generic map(larguraDados => larguraDados)
          port map (entradaA => RegA_out, entradaB => MUX_out, saida => ULA_out, seletor => ULA_operation);

-- O port map completo da memória:
ROM1 : entity work.memoriaROM  generic map (dataWidth => larguraDados, addrWidth => larguraEnderecos)
          port map (Endereco => Endereco, Dado => instruction);

-- O port map completo do Decoder:
DEC : entity work.decoderGeneric  port map (entrada => Instrucoes, saida => Sinais_Controle);


selMUX <= Sinais_Controle(3);
Habilita_A <= Sinais_Controle(2);
Reset_A <= Sinais_Controle(1);
Operacao_ULA <= Sinais_Controle(0);

-- I/O
chavesY_MUX_A <= SW(3 downto 0);
chavesX_ULA_B <= SW(9 downto 6);

-- A ligacao dos LEDs:
LEDR (9) <= SelMUX;
LEDR (8) <= Habilita_A;
LEDR (7) <= Reset_A;
LEDR (6) <= Operacao_ULA;
LEDR (5) <= '0';    -- Apagado.
LEDR (4) <= '0';    -- Apagado.
LEDR (3 downto 0) <= REG1_ULA_A;

PC_OUT <= Endereco;

end architecture;
