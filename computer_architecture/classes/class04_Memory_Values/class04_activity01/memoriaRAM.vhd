library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaRAM is
   generic (
         dataWidth: natural := 8;
         addrWidth: natural := 8
    );
    port
    (
        addr     : in std_logic_vector(addrWidth-1 downto 0);
        we, re   : in std_logic;
        habilita : in std_logic;
        clk      : in std_logic;
        dado_in  : in std_logic_vector(dataWidth-1 downto 0);
        dado_out : out std_logic_vector(dataWidth-1 downto 0)
    );
end entity;

architecture rtl of memoriaRAM is
    -- Build a 2-D array type for the RAM
    subtype word_t is std_logic_vector(dataWidth-1 downto 0);
    type memory_t is array((2**addrWidth-1) downto 0) of word_t;

    -- Declare the RAM signal.
    signal ram : memory_t;
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(we = '1' and habilita='1') then
                ram(to_integer(unsigned(addr))) <= dado_in;
            end if;
        end if;
    end process;

    -- A leitura é sempre assincrona e quando houver habilitacao:
    dado_out <= ram(to_integer(unsigned(addr))) when (re = '1' and habilita='1') else (others => 'Z');
end architecture;
