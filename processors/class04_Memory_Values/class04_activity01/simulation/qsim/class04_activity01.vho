-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

-- DATE "09/12/2023 12:14:48"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	topLevel IS
    PORT (
	CLOCK_50 : IN std_logic;
	KEY : IN std_logic_vector(3 DOWNTO 0);
	PC_OUT : OUT std_logic_vector(8 DOWNTO 0);
	LEDR : OUT std_logic_vector(9 DOWNTO 0);
	EntradaB_ULA : OUT std_logic_vector(7 DOWNTO 0);
	Palavra_Controle : OUT std_logic_vector(5 DOWNTO 0)
	);
END topLevel;

-- Design Ports Information
-- CLOCK_50	=>  Location: PIN_AA13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[1]	=>  Location: PIN_H11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[2]	=>  Location: PIN_G17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[3]	=>  Location: PIN_E2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- PC_OUT[0]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[1]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[2]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[3]	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[4]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[5]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[6]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[7]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_OUT[8]	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[0]	=>  Location: PIN_U1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[1]	=>  Location: PIN_V19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[2]	=>  Location: PIN_V21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[3]	=>  Location: PIN_U17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[4]	=>  Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[5]	=>  Location: PIN_Y19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[6]	=>  Location: PIN_R14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[7]	=>  Location: PIN_V18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[8]	=>  Location: PIN_U16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[9]	=>  Location: PIN_U21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- EntradaB_ULA[0]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[1]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[2]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[3]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[4]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[5]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[6]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EntradaB_ULA[7]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Palavra_Controle[0]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Palavra_Controle[1]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Palavra_Controle[2]	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Palavra_Controle[3]	=>  Location: PIN_T19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Palavra_Controle[4]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Palavra_Controle[5]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- KEY[0]	=>  Location: PIN_M16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF topLevel IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLOCK_50 : std_logic;
SIGNAL ww_KEY : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_PC_OUT : std_logic_vector(8 DOWNTO 0);
SIGNAL ww_LEDR : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_EntradaB_ULA : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_Palavra_Controle : std_logic_vector(5 DOWNTO 0);
SIGNAL \CLOCK_50~input_o\ : std_logic;
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \KEY[2]~input_o\ : std_logic;
SIGNAL \KEY[3]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \KEY[0]~inputCLKENA0_outclk\ : std_logic;
SIGNAL \PC|DOUT[0]~0_combout\ : std_logic;
SIGNAL \incrementaPC|Add0~1_sumout\ : std_logic;
SIGNAL \incrementaPC|Add0~2\ : std_logic;
SIGNAL \incrementaPC|Add0~5_sumout\ : std_logic;
SIGNAL \incrementaPC|Add0~6\ : std_logic;
SIGNAL \incrementaPC|Add0~9_sumout\ : std_logic;
SIGNAL \incrementaPC|Add0~10\ : std_logic;
SIGNAL \incrementaPC|Add0~13_sumout\ : std_logic;
SIGNAL \incrementaPC|Add0~14\ : std_logic;
SIGNAL \incrementaPC|Add0~17_sumout\ : std_logic;
SIGNAL \PC|DOUT[5]~DUPLICATE_q\ : std_logic;
SIGNAL \incrementaPC|Add0~18\ : std_logic;
SIGNAL \incrementaPC|Add0~21_sumout\ : std_logic;
SIGNAL \incrementaPC|Add0~22\ : std_logic;
SIGNAL \incrementaPC|Add0~25_sumout\ : std_logic;
SIGNAL \incrementaPC|Add0~26\ : std_logic;
SIGNAL \incrementaPC|Add0~29_sumout\ : std_logic;
SIGNAL \PC|DOUT[2]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|DOUT[1]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|DOUT[7]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|DOUT[4]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|DOUT[6]~DUPLICATE_q\ : std_logic;
SIGNAL \ROM1|memROM~1_combout\ : std_logic;
SIGNAL \DEC|Equal5~1_combout\ : std_logic;
SIGNAL \PC|DOUT[0]~DUPLICATE_q\ : std_logic;
SIGNAL \DEC|Equal5~0_combout\ : std_logic;
SIGNAL \PC|DOUT[3]~DUPLICATE_q\ : std_logic;
SIGNAL \ROM1|memROM~7_combout\ : std_logic;
SIGNAL \ROM1|memROM~3_combout\ : std_logic;
SIGNAL \ROM1|memROM~5_combout\ : std_logic;
SIGNAL \DEC|saida[0]~3_combout\ : std_logic;
SIGNAL \RAM1|ram~88_combout\ : std_logic;
SIGNAL \RAM1|ram~17_q\ : std_logic;
SIGNAL \ROM1|memROM~4_combout\ : std_logic;
SIGNAL \RAM1|ram~89_combout\ : std_logic;
SIGNAL \RAM1|ram~25_q\ : std_logic;
SIGNAL \RAM1|ram~90_combout\ : std_logic;
SIGNAL \ULA1|Add0~34_cout\ : std_logic;
SIGNAL \ULA1|Add0~1_sumout\ : std_logic;
SIGNAL \RAM1|ram~81_combout\ : std_logic;
SIGNAL \MUX1|saida_MUX[0]~0_combout\ : std_logic;
SIGNAL \DEC|saida[3]~4_combout\ : std_logic;
SIGNAL \ROM1|memROM~2_combout\ : std_logic;
SIGNAL \ROM1|memROM~0_combout\ : std_logic;
SIGNAL \DEC|saida[4]~1_combout\ : std_logic;
SIGNAL \ROM1|memROM~6_combout\ : std_logic;
SIGNAL \RAM1|ram~26_q\ : std_logic;
SIGNAL \RAM1|ram~18_q\ : std_logic;
SIGNAL \RAM1|ram~91_combout\ : std_logic;
SIGNAL \ULA1|Add0~2\ : std_logic;
SIGNAL \ULA1|Add0~5_sumout\ : std_logic;
SIGNAL \MUX1|saida_MUX[1]~1_combout\ : std_logic;
SIGNAL \RAM1|ram~27_q\ : std_logic;
SIGNAL \RAM1|ram~19_q\ : std_logic;
SIGNAL \RAM1|ram~82_combout\ : std_logic;
SIGNAL \MUX1|saida_MUX[2]~2_combout\ : std_logic;
SIGNAL \RAM1|ram~92_combout\ : std_logic;
SIGNAL \ULA1|Add0~6\ : std_logic;
SIGNAL \ULA1|Add0~9_sumout\ : std_logic;
SIGNAL \REGA|DOUT[2]~DUPLICATE_q\ : std_logic;
SIGNAL \DEC|saida[4]~2_combout\ : std_logic;
SIGNAL \RAM1|ram~20_q\ : std_logic;
SIGNAL \RAM1|ram~28_q\ : std_logic;
SIGNAL \RAM1|ram~83_combout\ : std_logic;
SIGNAL \RAM1|ram~93_combout\ : std_logic;
SIGNAL \ULA1|Add0~10\ : std_logic;
SIGNAL \ULA1|Add0~13_sumout\ : std_logic;
SIGNAL \MUX1|saida_MUX[3]~3_combout\ : std_logic;
SIGNAL \RAM1|ram~29_q\ : std_logic;
SIGNAL \RAM1|ram~21_q\ : std_logic;
SIGNAL \RAM1|ram~84_combout\ : std_logic;
SIGNAL \RAM1|ram~94_combout\ : std_logic;
SIGNAL \ULA1|Add0~14\ : std_logic;
SIGNAL \ULA1|Add0~17_sumout\ : std_logic;
SIGNAL \MUX1|saida_MUX[4]~4_combout\ : std_logic;
SIGNAL \RAM1|ram~30_q\ : std_logic;
SIGNAL \RAM1|ram~22_q\ : std_logic;
SIGNAL \RAM1|ram~85_combout\ : std_logic;
SIGNAL \RAM1|ram~95_combout\ : std_logic;
SIGNAL \ULA1|Add0~18\ : std_logic;
SIGNAL \ULA1|Add0~21_sumout\ : std_logic;
SIGNAL \MUX1|saida_MUX[5]~5_combout\ : std_logic;
SIGNAL \RAM1|ram~31_q\ : std_logic;
SIGNAL \RAM1|ram~23_q\ : std_logic;
SIGNAL \RAM1|ram~86_combout\ : std_logic;
SIGNAL \RAM1|ram~96_combout\ : std_logic;
SIGNAL \ULA1|Add0~22\ : std_logic;
SIGNAL \ULA1|Add0~25_sumout\ : std_logic;
SIGNAL \MUX1|saida_MUX[6]~6_combout\ : std_logic;
SIGNAL \RAM1|ram~24_q\ : std_logic;
SIGNAL \RAM1|ram~32_q\ : std_logic;
SIGNAL \RAM1|ram~87_combout\ : std_logic;
SIGNAL \RAM1|ram~97_combout\ : std_logic;
SIGNAL \ULA1|Add0~26\ : std_logic;
SIGNAL \ULA1|Add0~29_sumout\ : std_logic;
SIGNAL \MUX1|saida_MUX[7]~7_combout\ : std_logic;
SIGNAL \DEC|saida[4]~0_combout\ : std_logic;
SIGNAL \REGA|DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \PC|DOUT\ : std_logic_vector(8 DOWNTO 0);
SIGNAL \PC|ALT_INV_DOUT[7]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT[6]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT[4]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT[3]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT[2]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT[1]~DUPLICATE_q\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT[0]~DUPLICATE_q\ : std_logic;
SIGNAL \DEC|ALT_INV_Equal5~1_combout\ : std_logic;
SIGNAL \DEC|ALT_INV_saida[0]~3_combout\ : std_logic;
SIGNAL \DEC|ALT_INV_Equal5~0_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~7_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~97_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~96_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~95_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~94_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~93_combout\ : std_logic;
SIGNAL \DEC|ALT_INV_saida[4]~2_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~92_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~91_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~6_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~90_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~87_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~32_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~24_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~86_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~31_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~23_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~85_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~30_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~22_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~84_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~29_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~21_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~83_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~28_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~20_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~82_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~27_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~19_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~26_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~18_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~81_combout\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~25_q\ : std_logic;
SIGNAL \RAM1|ALT_INV_ram~17_q\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~5_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~4_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~3_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~2_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~1_combout\ : std_logic;
SIGNAL \ROM1|ALT_INV_memROM~0_combout\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT\ : std_logic_vector(8 DOWNTO 0);
SIGNAL \REGA|ALT_INV_DOUT\ : std_logic_vector(7 DOWNTO 0);

