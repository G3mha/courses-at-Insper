library ieee;
use ieee.std_logic_1164.all;

entity controlUnitALU is
  port ( opcode     : in  std_logic_vector(5 downto 0);
         funct      : in  std_logic_vector(5 downto 0);
         sel_type_r : in  std_logic;
         output     : out std_logic_vector(3 downto 0)
  );
end entity;

architecture comportamento of controlUnitALU is
  -- Inputs
  constant LW   : std_logic_vector(5 downto 0) := "100011"; -- 23
  constant SW   : std_logic_vector(5 downto 0) := "101011"; -- 2b
  constant BEQ  : std_logic_vector(5 downto 0) := "000100"; -- 04
  constant BNE  : std_logic_vector(5 downto 0) := "000101"; -- 05
  constant ADDr : std_logic_vector(5 downto 0) := "100000"; -- 20
  constant ADDi : std_logic_vector(5 downto 0) := "001000"; -- 08
  constant SUBr : std_logic_vector(5 downto 0) := "100010"; -- 22
  constant ORr  : std_logic_vector(5 downto 0) := "100101"; -- 25
  constant ORi  : std_logic_vector(5 downto 0) := "001101"; -- 0d
  constant NORr : std_logic_vector(5 downto 0) := "100111"; -- 27
  constant ANDr : std_logic_vector(5 downto 0) := "100100"; -- 24
  constant ANDi : std_logic_vector(5 downto 0) := "001100"; -- 0c
  constant SLT  : std_logic_vector(5 downto 0) := "101010"; -- 2a
  constant SLTi : std_logic_vector(5 downto 0) := "001010"; -- 0a
  constant JMP  : std_logic_vector(5 downto 0) := "000010"; -- 02
  constant JAL  : std_logic_vector(5 downto 0) := "000011"; -- 03
  constant JR   : std_logic_vector(5 downto 0) := "001000"; -- 08
  constant LUI  : std_logic_vector(5 downto 0) := "001111"; -- 0f
  constant SRLr : std_logic_vector(5 downto 0) := "000010"; -- 02
  constant SLLr : std_logic_vector(5 downto 0) := "000000"; -- 00
  -- Outputs
  constant ANDctrl : std_logic_vector(3 downto 0) := "0000";
  constant ORctrl  : std_logic_vector(3 downto 0) := "0001";
  constant ADDctrl : std_logic_vector(3 downto 0) := "0010";
  constant SUBctrl : std_logic_vector(3 downto 0) := "0110";
  constant SLTctrl : std_logic_vector(3 downto 0) := "0111";
  constant NORctrl : std_logic_vector(3 downto 0) := "1110";
  -- Internal signals
  signal mux_out : std_logic_vector(5 downto 0);
  begin

  MUX_OPCODE_FUNCT : entity work.mux_2x1 generic map (data_width => 6)
                                         port map (A => opcode, B => funct, sel => sel_type_r, output => mux_out);

  output <= ADDctrl when (mux_out = LW  ) else
            ADDctrl when (mux_out = SW  ) else
            SUBctrl when (mux_out = BEQ ) else
            SUBctrl when (mux_out = BNE ) else
            ADDctrl when (mux_out = ADDr) else
            ADDctrl when (mux_out = ADDi) else
            SUBctrl when (mux_out = SUBr) else
            ORctrl  when (mux_out = ORr ) else
            ORctrl  when (mux_out = ORi ) else
            NORctrl when (mux_out = NORr) else
            ANDctrl when (mux_out = ANDr) else
            ANDctrl when (mux_out = ANDi) else
            SLTctrl when (mux_out = SLT ) else
            SLTctrl when (mux_out = SLTi) else
            ADDctrl when (mux_out = JMP ) else -- it doesn't matter
            ADDctrl when (mux_out = JAL ) else -- it doesn't matter
            ADDctrl when (mux_out = JR  ) else -- it doesn't matter
            ADDctrl when (mux_out = LUI ) else -- it doesn't matter
            ADDctrl when (mux_out = SRLr) else -- it doesn't matter
            ADDctrl when (mux_out = SLLr) else -- it doesn't matter
            ADDctrl; -- it doesn't matter (unindentified instruction)
end architecture;
