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
-- Generated on "09/01/2023 17:48:25"
                                                             
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
SIGNAL CLOCK_50 : STD_LOGIC;
SIGNAL KEY : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL LEDR : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL PC_OUT : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0);
COMPONENT topLevel
	PORT (
	CLOCK_50 : IN STD_LOGIC;
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	PC_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : topLevel
	PORT MAP (
-- list connections between master ports and signals
	CLOCK_50 => CLOCK_50,
	KEY => KEY,
	LEDR => LEDR,
	PC_OUT => PC_OUT,
	SW => SW
	);

-- KEY[0]
t_prcs_KEY_0: PROCESS
BEGIN
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	FOR i IN 1 TO 24
	LOOP
		KEY(0) <= '0';
		WAIT FOR 20000 ps;
		KEY(0) <= '1';
		WAIT FOR 20000 ps;
	END LOOP;
	KEY(0) <= '0';
WAIT;
END PROCESS t_prcs_KEY_0;

-- SW[9]
t_prcs_SW_9: PROCESS
BEGIN
	SW(9) <= '0';
WAIT;
END PROCESS t_prcs_SW_9;

-- SW[8]
t_prcs_SW_8: PROCESS
BEGIN
	SW(8) <= '0';
	WAIT FOR 160000 ps;
	SW(8) <= '1';
	WAIT FOR 40000 ps;
	SW(8) <= '0';
WAIT;
END PROCESS t_prcs_SW_8;

-- SW[7]
t_prcs_SW_7: PROCESS
BEGIN
	SW(7) <= '1';
	WAIT FOR 160000 ps;
	SW(7) <= '0';
WAIT;
END PROCESS t_prcs_SW_7;

-- SW[6]
t_prcs_SW_6: PROCESS
BEGIN
	SW(6) <= '1';
	WAIT FOR 160000 ps;
	SW(6) <= '0';
WAIT;
END PROCESS t_prcs_SW_6;
END topLevel_arch;