BEGIN

ww_CLOCK_50 <= CLOCK_50;
ww_KEY <= KEY;
PC_OUT <= ww_PC_OUT;
LEDR <= ww_LEDR;
EntradaB_ULA <= ww_EntradaB_ULA;
Palavra_Controle <= ww_Palavra_Controle;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\PC|ALT_INV_DOUT[7]~DUPLICATE_q\ <= NOT \PC|DOUT[7]~DUPLICATE_q\;
\PC|ALT_INV_DOUT[6]~DUPLICATE_q\ <= NOT \PC|DOUT[6]~DUPLICATE_q\;
\PC|ALT_INV_DOUT[4]~DUPLICATE_q\ <= NOT \PC|DOUT[4]~DUPLICATE_q\;
\PC|ALT_INV_DOUT[3]~DUPLICATE_q\ <= NOT \PC|DOUT[3]~DUPLICATE_q\;
\PC|ALT_INV_DOUT[2]~DUPLICATE_q\ <= NOT \PC|DOUT[2]~DUPLICATE_q\;
\PC|ALT_INV_DOUT[1]~DUPLICATE_q\ <= NOT \PC|DOUT[1]~DUPLICATE_q\;
\PC|ALT_INV_DOUT[0]~DUPLICATE_q\ <= NOT \PC|DOUT[0]~DUPLICATE_q\;
\DEC|ALT_INV_Equal5~1_combout\ <= NOT \DEC|Equal5~1_combout\;
\DEC|ALT_INV_saida[0]~3_combout\ <= NOT \DEC|saida[0]~3_combout\;
\DEC|ALT_INV_Equal5~0_combout\ <= NOT \DEC|Equal5~0_combout\;
\ROM1|ALT_INV_memROM~7_combout\ <= NOT \ROM1|memROM~7_combout\;
\RAM1|ALT_INV_ram~97_combout\ <= NOT \RAM1|ram~97_combout\;
\RAM1|ALT_INV_ram~96_combout\ <= NOT \RAM1|ram~96_combout\;
\RAM1|ALT_INV_ram~95_combout\ <= NOT \RAM1|ram~95_combout\;
\RAM1|ALT_INV_ram~94_combout\ <= NOT \RAM1|ram~94_combout\;
\RAM1|ALT_INV_ram~93_combout\ <= NOT \RAM1|ram~93_combout\;
\DEC|ALT_INV_saida[4]~2_combout\ <= NOT \DEC|saida[4]~2_combout\;
\RAM1|ALT_INV_ram~92_combout\ <= NOT \RAM1|ram~92_combout\;
\RAM1|ALT_INV_ram~91_combout\ <= NOT \RAM1|ram~91_combout\;
\ROM1|ALT_INV_memROM~6_combout\ <= NOT \ROM1|memROM~6_combout\;
\RAM1|ALT_INV_ram~90_combout\ <= NOT \RAM1|ram~90_combout\;
\RAM1|ALT_INV_ram~87_combout\ <= NOT \RAM1|ram~87_combout\;
\RAM1|ALT_INV_ram~32_q\ <= NOT \RAM1|ram~32_q\;
\RAM1|ALT_INV_ram~24_q\ <= NOT \RAM1|ram~24_q\;
\RAM1|ALT_INV_ram~86_combout\ <= NOT \RAM1|ram~86_combout\;
\RAM1|ALT_INV_ram~31_q\ <= NOT \RAM1|ram~31_q\;
\RAM1|ALT_INV_ram~23_q\ <= NOT \RAM1|ram~23_q\;
\RAM1|ALT_INV_ram~85_combout\ <= NOT \RAM1|ram~85_combout\;
\RAM1|ALT_INV_ram~30_q\ <= NOT \RAM1|ram~30_q\;
\RAM1|ALT_INV_ram~22_q\ <= NOT \RAM1|ram~22_q\;
\RAM1|ALT_INV_ram~84_combout\ <= NOT \RAM1|ram~84_combout\;
\RAM1|ALT_INV_ram~29_q\ <= NOT \RAM1|ram~29_q\;
\RAM1|ALT_INV_ram~21_q\ <= NOT \RAM1|ram~21_q\;
\RAM1|ALT_INV_ram~83_combout\ <= NOT \RAM1|ram~83_combout\;
\RAM1|ALT_INV_ram~28_q\ <= NOT \RAM1|ram~28_q\;
\RAM1|ALT_INV_ram~20_q\ <= NOT \RAM1|ram~20_q\;
\RAM1|ALT_INV_ram~82_combout\ <= NOT \RAM1|ram~82_combout\;
\RAM1|ALT_INV_ram~27_q\ <= NOT \RAM1|ram~27_q\;
\RAM1|ALT_INV_ram~19_q\ <= NOT \RAM1|ram~19_q\;
\RAM1|ALT_INV_ram~26_q\ <= NOT \RAM1|ram~26_q\;
\RAM1|ALT_INV_ram~18_q\ <= NOT \RAM1|ram~18_q\;
\RAM1|ALT_INV_ram~81_combout\ <= NOT \RAM1|ram~81_combout\;
\RAM1|ALT_INV_ram~25_q\ <= NOT \RAM1|ram~25_q\;
\RAM1|ALT_INV_ram~17_q\ <= NOT \RAM1|ram~17_q\;
\ROM1|ALT_INV_memROM~5_combout\ <= NOT \ROM1|memROM~5_combout\;
\ROM1|ALT_INV_memROM~4_combout\ <= NOT \ROM1|memROM~4_combout\;
\ROM1|ALT_INV_memROM~3_combout\ <= NOT \ROM1|memROM~3_combout\;
\ROM1|ALT_INV_memROM~2_combout\ <= NOT \ROM1|memROM~2_combout\;
\ROM1|ALT_INV_memROM~1_combout\ <= NOT \ROM1|memROM~1_combout\;
\ROM1|ALT_INV_memROM~0_combout\ <= NOT \ROM1|memROM~0_combout\;
\PC|ALT_INV_DOUT\(8) <= NOT \PC|DOUT\(8);
\PC|ALT_INV_DOUT\(7) <= NOT \PC|DOUT\(7);
\PC|ALT_INV_DOUT\(6) <= NOT \PC|DOUT\(6);
\PC|ALT_INV_DOUT\(5) <= NOT \PC|DOUT\(5);
\PC|ALT_INV_DOUT\(4) <= NOT \PC|DOUT\(4);
\PC|ALT_INV_DOUT\(3) <= NOT \PC|DOUT\(3);
\PC|ALT_INV_DOUT\(2) <= NOT \PC|DOUT\(2);
\PC|ALT_INV_DOUT\(1) <= NOT \PC|DOUT\(1);
\PC|ALT_INV_DOUT\(0) <= NOT \PC|DOUT\(0);
\REGA|ALT_INV_DOUT\(7) <= NOT \REGA|DOUT\(7);
\REGA|ALT_INV_DOUT\(6) <= NOT \REGA|DOUT\(6);
\REGA|ALT_INV_DOUT\(5) <= NOT \REGA|DOUT\(5);
\REGA|ALT_INV_DOUT\(4) <= NOT \REGA|DOUT\(4);
\REGA|ALT_INV_DOUT\(3) <= NOT \REGA|DOUT\(3);
\REGA|ALT_INV_DOUT\(2) <= NOT \REGA|DOUT\(2);
\REGA|ALT_INV_DOUT\(1) <= NOT \REGA|DOUT\(1);
\REGA|ALT_INV_DOUT\(0) <= NOT \REGA|DOUT\(0);

