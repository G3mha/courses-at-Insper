library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity programCounter is
    generic (
        data_width : natural := 8
    );
    port (input : in std_logic_vector(data_width-1 downto 0);
       output : out std_logic_vector(data_width-1 downto 0);
       ENABLE : in std_logic;
       CLK,RST : in std_logic
        );
end entity;

architecture comportamento of programCounter is
begin
    -- In Altera devices, register signals have a set priority.
    -- The HDL design should reflect this priority.
    process(RST, CLK)
    begin
        -- The asynchronous reset signal has the highest priority
        if (RST = '1') then
            output <= (others => '0');    -- Código reconfigurável.
        else
            -- At a clock edge, if asynchronous signals have not taken priority,
            -- respond to the appropriate synchronous signal.
            -- Check for synchronous reset, then synchronous load.
            -- If none of these takes precedence, update the register output
            -- to be the register input.
            if (rising_edge(CLK)) then
                if (ENABLE = '1') then
                        output <= input;
                end if;
            end if;
        end if;
    end process;
end architecture;