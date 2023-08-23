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

-- DATE "08/23/2023 11:28:44"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	topLevel IS
    PORT (
	dataIN : IN std_logic_vector(9 DOWNTO 0);
	dataOUT : OUT std_logic_vector(7 DOWNTO 0)
	);
END topLevel;

-- Design Ports Information
-- dataOUT[0]	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[1]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[2]	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[3]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[4]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[5]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[6]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOUT[7]	=>  Location: PIN_T8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[0]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[1]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[2]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[3]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[4]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[5]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[6]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[7]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[8]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIN[9]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL ww_dataIN : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_dataOUT : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \dataIN[9]~input_o\ : std_logic;
SIGNAL \dataIN[7]~input_o\ : std_logic;
SIGNAL \dataIN[6]~input_o\ : std_logic;
SIGNAL \dataIN[4]~input_o\ : std_logic;
SIGNAL \dataIN[5]~input_o\ : std_logic;
SIGNAL \dataIN[8]~input_o\ : std_logic;
SIGNAL \MemoriaROM|memROM~0_combout\ : std_logic;
SIGNAL \dataIN[1]~input_o\ : std_logic;
SIGNAL \dataIN[2]~input_o\ : std_logic;
SIGNAL \dataIN[0]~input_o\ : std_logic;
SIGNAL \dataIN[3]~input_o\ : std_logic;
SIGNAL \MemoriaROM|memROM~7_combout\ : std_logic;
SIGNAL \MemoriaROM|memROM~6_combout\ : std_logic;
SIGNAL \MemoriaROM|memROM~5_combout\ : std_logic;
SIGNAL \MemoriaROM|memROM~4_combout\ : std_logic;
SIGNAL \MemoriaROM|memROM~1_combout\ : std_logic;
SIGNAL \MemoriaROM|memROM~3_combout\ : std_logic;
SIGNAL \MemoriaROM|memROM~2_combout\ : std_logic;
SIGNAL \ALT_INV_dataIN[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_dataIN[0]~input_o\ : std_logic;
SIGNAL \MemoriaROM|ALT_INV_memROM~0_combout\ : std_logic;

BEGIN

ww_dataIN <= dataIN;
dataOUT <= ww_dataOUT;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_dataIN[9]~input_o\ <= NOT \dataIN[9]~input_o\;
\ALT_INV_dataIN[8]~input_o\ <= NOT \dataIN[8]~input_o\;
\ALT_INV_dataIN[7]~input_o\ <= NOT \dataIN[7]~input_o\;
\ALT_INV_dataIN[6]~input_o\ <= NOT \dataIN[6]~input_o\;
\ALT_INV_dataIN[5]~input_o\ <= NOT \dataIN[5]~input_o\;
\ALT_INV_dataIN[4]~input_o\ <= NOT \dataIN[4]~input_o\;
\ALT_INV_dataIN[3]~input_o\ <= NOT \dataIN[3]~input_o\;
\ALT_INV_dataIN[2]~input_o\ <= NOT \dataIN[2]~input_o\;
\ALT_INV_dataIN[1]~input_o\ <= NOT \dataIN[1]~input_o\;
\ALT_INV_dataIN[0]~input_o\ <= NOT \dataIN[0]~input_o\;
\MemoriaROM|ALT_INV_memROM~0_combout\ <= NOT \MemoriaROM|memROM~0_combout\;

-- Location: IOOBUF_X89_Y35_N62
\dataOUT[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~7_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(0));

-- Location: IOOBUF_X89_Y35_N96
\dataOUT[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~6_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(1));

-- Location: IOOBUF_X89_Y38_N39
\dataOUT[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~5_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(2));

-- Location: IOOBUF_X89_Y38_N22
\dataOUT[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~4_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(3));

-- Location: IOOBUF_X89_Y37_N39
\dataOUT[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~1_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(4));

-- Location: IOOBUF_X89_Y38_N56
\dataOUT[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~3_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(5));

-- Location: IOOBUF_X89_Y38_N5
\dataOUT[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MemoriaROM|memROM~2_combout\,
	devoe => ww_devoe,
	o => ww_dataOUT(6));

-- Location: IOOBUF_X6_Y0_N2
\dataOUT[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataOUT(7));

-- Location: IOIBUF_X89_Y36_N21
\dataIN[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(9),
	o => \dataIN[9]~input_o\);

-- Location: IOIBUF_X89_Y9_N4
\dataIN[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(7),
	o => \dataIN[7]~input_o\);

-- Location: IOIBUF_X89_Y37_N4
\dataIN[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(6),
	o => \dataIN[6]~input_o\);

-- Location: IOIBUF_X89_Y36_N4
\dataIN[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(4),
	o => \dataIN[4]~input_o\);

-- Location: IOIBUF_X89_Y36_N55
\dataIN[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(5),
	o => \dataIN[5]~input_o\);

-- Location: IOIBUF_X89_Y37_N55
\dataIN[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(8),
	o => \dataIN[8]~input_o\);

-- Location: LABCELL_X88_Y36_N0
\MemoriaROM|memROM~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~0_combout\ = ( !\dataIN[5]~input_o\ & ( !\dataIN[8]~input_o\ & ( (!\dataIN[9]~input_o\ & (!\dataIN[7]~input_o\ & (!\dataIN[6]~input_o\ & !\dataIN[4]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_dataIN[9]~input_o\,
	datab => \ALT_INV_dataIN[7]~input_o\,
	datac => \ALT_INV_dataIN[6]~input_o\,
	datad => \ALT_INV_dataIN[4]~input_o\,
	datae => \ALT_INV_dataIN[5]~input_o\,
	dataf => \ALT_INV_dataIN[8]~input_o\,
	combout => \MemoriaROM|memROM~0_combout\);

-- Location: IOIBUF_X89_Y36_N38
\dataIN[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(1),
	o => \dataIN[1]~input_o\);

-- Location: IOIBUF_X89_Y35_N78
\dataIN[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(2),
	o => \dataIN[2]~input_o\);

-- Location: IOIBUF_X89_Y35_N44
\dataIN[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(0),
	o => \dataIN[0]~input_o\);

-- Location: IOIBUF_X89_Y37_N21
\dataIN[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIN(3),
	o => \dataIN[3]~input_o\);

-- Location: LABCELL_X88_Y36_N42
\MemoriaROM|memROM~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~7_combout\ = ( \dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & (!\dataIN[1]~input_o\ $ (!\dataIN[2]~input_o\))) ) ) ) # ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ 
-- & ((!\dataIN[1]~input_o\) # (\dataIN[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010101000101000101000001010000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datab => \ALT_INV_dataIN[1]~input_o\,
	datac => \ALT_INV_dataIN[2]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~7_combout\);

-- Location: LABCELL_X88_Y36_N39
\MemoriaROM|memROM~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~6_combout\ = ( \dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & !\dataIN[1]~input_o\) ) ) ) # ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & ((\dataIN[1]~input_o\) # 
-- (\dataIN[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100001111000011110000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_dataIN[2]~input_o\,
	datac => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datad => \ALT_INV_dataIN[1]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~6_combout\);

-- Location: LABCELL_X88_Y36_N30
\MemoriaROM|memROM~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~5_combout\ = ( \dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & (!\dataIN[1]~input_o\ & !\dataIN[2]~input_o\)) ) ) ) # ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & 
-- (!\dataIN[1]~input_o\ $ (\dataIN[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000101000001010000000100000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datab => \ALT_INV_dataIN[1]~input_o\,
	datac => \ALT_INV_dataIN[2]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~5_combout\);

-- Location: LABCELL_X88_Y36_N27
\MemoriaROM|memROM~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~4_combout\ = ( \dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (!\dataIN[2]~input_o\ & \MemoriaROM|memROM~0_combout\) ) ) ) # ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\dataIN[2]~input_o\ & (\MemoriaROM|memROM~0_combout\ & 
-- \dataIN[1]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000101000010100000101000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_dataIN[2]~input_o\,
	datac => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datad => \ALT_INV_dataIN[1]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~4_combout\);

