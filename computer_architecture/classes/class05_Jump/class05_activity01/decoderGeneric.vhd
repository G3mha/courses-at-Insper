library ieee;
use ieee.std_logic_1164.all;

entity decoderGeneric is
  port ( entrada : in std_logic_vector(3 downto 0);
         saida : out std_logic_vector(6 downto 0)
  );
end entity;

architecture comportamento of decoderGeneric is

  constant NOP  : std_logic_vector(3 downto 0) := "0000";
  constant LDA  : std_logic_vector(3 downto 0) := "0001";
  constant SOMA : std_logic_vector(3 downto 0) := "0010";
  constant SUB  : std_logic_vector(3 downto 0) := "0011";
  constant LDI  : std_logic_vector(3 downto 0) := "0100";
  constant STA  : std_logic_vector(3 downto 0) := "0101";
  constant JMP  : std_logic_vector(3 downto 0) := "0110";

  begin
saida <= "0000000" when entrada = NOP else
         "0011010" when entrada = LDA else
         "0010110" when entrada = SOMA else
         "0010010" when entrada = SUB else
         "0111000" when entrada = LDI else
         "0000001" when entrada = STA else
         "1000000" when entrada = JMP else
         "0000000";  -- NOP para os entradas Indefinidas
end architecture;