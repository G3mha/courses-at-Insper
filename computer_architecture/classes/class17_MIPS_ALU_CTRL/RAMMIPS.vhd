library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAMMIPS IS
   generic (
          dataWidth: natural := 32;
          addrWidth: natural := 32;
          memoryAddrWidth:  natural := 6 );   -- 64 posicoes de 32 bits cada
   port ( clk      : IN  STD_LOGIC;
          addr : IN  STD_LOGIC_VECTOR (addrWidth-1 DOWNTO 0);
          input  : in std_logic_vector(dataWidth-1 downto 0);
          output : out std_logic_vector(dataWidth-1 downto 0);
          we, re, habilita : in std_logic
        );
end entity;

architecture assincrona OF RAMMIPS IS
  type blocoMemoria IS ARRAY(0 TO 2**memoryAddrWidth - 1) OF std_logic_vector(dataWidth-1 DOWNTO 0);

  signal memRAM: blocoMemoria;
--  Caso queira inicializar a RAM (para testes):
--  attribute ram_init_file : string;
--  attribute ram_init_file of memRAM:
--  signal is "RAMcontent.mif";

-- Utiliza uma quantidade menor de endereços locais:
   signal EnderecoLocal : std_logic_vector(memoryAddrWidth-1 downto 0);

begin

  -- Ajusta o enderecamento para o acesso de 32 bits.
  EnderecoLocal <= addr(memoryAddrWidth+1 downto 2);

  process(clk)
  begin
      if(rising_edge(clk)) then
          if(we = '1' and habilita='1') then
              memRAM(to_integer(unsigned(EnderecoLocal))) <= input;
          end if;
      end if;
  end process;

  -- A leitura deve ser sempre assincrona:
  output <= memRAM(to_integer(unsigned(EnderecoLocal))) when (re = '1' and habilita='1') else (others => 'Z');

end architecture;
