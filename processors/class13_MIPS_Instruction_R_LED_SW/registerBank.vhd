library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).

entity registerBank is
    generic
    (
        larguraDados        : natural := 32;
        larguraEndBancoRegs : natural := 5   --Resulta em 2^5=32 posicoes
    );
-- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
    port
    (
        clk        : in std_logic;
--
        enderecoA       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
        enderecoB       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
        enderecoC       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
--
        dadoEscritaC    : in std_logic_vector((larguraDados-1) downto 0);
--
        escreveC        : in std_logic := '0';
        saidaA          : out std_logic_vector((larguraDados -1) downto 0);
        saidaB          : out std_logic_vector((larguraDados -1) downto 0)
    );
end entity;

architecture comportamento of registerBank is

    subtype palavra_t is std_logic_vector((larguraDados-1) downto 0);
    type memoria_t is array(2**larguraEndBancoRegs-1 downto 0) of palavra_t;

function initMemory
        return memoria_t is variable tmp : memoria_t := (others => (others => '0'));
  begin
        -- Inicializa os endereços:
        tmp(0)  := x"AAAAAAAA";  -- Nao deve ter efeito.
        tmp(8)  := 32x"02";  -- $t0 = 0x02
        tmp(9)  := 32x"04";  -- $t1 = 0x04
        tmp(10) := 32x"0B";  -- $t2 = 0x0B
        tmp(11) := 32x"0C";  -- $t3 = 0x0C
        tmp(12) := 32x"0D";  -- $t4 = 0x0D
        tmp(13) := 32x"16";  -- $t5 = 0x16
        return tmp;
    end initMemory;

    -- Declaracao dos registradores:
    shared variable registrador : memoria_t := initMemory;
    signal zeroA, zeroB : std_logic;
    constant zero : std_logic_vector(larguraDados-1 downto 0) := (others => '0');
begin
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (escreveC = '1') then
                registrador(to_integer(unsigned(enderecoC))) := dadoEscritaC;
            end if;
        end if;
    end process;

    -- IF endereco = 0 : retorna ZERO
    zeroA <= '1' when to_integer(unsigned(enderecoA)) = to_integer(unsigned(zero)) else '0';
    zeroB <= '1' when to_integer(unsigned(enderecoB)) = to_integer(unsigned(zero)) else '0';

    saidaA <= registrador(to_integer(unsigned(enderecoA))) when zeroA = '0' else zero;
	 
    saidaB <= registrador(to_integer(unsigned(enderecoB))) when zeroB = '0' else zero;
	 
end architecture;