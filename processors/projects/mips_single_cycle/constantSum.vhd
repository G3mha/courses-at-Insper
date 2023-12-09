library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity constantSum is
    generic
    (
        data_width : natural := 32;
        k : natural := 4
    );
    port
    (
        input  : in  std_logic_vector((data_width-1) downto 0);
        output : out std_logic_vector((data_width-1) downto 0)
    );
end entity;

architecture comportamento of constantSum is
    begin
        output <= std_logic_vector(unsigned(input) + k);
end architecture;