-- Location: IOOBUF_X54_Y18_N45
\PC_OUT[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(0),
	devoe => ww_devoe,
	o => ww_PC_OUT(0));

-- Location: IOOBUF_X54_Y20_N39
\PC_OUT[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(1),
	devoe => ww_devoe,
	o => ww_PC_OUT(1));

-- Location: IOOBUF_X54_Y17_N5
\PC_OUT[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(2),
	devoe => ww_devoe,
	o => ww_PC_OUT(2));

-- Location: IOOBUF_X54_Y17_N39
\PC_OUT[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(3),
	devoe => ww_devoe,
	o => ww_PC_OUT(3));

-- Location: IOOBUF_X54_Y18_N96
\PC_OUT[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(4),
	devoe => ww_devoe,
	o => ww_PC_OUT(4));

-- Location: IOOBUF_X54_Y16_N56
\PC_OUT[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT[5]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_PC_OUT(5));

-- Location: IOOBUF_X54_Y18_N79
\PC_OUT[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(6),
	devoe => ww_devoe,
	o => ww_PC_OUT(6));

-- Location: IOOBUF_X54_Y16_N39
\PC_OUT[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(7),
	devoe => ww_devoe,
	o => ww_PC_OUT(7));

-- Location: IOOBUF_X54_Y16_N22
\PC_OUT[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \PC|DOUT\(8),
	devoe => ww_devoe,
	o => ww_PC_OUT(8));

-- Location: IOOBUF_X0_Y19_N22
\LEDR[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(0),
	devoe => ww_devoe,
	o => ww_LEDR(0));

-- Location: IOOBUF_X51_Y0_N19
\LEDR[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(1),
	devoe => ww_devoe,
	o => ww_LEDR(1));

-- Location: IOOBUF_X51_Y0_N36
\LEDR[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT[2]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_LEDR(2));

-- Location: IOOBUF_X52_Y0_N2
\LEDR[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(3),
	devoe => ww_devoe,
	o => ww_LEDR(3));

-- Location: IOOBUF_X51_Y0_N53
\LEDR[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(4),
	devoe => ww_devoe,
	o => ww_LEDR(4));

-- Location: IOOBUF_X48_Y0_N42
\LEDR[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(5),
	devoe => ww_devoe,
	o => ww_LEDR(5));

-- Location: IOOBUF_X50_Y0_N2
\LEDR[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(6),
	devoe => ww_devoe,
	o => ww_LEDR(6));

-- Location: IOOBUF_X51_Y0_N2
\LEDR[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \REGA|DOUT\(7),
	devoe => ww_devoe,
	o => ww_LEDR(7));

-- Location: IOOBUF_X52_Y0_N19
\LEDR[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|Equal5~1_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(8));

-- Location: IOOBUF_X52_Y0_N53
\LEDR[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|saida[3]~4_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(9));

-- Location: IOOBUF_X54_Y16_N5
\EntradaB_ULA[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[0]~0_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(0));

-- Location: IOOBUF_X54_Y19_N39
\EntradaB_ULA[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[1]~1_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(1));

-- Location: IOOBUF_X54_Y20_N5
\EntradaB_ULA[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[2]~2_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(2));

-- Location: IOOBUF_X54_Y19_N5
\EntradaB_ULA[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[3]~3_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(3));

-- Location: IOOBUF_X54_Y21_N5
\EntradaB_ULA[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[4]~4_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(4));

-- Location: IOOBUF_X54_Y19_N56
\EntradaB_ULA[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[5]~5_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(5));

-- Location: IOOBUF_X54_Y20_N56
\EntradaB_ULA[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[6]~6_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(6));

-- Location: IOOBUF_X54_Y19_N22
\EntradaB_ULA[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MUX1|saida_MUX[7]~7_combout\,
	devoe => ww_devoe,
	o => ww_EntradaB_ULA(7));

-- Location: IOOBUF_X54_Y17_N56
\Palavra_Controle[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|saida[0]~3_combout\,
	devoe => ww_devoe,
	o => ww_Palavra_Controle(0));

-- Location: IOOBUF_X54_Y17_N22
\Palavra_Controle[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|saida[4]~0_combout\,
	devoe => ww_devoe,
	o => ww_Palavra_Controle(1));

-- Location: IOOBUF_X54_Y14_N62
\Palavra_Controle[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|Equal5~1_combout\,
	devoe => ww_devoe,
	o => ww_Palavra_Controle(2));

-- Location: IOOBUF_X54_Y14_N79
\Palavra_Controle[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|saida[3]~4_combout\,
	devoe => ww_devoe,
	o => ww_Palavra_Controle(3));

-- Location: IOOBUF_X54_Y21_N22
\Palavra_Controle[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|saida[4]~1_combout\,
	devoe => ww_devoe,
	o => ww_Palavra_Controle(4));

-- Location: IOOBUF_X54_Y20_N22
\Palavra_Controle[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DEC|Equal5~0_combout\,
	devoe => ww_devoe,
	o => ww_Palavra_Controle(5));

-- Location: IOIBUF_X54_Y18_N61
\KEY[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(0),
	o => \KEY[0]~input_o\);

-- Location: CLKCTRL_G10
\KEY[0]~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \KEY[0]~input_o\,
	outclk => \KEY[0]~inputCLKENA0_outclk\);

-- Location: LABCELL_X53_Y18_N9
\PC|DOUT[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \PC|DOUT[0]~0_combout\ = !\PC|DOUT\(0)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100000000111111110000000011111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(0),
	combout => \PC|DOUT[0]~0_combout\);

-- Location: FF_X53_Y18_N10
\PC|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \PC|DOUT[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(0));

-- Location: LABCELL_X53_Y18_N30
\incrementaPC|Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~1_sumout\ = SUM(( \PC|DOUT\(1) ) + ( \PC|DOUT\(0) ) + ( !VCC ))
-- \incrementaPC|Add0~2\ = CARRY(( \PC|DOUT\(1) ) + ( \PC|DOUT\(0) ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \PC|ALT_INV_DOUT\(0),
	datad => \PC|ALT_INV_DOUT\(1),
	cin => GND,
	sumout => \incrementaPC|Add0~1_sumout\,
	cout => \incrementaPC|Add0~2\);

-- Location: FF_X53_Y18_N31
\PC|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(1));

-- Location: LABCELL_X53_Y18_N33
\incrementaPC|Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~5_sumout\ = SUM(( \PC|DOUT\(2) ) + ( GND ) + ( \incrementaPC|Add0~2\ ))
-- \incrementaPC|Add0~6\ = CARRY(( \PC|DOUT\(2) ) + ( GND ) + ( \incrementaPC|Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(2),
	cin => \incrementaPC|Add0~2\,
	sumout => \incrementaPC|Add0~5_sumout\,
	cout => \incrementaPC|Add0~6\);

-- Location: FF_X53_Y18_N34
\PC|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~5_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(2));

-- Location: LABCELL_X53_Y18_N36
\incrementaPC|Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~9_sumout\ = SUM(( \PC|DOUT\(3) ) + ( GND ) + ( \incrementaPC|Add0~6\ ))
-- \incrementaPC|Add0~10\ = CARRY(( \PC|DOUT\(3) ) + ( GND ) + ( \incrementaPC|Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(3),
	cin => \incrementaPC|Add0~6\,
	sumout => \incrementaPC|Add0~9_sumout\,
	cout => \incrementaPC|Add0~10\);

-- Location: FF_X53_Y18_N37
\PC|DOUT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(3));

