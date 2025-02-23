library ieee;
use ieee.std_logic_1164.all;

entity decoderGeneric is
  port ( entrada : in std_logic_vector(3 downto 0);
         saida : out std_logic_vector(3 downto 0)
  );
end entity;

architecture comportamento of decoderGeneric is

  constant NOP  : std_logic_vector(3 downto 0) := "0000";
  constant LDA  : std_logic_vector(3 downto 0) := "0001";
  constant SOMA : std_logic_vector(3 downto 0) := "0010";
  constant SUB  : std_logic_vector(3 downto 0) := "0011";
  constant CLRA : std_logic_vector(3 downto 0) := "1111";

  begin
saida <= "0000" when entrada = NOP else
         "0100" when entrada = LDA else
         "1101" when entrada = SOMA else
         "1100" when entrada = SUB else
         "1011" when entrada = CLRA else
         "0000";  -- NOP para os entradas Indefinidas
end architecture;