-- Location: LABCELL_X88_Y36_N6
\MemoriaROM|memROM~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~1_combout\ = ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & (\dataIN[1]~input_o\ & !\dataIN[2]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000000010000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datab => \ALT_INV_dataIN[1]~input_o\,
	datac => \ALT_INV_dataIN[2]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~1_combout\);

-- Location: LABCELL_X88_Y36_N48
\MemoriaROM|memROM~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~3_combout\ = ( \dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( \MemoriaROM|memROM~0_combout\ ) ) ) # ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & ((\dataIN[2]~input_o\) # (\dataIN[1]~input_o\))) 
-- ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001010100010101010101010101010100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datab => \ALT_INV_dataIN[1]~input_o\,
	datac => \ALT_INV_dataIN[2]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~3_combout\);

-- Location: LABCELL_X88_Y36_N15
\MemoriaROM|memROM~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \MemoriaROM|memROM~2_combout\ = ( \dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( (\MemoriaROM|memROM~0_combout\ & ((!\dataIN[2]~input_o\) # (!\dataIN[1]~input_o\))) ) ) ) # ( !\dataIN[0]~input_o\ & ( !\dataIN[3]~input_o\ & ( 
-- \MemoriaROM|memROM~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000101000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_dataIN[2]~input_o\,
	datac => \MemoriaROM|ALT_INV_memROM~0_combout\,
	datad => \ALT_INV_dataIN[1]~input_o\,
	datae => \ALT_INV_dataIN[0]~input_o\,
	dataf => \ALT_INV_dataIN[3]~input_o\,
	combout => \MemoriaROM|memROM~2_combout\);

-- Location: LABCELL_X75_Y4_N0
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


