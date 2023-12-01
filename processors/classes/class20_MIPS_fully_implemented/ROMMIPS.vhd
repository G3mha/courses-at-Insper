library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROMMIPS IS
   generic (
				 data_width			: natural := 32;
				 addr_width			: natural := 32;
				 memory_addr_width	:  natural := 6
			  );   -- 64 posicoes de 32 bits cada
			  
   port (
          address : in  std_logic_vector (addr_width-1 downto 0);
          data     : out std_logic_vector (data_width-1 downto 0) 
		  );
		  
end entity;

architecture assincrona OF ROMMIPS IS
  type blocoMemoria IS ARRAY(0 TO 2**memory_addr_width - 1) OF std_logic_vector(data_width-1 downto 0);

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
		  tmp(0) := x"AD280004"; -- sw $rt, immediate($rs) => sw $t0, 4($t1)
		  tmp(1) := x"8D290004"; -- lw $rt, immediate($rs) => lw $t1, 4($t1)
		  tmp(2) := x"11090002"; -- beq $rs, $rt, immediate => beq $t0, $t1, 2
		  tmp(3) := x"00000000"; -- nop
		  tmp(4) := x"00000000"; -- nop
		  tmp(5) := x"110AFFFE"; -- beq $rs, $rt, immediate => beq $t0, $t2, -2
		  tmp(6) := x"00000000"; -- nop
		  tmp(7) := x"08000002"; -- jmp 2
		  
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;
-- Utiliza uma quantidade menor de endereços locais:
   signal EnderecoLocal : std_logic_vector(memory_addr_width-1 downto 0);

begin
  EnderecoLocal <= address(memory_addr_width+1 downto 2);
  data <= memROM (to_integer(unsigned(EnderecoLocal)));
end architecture;