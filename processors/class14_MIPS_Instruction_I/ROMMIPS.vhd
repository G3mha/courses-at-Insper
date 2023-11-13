library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROMMIPS IS
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

architecture assincrona OF ROMMIPS IS
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
		  
		  --         opcode	     Rs	     Rt          immediate
		  tmp(0) := "011001" & "01001" & "01000" & "0000000000000100"; -- sw $rt, immediate($rs) => sw $t0, 4($t1)
		  tmp(1) := "111010" & "01000" & "01010" & "0000000000000110"; -- lw $rt, immediate($rs) => lw $t2, 6($t0)
		  tmp(2) := "000100" & "01000" & "01010" & "0000000000000101"; -- beq $rs, $rt, immediate => beq $t0, $t2, 5
		  tmp(3) := "011001" & "01000" & "01001" & "0000000000000110"; -- sw $rt, immediate($rs) => sw $t1, 6($t0)
		  tmp(4) := "111010" & "01000" & "01010" & "0000000000000110"; -- lw $rt, immediate($rs) => lw $t2, 6($t0)
		  tmp(5) := "000100" & "01000" & "01010" & "0000000000000011"; -- beq $rs, $rt, immediate => beq $t0, $t2, 3
		  tmp(6) := "000000" & "00000" & "00000" & "0000000000000000"; -- nop
		  
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;
-- Utiliza uma quantidade menor de endereços locais:
   signal EnderecoLocal : std_logic_vector(memoryAddrWidth-1 downto 0);

begin
  EnderecoLocal <= Endereco(memoryAddrWidth+1 downto 2);
  Dado <= memROM (to_integer(unsigned(EnderecoLocal)));
end architecture;