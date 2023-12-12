library ieee;
use ieee.std_logic_1164.all;

entity shiftRight is
  port ( 
         input  : in  std_logic_vector(31 downto 0);
         shamt  : in  std_logic_vector(4 downto 0);
         output : out std_logic_vector(31 downto 0)
       );
end entity;

architecture comportamento of shiftRight is
    signal zero : std_logic_vector(31 downto 0);
    signal 
  begin
    zero <= "00000000000000000000000000000000";
    output <= input                                                                                       when to_integer(unsigned(shamt)) = 0 else
              '0' & input(30 downto 0)                                                                    when to_integer(unsigned(shamt)) = 1 else
              zero(to_integer(unsigned(shamt))-1 downto 0) & input(31 downto to_integer(unsigned(shamt))) when to_integer(unsigned(shamt)) < 31 else
              zero(to_integer(unsigned(shamt))-1 downto 0) & input(to_integer(unsigned(shamt)))           when to_integer(unsigned(shamt)) = 31 else
              zero                                                                                        when to_integer(unsigned(shamt)) > 31 else
              input;
end architecture;