library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- IEEE library for arithmetic functions

entity adder is
    generic
    (
        data_width : natural := 32
    );
    port
    (
        A, B   : in  std_logic_vector((data_width-1) downto 0);
        output : out std_logic_vector((data_width-1) downto 0)
    );
end entity;

architecture comportamento of adder is
    begin
        output <= std_logic_vector(unsigned(A) + unsigned(B));
end architecture;