library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).

entity registerBank is
    generic
    (
        data_width    : natural := 32;
        address_width : natural := 5   --Resulta em 2^5=32 posicoes
    );
-- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
    port
    (
        CLK     : in std_logic;
--
        A       : in std_logic_vector((address_width-1) downto 0);
        B       : in std_logic_vector((address_width-1) downto 0);
        C       : in std_logic_vector((address_width-1) downto 0);
--
        data_to_write   : in std_logic_vector((data_width-1) downto 0);
--
        enable_write    : in std_logic := '0';
        outputA         : out std_logic_vector((data_width -1) downto 0);
        outputB         : out std_logic_vector((data_width -1) downto 0)
    );
end entity;

architecture comportamento of registerBank is

    subtype palavra_t is std_logic_vector((data_width-1) downto 0);
    type memoria_t is array(2**address_width-1 downto 0) of palavra_t;

function initMemory
        return memoria_t is variable tmp : memoria_t := (others => (others => '0'));
  begin
        -- Inicializa os endereços:
        tmp(0)  := x"AAAAAAAA";  -- Nao deve ter efeito.
        tmp(8)  := 32x"00"; -- $t0 = 0x00
        tmp(9)  := 32x"0A"; -- $t1 = 0x0A
        tmp(10) := 32x"0B"; -- $t2 = 0x0B
        tmp(11) := 32x"0C"; -- $t3 = 0x0C
        tmp(12) := 32x"0D"; -- $t4 = 0x0D
        tmp(13) := 32x"16"; -- $t5 = 0x16
        tmp(14) := 32x"09"; -- $t6 = 0x09
        tmp(15) := x"55555551"; -- $t7 = 010101 ... 01
        return tmp;
    end initMemory;

    -- Declaracao dos registradores:
    shared variable registrador : memoria_t := initMemory;
    signal zeroA, zeroB : std_logic;
    constant zero : std_logic_vector(data_width-1 downto 0) := (others => '0');
begin
    process(CLK) is
    begin
        if (rising_edge(CLK)) then
            if (enable_write = '1') then
                registrador(to_integer(unsigned(C))) := data_to_write;
            end if;
        end if;
    end process;

    -- IF endereco = 0 : retorna ZERO
    zeroA <= '1' when to_integer(unsigned(A)) = to_integer(unsigned(zero)) else '0';
    zeroB <= '1' when to_integer(unsigned(B)) = to_integer(unsigned(zero)) else '0';

    outputA <= registrador(to_integer(unsigned(A))) when zeroA = '0' else zero;
	 
    outputB <= registrador(to_integer(unsigned(B))) when zeroB = '0' else zero;
	 
end architecture;