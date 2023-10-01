library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 13;
          addrWidth: natural := 8
    );
   port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0);
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture assincrona of memoriaROM is

  type blocoMemoria is array(0 TO 2**addrWidth - 1) of std_logic_vector(dataWidth-1 DOWNTO 0);
  
  constant NOP  : std_logic_vector(3 downto 0) := "0000";
  constant LDA  : std_logic_vector(3 downto 0) := "0001";
  constant SOMA : std_logic_vector(3 downto 0) := "0010";
  constant SUB  : std_logic_vector(3 downto 0) := "0011";
  constant LDI  : std_logic_vector(3 downto 0) := "0100";
  constant STA  : std_logic_vector(3 downto 0) := "0101";
  constant JMP  : std_logic_vector(3 downto 0) := "0110";
  
  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
  begin
      -- opcode  |  acessa memória?  |  endereço/valor
      -- Inicializa os endereços:
        tmp(0)  := JMP  & '0' & "00000100"; -- JMP @4
        tmp(1)  := JMP  & '1' & "00000101"; -- JMP @5
        tmp(2)  := NOP  & '0' & "00000000"; -- NOP
        tmp(3)  := NOP  & '0' & "00000000"; -- NOP
        tmp(4)  := JMP  & '1' & "00000001"; -- JMP @1
        tmp(5)  := NOP  & '0' & "00000000"; -- NOP
        tmp(6)  := JMP  & '1' & "00000110"; -- JMP @6
        tmp(7)  := NOP  & '0' & "00000000"; -- NOP
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;
