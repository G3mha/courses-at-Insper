library ieee;
use ieee.std_logic_1164.all;

entity debugMonitor is
  generic   (
   DATA_WIDTH  : natural :=  32;
    ADDR_WIDTH  : natural :=  32;
   PROBE_WDTH  : natural := 511
  );
  port   (
    -- Input ports
   PC :  in  std_logic_vector(ADDR_WIDTH-1 downto 0);
  Instrucao :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  LeituraRS :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  LeituraRT :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  EscritaRD :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  EntradaB_ULA :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  imediatoEstendido :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  saidaULA :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  dadoLido_RAM :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  proxPC :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  MUXProxPCEntradaA :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  MUXProxPCEntradaB :  in  std_logic_vector(DATA_WIDTH-1 downto 0);
  ULActrl  :  in  std_logic_vector(3 downto 0);
  zeroFLAG :  in  std_logic;
  escreveC :  in  std_logic;
  MUXPCBEQJUMP :  in  std_logic;
  MUXRTRD :  in  std_logic;
  MUXRTIMED :  in  std_logic;
  MUXULAMEM :  in  std_logic;
  iBEQ :  in  std_logic;
  WR :  in  std_logic;
  RD :  in  std_logic;
   -- Output ports
  clkTCL :  out  std_logic
  );
end entity;


architecture arch_name of debugMonitor is

    component probesSourcesDebug is
        port (
            probe  : in  std_logic_vector(PROBE_WDTH-1 downto 0) := (others => 'X'); -- probe faz a leitura de dados de dentro da FPGA
            source : out std_logic                                            -- source escreve dados para dentro da FPGA
        );
    end component probesSourcesDebug;

begin

probe0 : component probesSourcesDebug
        port map (
            --probe  => sigProbe,  -- probes.probe
        probe(31 downto 0)    => PC,
        probe(63 downto 32)   => Instrucao,
        probe(95 downto 64)   => LeituraRS,
        probe(127 downto 96)  => LeituraRT,
        probe(159 downto 128) => EscritaRD,
        probe(191 downto 160) => EntradaB_ULA,
        probe(223 downto 192) => imediatoEstendido,
        probe(255 downto 224) => saidaULA,
        probe(287 downto 256) => dadoLido_RAM,
        probe(319 downto 288) => proxPC,
        probe(351 downto 320) => MUXProxPCEntradaA,
        probe(383 downto 352) => MUXProxPCEntradaB,
        probe(497 downto 384) =>  open,
        probe(498) => zeroFLAG,
        probe(499) => MUXPCBEQJUMP,
        probe(500) => MUXRTRD,
        probe(501) => MUXRTIMED,
        probe(502) => MUXULAMEM,
        probe(503) => iBEQ,
        probe(504) => WR,
        probe(505) => RD,
        probe(509 downto 506) => ULActrl,
        probe(510) => escreveC,
        --probe(PROBE_WDTH-1 downto 256) => open,
        source => clkTCL
      );

end architecture;
