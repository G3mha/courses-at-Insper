library ieee;
use ieee.std_logic_1164.all;

entity Aula1 is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 4;
              simulacao : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50 : in std_logic;
    KEY: in std_logic_vector(3 downto 0);
    SW: in std_logic_vector(9 downto 0);
    LEDR  : out std_logic_vector(9 downto 0)
  );
end entity;

architecture arquitetura of Aula1 is
-- Obs.:
-- SW(9 downto 6) : entrada da variavel X.
-- SW(3 downto 0) : entrada da variavel Y.
-- SW(4) : o ponto de controle da Operacao da ULA.
-- SW(5) : o ponto de controle de SelMUX.
-- KEY(0) : o botão do clock.
-- KEY(1) : o ponto de controle para Reset A (o Botao em repouso fica no nível alto, portanto, devemos usar not KEY(1) no Reset).
-- KEY(2) : o ponto de controle de Habilita A.
-- KEY(3) : sem uso.

  signal chavesX_ULA_B : std_logic_vector (larguraDados-1 downto 0);
  signal chavesY_MUX_A : std_logic_vector (larguraDados-1 downto 0);
  signal REG1_ULA_A : std_logic_vector (larguraDados-1 downto 0);
  signal Saida_ULA : std_logic_vector (larguraDados-1 downto 0);
  signal MUX_REG_A : std_logic_vector (larguraDados-1 downto 0);
  signal Chave_Operacao_ULA : std_logic;
  signal CLK : std_logic;
  signal SelMUX : std_logic;
  signal Habilita_A : std_logic;
  signal Reset_A : std_logic;
  signal Operacao_ULA : std_logic;
begin

-- Instanciando os componentes:

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;

-- Instancia do MUX.
MUX1 :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
        port map( entradaA_MUX => chavesY_MUX_A,
                 entradaB_MUX =>  Saida_ULA,
                 seletor_MUX => SelMUX,
                 saida_MUX => MUX_REG_A);

-- Instancia do Acumulador.
REG1 : entity work.registradorGenerico   generic map (larguraDados => larguraDados)
          port map (DIN => MUX_REG_A, DOUT => REG1_ULA_A, ENABLE => Habilita_A, CLK => CLK, RST => Reset_A);

-- Instancia da ULA:
ULA1 : entity work.ULASomaSub  generic map(larguraDados => larguraDados)
          port map (entradaA => REG1_ULA_A, entradaB =>  chavesX_ULA_B, saida => Saida_ULA, seletor => SW(4));

-- Chaves e Botoes.
chavesX_ULA_B <= SW(9 downto 6);
chavesY_MUX_A <= SW(3 downto 0);
SelMUX <= SW(5);
Operacao_ULA <= SW(4);
Reset_A <= not KEY(1);
Habilita_A <= KEY(2);


-- A ligacao dos LEDs:
LEDR (9) <= SelMUX;
LEDR (8) <= Habilita_A;
LEDR (7) <= Reset_A;
LEDR (6) <= Operacao_ULA;
LEDR (5) <= '0';    -- Apagado.
LEDR (4) <= '0';    -- Apagado.
LEDR (3 downto 0) <= REG1_ULA_A;

end architecture;
