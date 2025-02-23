library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftRight is
  port ( 
         input  : in  std_logic_vector(31 downto 0);
         shamt  : in  std_logic_vector(4 downto 0);
         output : out std_logic_vector(31 downto 0)
       );
end entity;

architecture comportamento of shiftRight is
  begin
  process(input, shamt)
    variable shamt_int : natural;
  begin
    shamt_int := to_integer(unsigned(shamt));

    for i in 0 to 31 loop
      if i + shamt_int < 32 then
        output(i) <= input(i + shamt_int);
      else
        output(i) <= '0';
      end if;
    end loop;
  end process;
end architecture;
