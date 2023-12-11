library ieee;
use ieee.std_logic_1164.all;

entity LUI is
    generic
    (
        data_width_in  : natural := 16;
        data_width_out : natural := 32
    );
    port
    (
        input  : in  std_logic_vector(data_width_in-1 downto 0);
        output : out std_logic_vector(data_width_out-1 downto 0)
    );
end entity;

architecture comportamento of LUI is
begin
    output <= input & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
end architecture;
