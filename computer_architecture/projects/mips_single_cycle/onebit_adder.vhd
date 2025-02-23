library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- IEEE library for arithmetic functions

entity onebit_adder is
    port
    (
        A, B, carry_in    : in  std_logic;
        carry_out, output : out std_logic
    );
end entity;

architecture comportamento of onebit_adder is
    signal xor1_out, and1_out, and2_out : std_logic;
    begin
        carry_out <= (A and B) or (carry_in and (A xor B));
        output <= (carry_in xor (A xor B));
end architecture;