library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROMMIPS IS
   generic (
            data_width: natural := 32;
            address_width: natural := 32;
            memory_address_width:  natural := 6 
           );
   port (
          address : in  std_logic_vector (address_width-1 downto 0);
          data     : out std_logic_vector (data_width-1 downto 0)
        );
end entity;

architecture assincrona OF ROMMIPS IS
  type blocoMemoria IS ARRAY(0 TO 2**memory_address_width - 1) OF std_logic_vector(data_width-1 downto 0);

  signal memROM: blocoMemoria;
  attribute ram_init_file : string;
  attribute ram_init_file of memROM:
  signal is "ROMcontent.mif";
  signal local_address : std_logic_vector(memory_address_width-1 downto 0);
begin
  local_address <= address(memory_address_width+1 downto 2);
  data <= memROM (to_integer(unsigned(local_address)));
end architecture;