-- Location: LABCELL_X53_Y18_N39
\incrementaPC|Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~13_sumout\ = SUM(( \PC|DOUT\(4) ) + ( GND ) + ( \incrementaPC|Add0~10\ ))
-- \incrementaPC|Add0~14\ = CARRY(( \PC|DOUT\(4) ) + ( GND ) + ( \incrementaPC|Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(4),
	cin => \incrementaPC|Add0~10\,
	sumout => \incrementaPC|Add0~13_sumout\,
	cout => \incrementaPC|Add0~14\);

-- Location: FF_X53_Y18_N40
\PC|DOUT[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(4));

-- Location: FF_X53_Y18_N44
\PC|DOUT[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~17_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(5));

-- Location: LABCELL_X53_Y18_N42
\incrementaPC|Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~17_sumout\ = SUM(( \PC|DOUT\(5) ) + ( GND ) + ( \incrementaPC|Add0~14\ ))
-- \incrementaPC|Add0~18\ = CARRY(( \PC|DOUT\(5) ) + ( GND ) + ( \incrementaPC|Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(5),
	cin => \incrementaPC|Add0~14\,
	sumout => \incrementaPC|Add0~17_sumout\,
	cout => \incrementaPC|Add0~18\);

-- Location: FF_X53_Y18_N43
\PC|DOUT[5]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~17_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[5]~DUPLICATE_q\);

-- Location: LABCELL_X53_Y18_N45
\incrementaPC|Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~21_sumout\ = SUM(( \PC|DOUT\(6) ) + ( GND ) + ( \incrementaPC|Add0~18\ ))
-- \incrementaPC|Add0~22\ = CARRY(( \PC|DOUT\(6) ) + ( GND ) + ( \incrementaPC|Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(6),
	cin => \incrementaPC|Add0~18\,
	sumout => \incrementaPC|Add0~21_sumout\,
	cout => \incrementaPC|Add0~22\);

-- Location: FF_X53_Y18_N46
\PC|DOUT[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~21_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(6));

-- Location: LABCELL_X53_Y18_N48
\incrementaPC|Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~25_sumout\ = SUM(( \PC|DOUT\(7) ) + ( GND ) + ( \incrementaPC|Add0~22\ ))
-- \incrementaPC|Add0~26\ = CARRY(( \PC|DOUT\(7) ) + ( GND ) + ( \incrementaPC|Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(7),
	cin => \incrementaPC|Add0~22\,
	sumout => \incrementaPC|Add0~25_sumout\,
	cout => \incrementaPC|Add0~26\);

-- Location: FF_X53_Y18_N49
\PC|DOUT[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~25_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(7));

-- Location: LABCELL_X53_Y18_N51
\incrementaPC|Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \incrementaPC|Add0~29_sumout\ = SUM(( \PC|DOUT\(8) ) + ( GND ) + ( \incrementaPC|Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(8),
	cin => \incrementaPC|Add0~26\,
	sumout => \incrementaPC|Add0~29_sumout\);

-- Location: FF_X53_Y18_N53
\PC|DOUT[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~29_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(8));

-- Location: FF_X53_Y18_N35
\PC|DOUT[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~5_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[2]~DUPLICATE_q\);

-- Location: FF_X53_Y18_N32
\PC|DOUT[1]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[1]~DUPLICATE_q\);

-- Location: FF_X53_Y18_N50
\PC|DOUT[7]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~25_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[7]~DUPLICATE_q\);

-- Location: FF_X53_Y18_N41
\PC|DOUT[4]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[4]~DUPLICATE_q\);

-- Location: FF_X53_Y18_N47
\PC|DOUT[6]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~21_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[6]~DUPLICATE_q\);

