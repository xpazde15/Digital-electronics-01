--
-- Implementation of 4-bit binary counter.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation
use ieee.numeric_std.all;

--------------------------------------------------------------------------------
-- Entity declaration for top level
--------------------------------------------------------------------------------

entity op is

port (
      clk_i : in std_logic;       -- 10 kHz clock signal
	enable_1_i : in std_logic;     -- Synchronous reset

--    LD3, LD2   : out std_logic;     -- Onboard LEDs
--    LD1, LD0   : out std_logic;

	enable_0_i : in std_logic;
	en_i : in std_logic;
		  
	disp_seg_o : out unsigned(16-1 downto 0);
	disp_dig_o : out unsigned(4-1 downto 0)
    );
end op;



architecture behavioral of op is

begin

--------------------------------------------------------------------
-- Sub-block of binary_cnt entity
--------------------------------------------------------------------
	
BIN_CNT_0 : entity work.binary_cnt
        generic map (
			   g_NBIT => 16)
        port map (
            clk_i => clk_i,
            srst_n_i => enable_0_i,
            cnt_o => disp_seg_o,
				en_i => en_i
        );
		  
BIN_CNT_1 : entity work.binary_cnt
        generic map (
			   g_NBIT => 4)
        port map (
            clk_i => clk_i,
            srst_n_i => enable_1_i,
            cnt_o => disp_dig_o,
				en_i => '1'
        );
end behavioral;
