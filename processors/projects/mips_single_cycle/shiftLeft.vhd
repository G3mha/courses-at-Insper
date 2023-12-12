library ieee;
use ieee.std_logic_1164.all;

entity shiftLeft is
  port ( 
         input  : in  std_logic_vector(31 downto 0);
         shamt  : in  std_logic_vector(4 downto 0);
         output : out std_logic_vector(31 downto 0)
       );
end entity;

architecture comportamento of shiftLeft is
    signal zero : std_logic_vector(31 downto 0);
  begin
    zero <= "00000000000000000000000000000000";
    output <= input                                                                                         when to_integer(unsigned(shamt)) = 0 else
              input(30 downto 0) & '0'                                                                      when to_integer(unsigned(shamt)) = 1 else
              input(31-to_integer(unsigned(shamt)) downto 0) & zero(to_integer(unsigned(shamt))-1 downto 0) when to_integer(unsigned(shamt)) < 31 else
              input(to_integer(unsigned(shamt))) & zero(to_integer(unsigned(shamt))-1 downto 0)             when to_integer(unsigned(shamt)) = 31 else
              zero                                                                                          when to_integer(unsigned(shamt)) > 31 else
              input;
end architecture;