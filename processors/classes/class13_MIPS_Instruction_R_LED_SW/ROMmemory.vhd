library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROMmemory IS
   generic (
				 dataWidth			: natural := 32;
				 addrWidth			: natural := 32;
				 memoryAddrWidth	:  natural := 6
			  );   -- 64 posicoes de 32 bits cada
			  
   port (
          Endereco : in  std_logic_vector (addrWidth-1 downto 0);
          Dado     : out std_logic_vector (dataWidth-1 downto 0) 
		  );
		  
end entity;

architecture assincrona OF ROMmemory IS
  type blocoMemoria IS ARRAY(0 TO 2**memoryAddrWidth - 1) OF std_logic_vector(dataWidth-1 downto 0);

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
		  
  begin	
		  -- opcode	  Rs	   Rt	  Rd	   shamt	 funct
		  -- 31~26  25~21  20~16 15~11   10~6    5~0

		  -- Opcode for type R instructions: 0b00_0000;

		  -- Rs: e.g. $v1 = 3 = 0b0_0011; For full list, see MIPS Green Sheet; 

		  -- Rt: e.g. $zero = 0 = 0b0_0000; For full list, see MIPS Green Sheet;

		  -- Rd: e.g. $a0 = 4 = 0b0_0100; For full list, see MIPS Green Sheet;

		  -- shamt (not used): 0b0_0000 (0x00);

		  -- funct (sub operation):  0b10_0010 (0x22);
		  -- funct (sum operation):  0b10_0000 (0x20).
		  
		  --         opcode	     Rs	       Rt        Rd       shamt     funct
		  tmp(0) := "000000" & "01000" & "01000" & "01000" & "00000" & "100000";
		  -- result: $t0 = $t0 + $t0
		  tmp(1) := "000000" & "01000" & "01000" & "01000" & "00000" & "100010";
		  -- result: $t0 = $t0 - $t0
		  tmp(2) := "000000" & "01000" & "01000" & "01000" & "00000" & "100010";
		  -- result: $t0 = $t0 - $t0

        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;
-- Utiliza uma quantidade menor de endereços locais:
   signal EnderecoLocal : std_logic_vector(memoryAddrWidth-1 downto 0);

begin
  EnderecoLocal <= Endereco(memoryAddrWidth+1 downto 2);
  Dado <= memROM (to_integer(unsigned(EnderecoLocal)));
end architecture;