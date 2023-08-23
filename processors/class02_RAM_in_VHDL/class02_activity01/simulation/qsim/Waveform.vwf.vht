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

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "08/23/2023 11:28:43"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          topLevel
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY topLevel_vhd_vec_tst IS
END topLevel_vhd_vec_tst;
ARCHITECTURE topLevel_arch OF topLevel_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL dataIN : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL dataOUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT topLevel
	PORT (
	dataIN : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	dataOUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : topLevel
	PORT MAP (
-- list connections between master ports and signals
	dataIN => dataIN,
	dataOUT => dataOUT
	);

-- dataIN[9]
t_prcs_dataIN_9: PROCESS
BEGIN
	dataIN(9) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_9;

-- dataIN[8]
t_prcs_dataIN_8: PROCESS
BEGIN
	dataIN(8) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_8;

-- dataIN[7]
t_prcs_dataIN_7: PROCESS
BEGIN
	dataIN(7) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_7;

-- dataIN[6]
t_prcs_dataIN_6: PROCESS
BEGIN
	dataIN(6) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_6;

-- dataIN[5]
t_prcs_dataIN_5: PROCESS
BEGIN
	dataIN(5) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_5;

-- dataIN[4]
t_prcs_dataIN_4: PROCESS
BEGIN
	dataIN(4) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_4;

-- dataIN[3]
t_prcs_dataIN_3: PROCESS
BEGIN
	dataIN(3) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_3;

-- dataIN[2]
t_prcs_dataIN_2: PROCESS
BEGIN
	dataIN(2) <= '0';
	WAIT FOR 520000 ps;
	dataIN(2) <= '1';
WAIT;
END PROCESS t_prcs_dataIN_2;

-- dataIN[1]
t_prcs_dataIN_1: PROCESS
BEGIN
	dataIN(1) <= '0';
	WAIT FOR 230000 ps;
	dataIN(1) <= '1';
	WAIT FOR 290000 ps;
	dataIN(1) <= '0';
	WAIT FOR 190000 ps;
	dataIN(1) <= '1';
WAIT;
END PROCESS t_prcs_dataIN_1;

-- dataIN[0]
t_prcs_dataIN_0: PROCESS
BEGIN
	dataIN(0) <= '0';
	WAIT FOR 100000 ps;
	dataIN(0) <= '1';
	WAIT FOR 130000 ps;
	dataIN(0) <= '0';
	WAIT FOR 140000 ps;
	dataIN(0) <= '1';
	WAIT FOR 150000 ps;
	dataIN(0) <= '0';
	WAIT FOR 90000 ps;
	dataIN(0) <= '1';
	WAIT FOR 100000 ps;
	dataIN(0) <= '0';
WAIT;
END PROCESS t_prcs_dataIN_0;
END topLevel_arch;