-- Location: LABCELL_X53_Y18_N6
\ROM1|memROM~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~1_combout\ = ( !\PC|DOUT\(5) & ( (!\PC|DOUT[7]~DUPLICATE_q\ & (!\PC|DOUT[4]~DUPLICATE_q\ & (!\PC|DOUT\(8) & !\PC|DOUT[6]~DUPLICATE_q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[7]~DUPLICATE_q\,
	datab => \PC|ALT_INV_DOUT[4]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT\(8),
	datad => \PC|ALT_INV_DOUT[6]~DUPLICATE_q\,
	dataf => \PC|ALT_INV_DOUT\(5),
	combout => \ROM1|memROM~1_combout\);

-- Location: LABCELL_X53_Y18_N27
\DEC|Equal5~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|Equal5~1_combout\ = ( \ROM1|memROM~1_combout\ & ( (\PC|DOUT[2]~DUPLICATE_q\ & (!\PC|DOUT[1]~DUPLICATE_q\ & !\PC|DOUT\(3))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001010000000000000101000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT\(3),
	dataf => \ROM1|ALT_INV_memROM~1_combout\,
	combout => \DEC|Equal5~1_combout\);

-- Location: FF_X53_Y18_N11
\PC|DOUT[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \PC|DOUT[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[0]~DUPLICATE_q\);

-- Location: LABCELL_X53_Y18_N3
\DEC|Equal5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|Equal5~0_combout\ = ( \ROM1|memROM~1_combout\ & ( (!\PC|DOUT[2]~DUPLICATE_q\ & (!\PC|DOUT[0]~DUPLICATE_q\ & !\PC|DOUT\(3))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010001000000000001000100000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datab => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT\(3),
	dataf => \ROM1|ALT_INV_memROM~1_combout\,
	combout => \DEC|Equal5~0_combout\);

-- Location: FF_X53_Y18_N38
\PC|DOUT[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \incrementaPC|Add0~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[3]~DUPLICATE_q\);

-- Location: LABCELL_X53_Y18_N24
\ROM1|memROM~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~7_combout\ = ( \PC|DOUT[0]~DUPLICATE_q\ & ( (!\PC|DOUT[1]~DUPLICATE_q\ & (!\PC|DOUT[2]~DUPLICATE_q\ & !\PC|DOUT[3]~DUPLICATE_q\)) ) ) # ( !\PC|DOUT[0]~DUPLICATE_q\ & ( (\PC|DOUT[1]~DUPLICATE_q\ & !\PC|DOUT[3]~DUPLICATE_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100000000001100110000000011000000000000001100000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	dataf => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	combout => \ROM1|memROM~7_combout\);

-- Location: LABCELL_X53_Y18_N18
\ROM1|memROM~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~3_combout\ = ( !\PC|DOUT[6]~DUPLICATE_q\ & ( \ROM1|memROM~7_combout\ & ( (!\PC|DOUT\(8) & (!\PC|DOUT\(5) & (!\PC|DOUT[7]~DUPLICATE_q\ & !\PC|DOUT[4]~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(8),
	datab => \PC|ALT_INV_DOUT\(5),
	datac => \PC|ALT_INV_DOUT[7]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT[4]~DUPLICATE_q\,
	datae => \PC|ALT_INV_DOUT[6]~DUPLICATE_q\,
	dataf => \ROM1|ALT_INV_memROM~7_combout\,
	combout => \ROM1|memROM~3_combout\);

-- Location: LABCELL_X53_Y18_N0
\ROM1|memROM~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~5_combout\ = ( \ROM1|memROM~1_combout\ & ( (!\PC|DOUT[0]~DUPLICATE_q\ & (!\PC|DOUT[2]~DUPLICATE_q\ & !\PC|DOUT[3]~DUPLICATE_q\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011000000000000001100000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	dataf => \ROM1|ALT_INV_memROM~1_combout\,
	combout => \ROM1|memROM~5_combout\);

-- Location: LABCELL_X52_Y18_N27
\DEC|saida[0]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|saida[0]~3_combout\ = ( \PC|DOUT[0]~DUPLICATE_q\ & ( (!\PC|DOUT[2]~DUPLICATE_q\ & (!\PC|DOUT[3]~DUPLICATE_q\ & \ROM1|memROM~1_combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001010000000000000000000000000000010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	datad => \ROM1|ALT_INV_memROM~1_combout\,
	datae => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	combout => \DEC|saida[0]~3_combout\);

-- Location: LABCELL_X52_Y18_N6
\RAM1|ram~88\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~88_combout\ = ( \DEC|saida[0]~3_combout\ & ( !\ROM1|memROM~3_combout\ & ( (\PC|DOUT[0]~DUPLICATE_q\ & !\ROM1|memROM~5_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010100000101000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	datac => \ROM1|ALT_INV_memROM~5_combout\,
	datae => \DEC|ALT_INV_saida[0]~3_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~88_combout\);

-- Location: FF_X52_Y19_N14
\RAM1|ram~17\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(0),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~17_q\);

-- Location: LABCELL_X53_Y18_N57
\ROM1|memROM~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~4_combout\ = ( \ROM1|memROM~1_combout\ & ( (!\PC|DOUT[2]~DUPLICATE_q\ & (!\PC|DOUT[0]~DUPLICATE_q\ & (!\PC|DOUT[1]~DUPLICATE_q\ & !\PC|DOUT[3]~DUPLICATE_q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000001000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datab => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	dataf => \ROM1|ALT_INV_memROM~1_combout\,
	combout => \ROM1|memROM~4_combout\);

-- Location: LABCELL_X52_Y18_N12
\RAM1|ram~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~89_combout\ = ( \DEC|saida[0]~3_combout\ & ( \ROM1|memROM~3_combout\ & ( (\PC|DOUT[0]~DUPLICATE_q\ & !\ROM1|memROM~5_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000101000001010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	datac => \ROM1|ALT_INV_memROM~5_combout\,
	datae => \DEC|ALT_INV_saida[0]~3_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~89_combout\);

-- Location: FF_X52_Y19_N4
\RAM1|ram~25\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(0),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~25_q\);

-- Location: LABCELL_X52_Y19_N3
\RAM1|ram~90\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~90_combout\ = ( \RAM1|ram~25_q\ & ( \ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~4_combout\ & ((!\PC|DOUT\(1)) # (!\ROM1|memROM~5_combout\))) ) ) ) # ( !\RAM1|ram~25_q\ & ( \ROM1|memROM~3_combout\ & ( (!\PC|DOUT\(1) & (!\ROM1|memROM~4_combout\ & 
-- \ROM1|memROM~5_combout\)) ) ) ) # ( \RAM1|ram~25_q\ & ( !\ROM1|memROM~3_combout\ & ( (\RAM1|ram~17_q\ & (!\ROM1|memROM~4_combout\ & !\ROM1|memROM~5_combout\)) ) ) ) # ( !\RAM1|ram~25_q\ & ( !\ROM1|memROM~3_combout\ & ( (\RAM1|ram~17_q\ & 
-- (!\ROM1|memROM~4_combout\ & !\ROM1|memROM~5_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000000000000001100000000000000000000101000001111000010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(1),
	datab => \RAM1|ALT_INV_ram~17_q\,
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \ROM1|ALT_INV_memROM~5_combout\,
	datae => \RAM1|ALT_INV_ram~25_q\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~90_combout\);

-- Location: LABCELL_X52_Y19_N30
\ULA1|Add0~34\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~34_cout\ = CARRY(( !\DEC|Equal5~1_combout\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \DEC|ALT_INV_Equal5~1_combout\,
	cin => GND,
	cout => \ULA1|Add0~34_cout\);

-- Location: LABCELL_X52_Y19_N33
\ULA1|Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~1_sumout\ = SUM(( \REGA|DOUT\(0) ) + ( !\DEC|Equal5~1_combout\ $ (((!\DEC|Equal5~0_combout\ & ((\RAM1|ram~90_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~3_combout\)))) ) + ( \ULA1|Add0~34_cout\ ))
-- \ULA1|Add0~2\ = CARRY(( \REGA|DOUT\(0) ) + ( !\DEC|Equal5~1_combout\ $ (((!\DEC|Equal5~0_combout\ & ((\RAM1|ram~90_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~3_combout\)))) ) + ( \ULA1|Add0~34_cout\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101101001101000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_Equal5~1_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \ROM1|ALT_INV_memROM~3_combout\,
	datad => \REGA|ALT_INV_DOUT\(0),
	dataf => \RAM1|ALT_INV_ram~90_combout\,
	cin => \ULA1|Add0~34_cout\,
	sumout => \ULA1|Add0~1_sumout\,
	cout => \ULA1|Add0~2\);

-- Location: LABCELL_X53_Y19_N12
\RAM1|ram~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~81_combout\ = ( \ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( !\PC|DOUT\(1) ) ) ) # ( !\ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( \RAM1|ram~25_q\ ) ) ) # ( !\ROM1|memROM~5_combout\ & ( !\ROM1|memROM~3_combout\ & ( 
-- \RAM1|ram~17_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000110011001100111111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \RAM1|ALT_INV_ram~25_q\,
	datac => \RAM1|ALT_INV_ram~17_q\,
	datad => \PC|ALT_INV_DOUT\(1),
	datae => \ROM1|ALT_INV_memROM~5_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~81_combout\);

-- Location: LABCELL_X53_Y19_N21
\MUX1|saida_MUX[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[0]~0_combout\ = ( \RAM1|ram~81_combout\ & ( (!\DEC|Equal5~0_combout\ & ((!\ROM1|memROM~4_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~3_combout\)) ) ) # ( !\RAM1|ram~81_combout\ & ( (\ROM1|memROM~3_combout\ & 
-- \DEC|Equal5~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101000000000101010111110000010101011111000001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ROM1|ALT_INV_memROM~3_combout\,
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \DEC|ALT_INV_Equal5~0_combout\,
	dataf => \RAM1|ALT_INV_ram~81_combout\,
	combout => \MUX1|saida_MUX[0]~0_combout\);

-- Location: LABCELL_X52_Y18_N30
\DEC|saida[3]~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|saida[3]~4_combout\ = ( !\PC|DOUT[2]~DUPLICATE_q\ & ( (\ROM1|memROM~1_combout\ & !\PC|DOUT[3]~DUPLICATE_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001000100010001000100010000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ROM1|ALT_INV_memROM~1_combout\,
	datab => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	dataf => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	combout => \DEC|saida[3]~4_combout\);

-- Location: LABCELL_X52_Y18_N45
\ROM1|memROM~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~2_combout\ = ( !\PC|DOUT[0]~DUPLICATE_q\ & ( \PC|DOUT[2]~DUPLICATE_q\ & ( (\PC|DOUT[1]~DUPLICATE_q\ & !\PC|DOUT[3]~DUPLICATE_q\) ) ) ) # ( \PC|DOUT[0]~DUPLICATE_q\ & ( !\PC|DOUT[2]~DUPLICATE_q\ & ( !\PC|DOUT[3]~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000001010000010100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	datae => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	dataf => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	combout => \ROM1|memROM~2_combout\);

-- Location: LABCELL_X52_Y18_N39
\ROM1|memROM~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~0_combout\ = ( \PC|DOUT[0]~DUPLICATE_q\ & ( \PC|DOUT[2]~DUPLICATE_q\ & ( (!\PC|DOUT[1]~DUPLICATE_q\ & !\PC|DOUT[3]~DUPLICATE_q\) ) ) ) # ( !\PC|DOUT[0]~DUPLICATE_q\ & ( \PC|DOUT[2]~DUPLICATE_q\ & ( !\PC|DOUT[3]~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100001010000010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	datae => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	dataf => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	combout => \ROM1|memROM~0_combout\);

-- Location: LABCELL_X52_Y18_N3
\DEC|saida[4]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|saida[4]~1_combout\ = ( \PC|DOUT[3]~DUPLICATE_q\ & ( \ROM1|memROM~0_combout\ & ( \ROM1|memROM~1_combout\ ) ) ) # ( !\PC|DOUT[3]~DUPLICATE_q\ & ( \ROM1|memROM~0_combout\ & ( (\PC|DOUT[2]~DUPLICATE_q\ & \ROM1|memROM~1_combout\) ) ) ) # ( 
-- \PC|DOUT[3]~DUPLICATE_q\ & ( !\ROM1|memROM~0_combout\ & ( (\ROM1|memROM~2_combout\ & \ROM1|memROM~1_combout\) ) ) ) # ( !\PC|DOUT[3]~DUPLICATE_q\ & ( !\ROM1|memROM~0_combout\ & ( (\ROM1|memROM~1_combout\ & (!\PC|DOUT[2]~DUPLICATE_q\ $ 
-- (\ROM1|memROM~2_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010100101000000000000111100000000010101010000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datac => \ROM1|ALT_INV_memROM~2_combout\,
	datad => \ROM1|ALT_INV_memROM~1_combout\,
	datae => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	dataf => \ROM1|ALT_INV_memROM~0_combout\,
	combout => \DEC|saida[4]~1_combout\);

-- Location: FF_X52_Y19_N34
\REGA|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~1_sumout\,
	asdata => \MUX1|saida_MUX[0]~0_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(0));

-- Location: LABCELL_X52_Y18_N33
\ROM1|memROM~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM1|memROM~6_combout\ = ( \PC|DOUT[1]~DUPLICATE_q\ & ( (\ROM1|memROM~1_combout\ & (!\PC|DOUT[3]~DUPLICATE_q\ & (!\PC|DOUT[2]~DUPLICATE_q\ & !\PC|DOUT[0]~DUPLICATE_q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001000000000000000100000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ROM1|ALT_INV_memROM~1_combout\,
	datab => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	datac => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	dataf => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	combout => \ROM1|memROM~6_combout\);

-- Location: FF_X52_Y19_N19
\RAM1|ram~26\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(1),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~26_q\);

-- Location: FF_X52_Y18_N53
\RAM1|ram~18\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(1),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~18_q\);

-- Location: LABCELL_X52_Y19_N18
\RAM1|ram~91\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~91_combout\ = ( \RAM1|ram~26_q\ & ( \RAM1|ram~18_q\ & ( (!\ROM1|memROM~4_combout\ & ((!\ROM1|memROM~5_combout\) # ((!\PC|DOUT\(1) & \ROM1|memROM~3_combout\)))) ) ) ) # ( !\RAM1|ram~26_q\ & ( \RAM1|ram~18_q\ & ( (!\ROM1|memROM~4_combout\ & 
-- ((!\ROM1|memROM~3_combout\ & ((!\ROM1|memROM~5_combout\))) # (\ROM1|memROM~3_combout\ & (!\PC|DOUT\(1) & \ROM1|memROM~5_combout\)))) ) ) ) # ( \RAM1|ram~26_q\ & ( !\RAM1|ram~18_q\ & ( (\ROM1|memROM~3_combout\ & (!\ROM1|memROM~4_combout\ & ((!\PC|DOUT\(1)) 
-- # (!\ROM1|memROM~5_combout\)))) ) ) ) # ( !\RAM1|ram~26_q\ & ( !\RAM1|ram~18_q\ & ( (!\PC|DOUT\(1) & (\ROM1|memROM~3_combout\ & (\ROM1|memROM~5_combout\ & !\ROM1|memROM~4_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001000000000001100100000000011000010000000001111001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(1),
	datab => \ROM1|ALT_INV_memROM~3_combout\,
	datac => \ROM1|ALT_INV_memROM~5_combout\,
	datad => \ROM1|ALT_INV_memROM~4_combout\,
	datae => \RAM1|ALT_INV_ram~26_q\,
	dataf => \RAM1|ALT_INV_ram~18_q\,
	combout => \RAM1|ram~91_combout\);

-- Location: LABCELL_X52_Y19_N36
\ULA1|Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~5_sumout\ = SUM(( \REGA|DOUT\(1) ) + ( !\DEC|Equal5~1_combout\ $ (((!\DEC|Equal5~0_combout\ & ((\RAM1|ram~91_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~6_combout\)))) ) + ( \ULA1|Add0~2\ ))
-- \ULA1|Add0~6\ = CARRY(( \REGA|DOUT\(1) ) + ( !\DEC|Equal5~1_combout\ $ (((!\DEC|Equal5~0_combout\ & ((\RAM1|ram~91_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~6_combout\)))) ) + ( \ULA1|Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101101001101000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_Equal5~1_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \ROM1|ALT_INV_memROM~6_combout\,
	datad => \REGA|ALT_INV_DOUT\(1),
	dataf => \RAM1|ALT_INV_ram~91_combout\,
	cin => \ULA1|Add0~2\,
	sumout => \ULA1|Add0~5_sumout\,
	cout => \ULA1|Add0~6\);

-- Location: LABCELL_X53_Y19_N0
\MUX1|saida_MUX[1]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[1]~1_combout\ = ( \ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( (\PC|DOUT\(1) & \DEC|Equal5~0_combout\) ) ) ) # ( !\ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( (\RAM1|ram~26_q\ & !\DEC|Equal5~0_combout\) ) ) ) # ( 
-- \ROM1|memROM~5_combout\ & ( !\ROM1|memROM~3_combout\ & ( (\PC|DOUT\(1) & \DEC|Equal5~0_combout\) ) ) ) # ( !\ROM1|memROM~5_combout\ & ( !\ROM1|memROM~3_combout\ & ( (!\DEC|Equal5~0_combout\ & \RAM1|ram~18_q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011110000000001010000010100110000001100000000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(1),
	datab => \RAM1|ALT_INV_ram~26_q\,
	datac => \DEC|ALT_INV_Equal5~0_combout\,
	datad => \RAM1|ALT_INV_ram~18_q\,
	datae => \ROM1|ALT_INV_memROM~5_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \MUX1|saida_MUX[1]~1_combout\);

-- Location: FF_X52_Y19_N38
\REGA|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~5_sumout\,
	asdata => \MUX1|saida_MUX[1]~1_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(1));

-- Location: FF_X52_Y19_N23
\RAM1|ram~27\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(2),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~27_q\);

-- Location: FF_X52_Y18_N11
\RAM1|ram~19\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT[2]~DUPLICATE_q\,
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~19_q\);

-- Location: LABCELL_X53_Y19_N30
\RAM1|ram~82\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~82_combout\ = ( \PC|DOUT\(1) & ( \ROM1|memROM~3_combout\ & ( (\RAM1|ram~27_q\ & !\ROM1|memROM~5_combout\) ) ) ) # ( !\PC|DOUT\(1) & ( \ROM1|memROM~3_combout\ & ( (\ROM1|memROM~5_combout\) # (\RAM1|ram~27_q\) ) ) ) # ( \PC|DOUT\(1) & ( 
-- !\ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & \RAM1|ram~19_q\) ) ) ) # ( !\PC|DOUT\(1) & ( !\ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & \RAM1|ram~19_q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011110000000000001111000000111111001111110011000000110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \RAM1|ALT_INV_ram~27_q\,
	datac => \ROM1|ALT_INV_memROM~5_combout\,
	datad => \RAM1|ALT_INV_ram~19_q\,
	datae => \PC|ALT_INV_DOUT\(1),
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~82_combout\);

-- Location: LABCELL_X53_Y19_N51
\MUX1|saida_MUX[2]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[2]~2_combout\ = ( \RAM1|ram~82_combout\ & ( !\ROM1|memROM~4_combout\ $ (\DEC|Equal5~0_combout\) ) ) # ( !\RAM1|ram~82_combout\ & ( (\ROM1|memROM~4_combout\ & \DEC|Equal5~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111111110000000011111111000000001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \DEC|ALT_INV_Equal5~0_combout\,
	dataf => \RAM1|ALT_INV_ram~82_combout\,
	combout => \MUX1|saida_MUX[2]~2_combout\);

-- Location: FF_X52_Y19_N41
\REGA|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~9_sumout\,
	asdata => \MUX1|saida_MUX[2]~2_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(2));

-- Location: LABCELL_X52_Y19_N21
\RAM1|ram~92\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~92_combout\ = ( \RAM1|ram~27_q\ & ( \RAM1|ram~19_q\ & ( (!\ROM1|memROM~4_combout\ & ((!\ROM1|memROM~5_combout\) # ((!\PC|DOUT\(1) & \ROM1|memROM~3_combout\)))) ) ) ) # ( !\RAM1|ram~27_q\ & ( \RAM1|ram~19_q\ & ( (!\ROM1|memROM~4_combout\ & 
-- ((!\ROM1|memROM~3_combout\ & ((!\ROM1|memROM~5_combout\))) # (\ROM1|memROM~3_combout\ & (!\PC|DOUT\(1) & \ROM1|memROM~5_combout\)))) ) ) ) # ( \RAM1|ram~27_q\ & ( !\RAM1|ram~19_q\ & ( (\ROM1|memROM~3_combout\ & (!\ROM1|memROM~4_combout\ & ((!\PC|DOUT\(1)) 
-- # (!\ROM1|memROM~5_combout\)))) ) ) ) # ( !\RAM1|ram~27_q\ & ( !\RAM1|ram~19_q\ & ( (!\PC|DOUT\(1) & (\ROM1|memROM~3_combout\ & (!\ROM1|memROM~4_combout\ & \ROM1|memROM~5_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000100000001100000010000011000000001000001111000000100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(1),
	datab => \ROM1|ALT_INV_memROM~3_combout\,
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \ROM1|ALT_INV_memROM~5_combout\,
	datae => \RAM1|ALT_INV_ram~27_q\,
	dataf => \RAM1|ALT_INV_ram~19_q\,
	combout => \RAM1|ram~92_combout\);

-- Location: LABCELL_X52_Y19_N39
\ULA1|Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~9_sumout\ = SUM(( \REGA|DOUT\(2) ) + ( !\DEC|Equal5~1_combout\ $ (((!\DEC|Equal5~0_combout\ & ((\RAM1|ram~92_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~4_combout\)))) ) + ( \ULA1|Add0~6\ ))
-- \ULA1|Add0~10\ = CARRY(( \REGA|DOUT\(2) ) + ( !\DEC|Equal5~1_combout\ $ (((!\DEC|Equal5~0_combout\ & ((\RAM1|ram~92_combout\))) # (\DEC|Equal5~0_combout\ & (\ROM1|memROM~4_combout\)))) ) + ( \ULA1|Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101101001101000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_Equal5~1_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \REGA|ALT_INV_DOUT\(2),
	dataf => \RAM1|ALT_INV_ram~92_combout\,
	cin => \ULA1|Add0~6\,
	sumout => \ULA1|Add0~9_sumout\,
	cout => \ULA1|Add0~10\);

-- Location: FF_X52_Y19_N40
\REGA|DOUT[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~9_sumout\,
	asdata => \MUX1|saida_MUX[2]~2_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT[2]~DUPLICATE_q\);

-- Location: LABCELL_X52_Y19_N27
\DEC|saida[4]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|saida[4]~2_combout\ = ( \ROM1|memROM~1_combout\ & ( (\PC|DOUT\(3)) # (\PC|DOUT[2]~DUPLICATE_q\) ) ) # ( !\ROM1|memROM~1_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111101010101111111110101010111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datad => \PC|ALT_INV_DOUT\(3),
	dataf => \ROM1|ALT_INV_memROM~1_combout\,
	combout => \DEC|saida[4]~2_combout\);

-- Location: FF_X53_Y18_N23
\RAM1|ram~20\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(3),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~20_q\);

-- Location: FF_X53_Y18_N14
\RAM1|ram~28\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(3),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~28_q\);

-- Location: LABCELL_X53_Y18_N12
\RAM1|ram~83\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~83_combout\ = ( \ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & ((\RAM1|ram~28_q\))) # (\ROM1|memROM~5_combout\ & (!\PC|DOUT[1]~DUPLICATE_q\)) ) ) # ( !\ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & \RAM1|ram~20_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101000001010000010100000101001000100111011100100010011101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ROM1|ALT_INV_memROM~5_combout\,
	datab => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datac => \RAM1|ALT_INV_ram~20_q\,
	datad => \RAM1|ALT_INV_ram~28_q\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~83_combout\);

-- Location: LABCELL_X53_Y18_N54
\RAM1|ram~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~93_combout\ = ( \RAM1|ram~83_combout\ & ( !\ROM1|memROM~4_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ROM1|ALT_INV_memROM~4_combout\,
	dataf => \RAM1|ALT_INV_ram~83_combout\,
	combout => \RAM1|ram~93_combout\);

-- Location: LABCELL_X52_Y19_N42
\ULA1|Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~13_sumout\ = SUM(( \REGA|DOUT\(3) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~93_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~10\ ))
-- \ULA1|Add0~14\ = CARRY(( \REGA|DOUT\(3) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~93_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011111101001000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_saida[4]~2_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \DEC|ALT_INV_Equal5~1_combout\,
	datad => \REGA|ALT_INV_DOUT\(3),
	dataf => \RAM1|ALT_INV_ram~93_combout\,
	cin => \ULA1|Add0~10\,
	sumout => \ULA1|Add0~13_sumout\,
	cout => \ULA1|Add0~14\);

-- Location: LABCELL_X53_Y19_N45
\MUX1|saida_MUX[3]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[3]~3_combout\ = ( \RAM1|ram~83_combout\ & ( (!\ROM1|memROM~4_combout\ & !\DEC|Equal5~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000000000001111000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \DEC|ALT_INV_Equal5~0_combout\,
	dataf => \RAM1|ALT_INV_ram~83_combout\,
	combout => \MUX1|saida_MUX[3]~3_combout\);

-- Location: FF_X52_Y19_N43
\REGA|DOUT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~13_sumout\,
	asdata => \MUX1|saida_MUX[3]~3_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(3));

-- Location: FF_X52_Y18_N23
\RAM1|ram~29\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(4),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~29_q\);

-- Location: FF_X52_Y18_N16
\RAM1|ram~21\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(4),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~21_q\);

-- Location: LABCELL_X52_Y19_N9
\RAM1|ram~84\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~84_combout\ = ( \ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & ((\RAM1|ram~29_q\))) # (\ROM1|memROM~5_combout\ & (!\PC|DOUT\(1))) ) ) # ( !\ROM1|memROM~3_combout\ & ( (\RAM1|ram~21_q\ & !\ROM1|memROM~5_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000110011101010100011001110101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(1),
	datab => \RAM1|ALT_INV_ram~29_q\,
	datac => \RAM1|ALT_INV_ram~21_q\,
	datad => \ROM1|ALT_INV_memROM~5_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~84_combout\);

-- Location: LABCELL_X52_Y19_N12
\RAM1|ram~94\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~94_combout\ = ( \RAM1|ram~84_combout\ & ( !\ROM1|memROM~4_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	dataf => \RAM1|ALT_INV_ram~84_combout\,
	combout => \RAM1|ram~94_combout\);

-- Location: LABCELL_X52_Y19_N45
\ULA1|Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~17_sumout\ = SUM(( \REGA|DOUT\(4) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~94_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~14\ ))
-- \ULA1|Add0~18\ = CARRY(( \REGA|DOUT\(4) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~94_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011111101001000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_saida[4]~2_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \DEC|ALT_INV_Equal5~1_combout\,
	datad => \REGA|ALT_INV_DOUT\(4),
	dataf => \RAM1|ALT_INV_ram~94_combout\,
	cin => \ULA1|Add0~14\,
	sumout => \ULA1|Add0~17_sumout\,
	cout => \ULA1|Add0~18\);

-- Location: LABCELL_X52_Y19_N6
\MUX1|saida_MUX[4]~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[4]~4_combout\ = ( \RAM1|ram~84_combout\ & ( (!\ROM1|memROM~4_combout\ & !\DEC|Equal5~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000000000001111000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \DEC|ALT_INV_Equal5~0_combout\,
	dataf => \RAM1|ALT_INV_ram~84_combout\,
	combout => \MUX1|saida_MUX[4]~4_combout\);

-- Location: FF_X52_Y19_N46
\REGA|DOUT[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~17_sumout\,
	asdata => \MUX1|saida_MUX[4]~4_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(4));

-- Location: FF_X52_Y18_N58
\RAM1|ram~30\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(5),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~30_q\);

-- Location: FF_X52_Y18_N2
\RAM1|ram~22\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(5),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~22_q\);

-- Location: LABCELL_X53_Y18_N15
\RAM1|ram~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~85_combout\ = ( \ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & ((\RAM1|ram~30_q\))) # (\ROM1|memROM~5_combout\ & (!\PC|DOUT[1]~DUPLICATE_q\)) ) ) # ( !\ROM1|memROM~3_combout\ & ( (!\ROM1|memROM~5_combout\ & \RAM1|ram~22_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010101010000000001010101001001110010011100100111001001110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ROM1|ALT_INV_memROM~5_combout\,
	datab => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datac => \RAM1|ALT_INV_ram~30_q\,
	datad => \RAM1|ALT_INV_ram~22_q\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~85_combout\);

-- Location: LABCELL_X52_Y19_N24
\RAM1|ram~95\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~95_combout\ = ( \RAM1|ram~85_combout\ & ( !\ROM1|memROM~4_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ROM1|ALT_INV_memROM~4_combout\,
	dataf => \RAM1|ALT_INV_ram~85_combout\,
	combout => \RAM1|ram~95_combout\);

-- Location: LABCELL_X52_Y19_N48
\ULA1|Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~21_sumout\ = SUM(( \REGA|DOUT\(5) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~95_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~18\ ))
-- \ULA1|Add0~22\ = CARRY(( \REGA|DOUT\(5) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~95_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011111101001000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_saida[4]~2_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \DEC|ALT_INV_Equal5~1_combout\,
	datad => \REGA|ALT_INV_DOUT\(5),
	dataf => \RAM1|ALT_INV_ram~95_combout\,
	cin => \ULA1|Add0~18\,
	sumout => \ULA1|Add0~21_sumout\,
	cout => \ULA1|Add0~22\);

-- Location: LABCELL_X52_Y19_N15
\MUX1|saida_MUX[5]~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[5]~5_combout\ = ( \RAM1|ram~85_combout\ & ( (!\ROM1|memROM~4_combout\ & !\DEC|Equal5~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010101010000000001010101000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \DEC|ALT_INV_Equal5~0_combout\,
	dataf => \RAM1|ALT_INV_ram~85_combout\,
	combout => \MUX1|saida_MUX[5]~5_combout\);

-- Location: FF_X52_Y19_N49
\REGA|DOUT[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~21_sumout\,
	asdata => \MUX1|saida_MUX[5]~5_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(5));

-- Location: FF_X52_Y18_N25
\RAM1|ram~31\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(6),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~31_q\);

-- Location: FF_X52_Y18_N50
\RAM1|ram~23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(6),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~23_q\);

-- Location: LABCELL_X52_Y18_N51
\RAM1|ram~86\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~86_combout\ = ( \ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( !\PC|DOUT[1]~DUPLICATE_q\ ) ) ) # ( !\ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( \RAM1|ram~31_q\ ) ) ) # ( !\ROM1|memROM~5_combout\ & ( !\ROM1|memROM~3_combout\ 
-- & ( \RAM1|ram~23_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000000000000000001111000011111010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[1]~DUPLICATE_q\,
	datac => \RAM1|ALT_INV_ram~31_q\,
	datad => \RAM1|ALT_INV_ram~23_q\,
	datae => \ROM1|ALT_INV_memROM~5_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~86_combout\);

-- Location: LABCELL_X52_Y18_N18
\RAM1|ram~96\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~96_combout\ = (\RAM1|ram~86_combout\ & !\ROM1|memROM~4_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000001111000000000000111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \RAM1|ALT_INV_ram~86_combout\,
	datad => \ROM1|ALT_INV_memROM~4_combout\,
	combout => \RAM1|ram~96_combout\);

-- Location: LABCELL_X52_Y19_N51
\ULA1|Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~25_sumout\ = SUM(( \REGA|DOUT\(6) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~96_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~22\ ))
-- \ULA1|Add0~26\ = CARRY(( \REGA|DOUT\(6) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~96_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011111101001000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_saida[4]~2_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \DEC|ALT_INV_Equal5~1_combout\,
	datad => \REGA|ALT_INV_DOUT\(6),
	dataf => \RAM1|ALT_INV_ram~96_combout\,
	cin => \ULA1|Add0~22\,
	sumout => \ULA1|Add0~25_sumout\,
	cout => \ULA1|Add0~26\);

-- Location: LABCELL_X52_Y18_N54
\MUX1|saida_MUX[6]~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[6]~6_combout\ = ( !\ROM1|memROM~4_combout\ & ( \RAM1|ram~86_combout\ & ( !\DEC|Equal5~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \DEC|ALT_INV_Equal5~0_combout\,
	datae => \ROM1|ALT_INV_memROM~4_combout\,
	dataf => \RAM1|ALT_INV_ram~86_combout\,
	combout => \MUX1|saida_MUX[6]~6_combout\);

-- Location: FF_X52_Y19_N53
\REGA|DOUT[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~25_sumout\,
	asdata => \MUX1|saida_MUX[6]~6_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(6));

-- Location: FF_X52_Y18_N37
\RAM1|ram~24\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(7),
	sload => VCC,
	ena => \RAM1|ram~88_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~24_q\);

-- Location: FF_X52_Y18_N55
\RAM1|ram~32\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \REGA|DOUT\(7),
	sload => VCC,
	ena => \RAM1|ram~89_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM1|ram~32_q\);

-- Location: LABCELL_X53_Y19_N24
\RAM1|ram~87\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~87_combout\ = ( \ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( !\PC|DOUT\(1) ) ) ) # ( !\ROM1|memROM~5_combout\ & ( \ROM1|memROM~3_combout\ & ( \RAM1|ram~32_q\ ) ) ) # ( !\ROM1|memROM~5_combout\ & ( !\ROM1|memROM~3_combout\ & ( 
-- \RAM1|ram~24_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101000000000000000000001111000011111100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RAM1|ALT_INV_ram~24_q\,
	datab => \PC|ALT_INV_DOUT\(1),
	datac => \RAM1|ALT_INV_ram~32_q\,
	datae => \ROM1|ALT_INV_memROM~5_combout\,
	dataf => \ROM1|ALT_INV_memROM~3_combout\,
	combout => \RAM1|ram~87_combout\);

-- Location: LABCELL_X53_Y19_N39
\RAM1|ram~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAM1|ram~97_combout\ = ( !\ROM1|memROM~4_combout\ & ( \RAM1|ram~87_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ROM1|ALT_INV_memROM~4_combout\,
	dataf => \RAM1|ALT_INV_ram~87_combout\,
	combout => \RAM1|ram~97_combout\);

-- Location: LABCELL_X52_Y19_N54
\ULA1|Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA1|Add0~29_sumout\ = SUM(( \REGA|DOUT\(7) ) + ( !\DEC|Equal5~1_combout\ $ (((\RAM1|ram~97_combout\ & ((!\DEC|Equal5~0_combout\) # (\DEC|saida[4]~2_combout\))))) ) + ( \ULA1|Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011111101001000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \DEC|ALT_INV_saida[4]~2_combout\,
	datab => \DEC|ALT_INV_Equal5~0_combout\,
	datac => \DEC|ALT_INV_Equal5~1_combout\,
	datad => \REGA|ALT_INV_DOUT\(7),
	dataf => \RAM1|ALT_INV_ram~97_combout\,
	cin => \ULA1|Add0~26\,
	sumout => \ULA1|Add0~29_sumout\);

-- Location: LABCELL_X53_Y19_N9
\MUX1|saida_MUX[7]~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX1|saida_MUX[7]~7_combout\ = ( \RAM1|ram~87_combout\ & ( (!\ROM1|memROM~4_combout\ & !\DEC|Equal5~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000000000001111000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ROM1|ALT_INV_memROM~4_combout\,
	datad => \DEC|ALT_INV_Equal5~0_combout\,
	dataf => \RAM1|ALT_INV_ram~87_combout\,
	combout => \MUX1|saida_MUX[7]~7_combout\);

-- Location: FF_X52_Y19_N55
\REGA|DOUT[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \ULA1|Add0~29_sumout\,
	asdata => \MUX1|saida_MUX[7]~7_combout\,
	sload => \DEC|saida[3]~4_combout\,
	ena => \DEC|saida[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \REGA|DOUT\(7));

-- Location: LABCELL_X52_Y18_N21
\DEC|saida[4]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DEC|saida[4]~0_combout\ = ( \ROM1|memROM~0_combout\ & ( (\ROM1|memROM~1_combout\ & ((\PC|DOUT[3]~DUPLICATE_q\) # (\PC|DOUT[2]~DUPLICATE_q\))) ) ) # ( !\ROM1|memROM~0_combout\ & ( (\ROM1|memROM~2_combout\ & (\ROM1|memROM~1_combout\ & 
-- ((\PC|DOUT[3]~DUPLICATE_q\) # (\PC|DOUT[2]~DUPLICATE_q\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000111000000000000011100000000011101110000000001110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT[2]~DUPLICATE_q\,
	datab => \PC|ALT_INV_DOUT[3]~DUPLICATE_q\,
	datac => \ROM1|ALT_INV_memROM~2_combout\,
	datad => \ROM1|ALT_INV_memROM~1_combout\,
	dataf => \ROM1|ALT_INV_memROM~0_combout\,
	combout => \DEC|saida[4]~0_combout\);

-- Location: IOIBUF_X34_Y0_N35
\CLOCK_50~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK_50,
	o => \CLOCK_50~input_o\);

-- Location: IOIBUF_X34_Y45_N1
\KEY[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(1),
	o => \KEY[1]~input_o\);

-- Location: IOIBUF_X50_Y45_N35
\KEY[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(2),
	o => \KEY[2]~input_o\);

-- Location: IOIBUF_X0_Y20_N21
\KEY[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(3),
	o => \KEY[3]~input_o\);

-- Location: LABCELL_X44_Y13_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


