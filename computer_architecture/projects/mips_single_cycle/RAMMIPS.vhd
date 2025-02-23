library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAMMIPS IS
   generic (
          data_width           : natural := 32;
          address_width        : natural := 32;
          memory_address_width : natural := 6 );   -- 64 posicoes de 32 bits cada
   port ( CLK     : in  std_logic;
          address : in  std_logic_vector (address_width-1 DOWNTO 0);
          data    : in std_logic_vector(data_width-1 downto 0);
          output  : out std_logic_vector(data_width-1 downto 0);
          enable_read, enable_write : in std_logic;
          habilita : in std_logic := '1'
        );
end entity;

architecture assincrona OF RAMMIPS IS
  type blocoMemoria IS ARRAY(0 TO 2**memory_address_width - 1) OF std_logic_vector(data_width-1 DOWNTO 0);

  signal memRAM: blocoMemoria;
--  Caso queira inicializar a RAM (para testes):
--  attribute ram_init_file : string;
--  attribute ram_init_file of memRAM:
--  signal is "RAMcontent.mif";

-- Utiliza uma quantidade menor de endereços locais:
   signal local_address : std_logic_vector(memory_address_width-1 downto 0);

begin

  -- Ajusta o enderecamento para o acesso de 32 bits.
  local_address <= address(memory_address_width+1 downto 2);

  process(CLK)
  begin
      if(rising_edge(CLK)) then
          if(enable_write = '1' and habilita='1') then
              memRAM(to_integer(unsigned(local_address))) <= data;
          end if;
      end if;
  end process;

  -- A leitura deve ser sempre assincrona:
  output <= memRAM(to_integer(unsigned(local_address))) when (enable_read = '1' and habilita='1') else (others => 'Z');

end architecture;
