library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is
  port ( opcode : in  std_logic_vector(5  downto 0);
         funct  : in  std_logic_vector(5  downto 0);
         output : out std_logic_vector(15 downto 0)
      );
end entity;

architecture comportamento of controlUnit is
  alias sel_mux_lui_sr_sl : std_logic_vector(1 downto 0) is output(15 downto 14);
  alias jr                : std_logic is output(13);
  alias sel_mux_pc4_jmp   : std_logic is output(12);
  alias sel_mux_rt_rd     : std_logic_vector(1 downto 0) is output(11 downto 10);
  alias sel_ori_andi      : std_logic is output(9);
  alias enable_reg_wr     : std_logic is output(8);
  alias sel_mux_rt_imm    : std_logic is output(7);
  alias sel_type_r        : std_logic is output(6);
  alias sel_mux_alu_ram   : std_logic_vector(1 downto 0) is output(5 downto 4);
  alias beq               : std_logic is output(3);
  alias bne               : std_logic is output(2);
  alias enable_ram_rd     : std_logic is output(1);
  alias enable_ram_wr     : std_logic is output(0);

  constant opcode_R    : std_logic_vector(5 downto 0) := "000000"; -- opcode for all R-type instructions
  constant opcode_LW   : std_logic_vector(5 downto 0) := "100011"; -- 23
  constant opcode_SW   : std_logic_vector(5 downto 0) := "101011"; -- 2b
  constant opcode_BEQ  : std_logic_vector(5 downto 0) := "000100"; -- 04
  constant opcode_BNE  : std_logic_vector(5 downto 0) := "000101"; -- 05
  constant funct_ADDr  : std_logic_vector(5 downto 0) := "100000"; -- 20
  constant opcode_ADDi : std_logic_vector(5 downto 0) := "001000"; -- 08
  constant funct_SUBr  : std_logic_vector(5 downto 0) := "100010"; -- 22
  constant funct_ORr   : std_logic_vector(5 downto 0) := "100101"; -- 25
  constant opcode_ORi  : std_logic_vector(5 downto 0) := "001101"; -- 0d
  constant funct_NORr  : std_logic_vector(5 downto 0) := "100111"; -- 27
  constant funct_ANDr  : std_logic_vector(5 downto 0) := "100100"; -- 24
  constant opcode_ANDi : std_logic_vector(5 downto 0) := "001100"; -- 0c
  constant funct_SLT   : std_logic_vector(5 downto 0) := "101010"; -- 2a
  constant opcode_SLTi : std_logic_vector(5 downto 0) := "001010"; -- 0a
  constant opcode_JMP  : std_logic_vector(5 downto 0) := "000010"; -- 02
  constant opcode_JAL  : std_logic_vector(5 downto 0) := "000011"; -- 03
  constant funct_JR    : std_logic_vector(5 downto 0) := "001000"; -- 08
  constant opcode_LUI  : std_logic_vector(5 downto 0) := "001111"; -- 0f
  constant funct_SRL   : std_logic_vector(5 downto 0) := "000010"; -- 02
  constant funct_SLL   : std_logic_vector(5 downto 0) := "000000"; -- 00
  begin
  enable_ram_wr   <= '1'  when (opcode = opcode_SW)  else '0';
  enable_ram_rd   <= '1'  when (opcode = opcode_LW)  else '0';
  bne             <= '1'  when (opcode = opcode_BNE) else '0';
  beq             <= '1'  when (opcode = opcode_BEQ) else '0';
  sel_mux_alu_ram <= "01" when (opcode = opcode_LW)  else
                     "10" when (opcode = opcode_JAL) else
                     "11" when (opcode = opcode_LUI) or
                               (opcode = opcode_R and funct_SLL) or
                               (opcode = opcode_R and funct_SRL) else
                     "00";
  sel_type_r      <= '1'  when (opcode = opcode_R) else '0';
  sel_mux_rt_imm  <= '0'  when (opcode = opcode_R)   or
                               (opcode = opcode_BEQ) or
                               (opcode = opcode_BNE) else 
                     '1';
  enable_reg_wr   <= '1'  when (opcode = opcode_R)    or
                               (opcode = opcode_LW)   or
                               (opcode = opcode_ADDi) or
                               (opcode = opcode_ORi)  or
                               (opcode = opcode_ANDi) or
                               (opcode = opcode_SLTi) or
                               (opcode = opcode_JAL)  else
                     '0';
  sel_ori_andi    <= '1'  when (opcode = opcode_ORi)  or
                               (opcode = opcode_ANDi) else
                     '0';
  sel_mux_rt_rd   <= "01" when (opcode = opcode_R) else
                     "10" when (opcode = opcode_JAL) else
                     "00";
  sel_mux_pc4_jmp <= '1'  when (opcode = opcode_JMP) or
                               (opcode = opcode_JAL) else 
                     '0';
  jr              <= '1'  when (opcode = opcode_R and funct = funct_JR) else
                     '0';
  sel_mux_lui_sr_sl <= "00" when (opcode = opcode_LUI) else
                       "01" when (opcode = opcode_SRL) else
                       "10" when (opcode = opcode_SLL) else
                       "00";
end architecture;
