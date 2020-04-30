----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:48:05 04/26/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
---------------------------------------------------------------------------------

entity top is
	port(
		-- Inputs
		BTN0 			: in std_logic; 
		clk_i 		: in std_logic;
		srst_n_i		: in std_logic;
		en_i			: in std_logic;
		senzor_i 		: in std_logic; -- senzor signal IN
		
		-- Outputs
		disp_seg_o 	: out unsigned(7-1 downto 0);
		disp_dig_o 	: out unsigned(4-1 downto 0);
		senzor_o			: out std_logic -- senzor signal OUT  
	);

end top;

--------------------------------------------------------------------------------
-- Architecture declaration 
--------------------------------------------------------------------------------
architecture Behavioral of top is 
	 signal s_mod_num 	: unsigned(16-1 downto 0);
	 signal s_bcd 		: unsigned(16-1 downto 0);
	 signal s_cnt_0 	: unsigned(16-1 downto 0);
	 signal s_cnt_1 	: unsigned(4-1 downto 0); -- value of 4-bit binary adder
	 signal s_cnt_0_en 	: std_logic; -- enable for binary adder (echo signal)
	 signal s_srst_n_i	: std_logic; -- reset for binary_to_bcd converter
	 signal s_cnt_0_rst 	: std_logic;
	 signal s_cnt_1_rst 	: std_logic;

begin
	vzdalenost : entity work.vzdalenost
			port map (
				clk_i => clk_i,
				echo_i => senzor_i,
				BTN0 => BTN0,
				cnt_0_i => s_cnt_0,
				cnt_1_i => s_cnt_1,	
				trigger_o => senzor_o,
				cnt_0_en_o => s_cnt_0_en,
				cnt_0_rst_o => s_cnt_0_rst,
				cnt_1_rst_o => s_cnt_1_rst,
				mod_num_o => s_mod_num,
				srst_n_o => s_srst_n_i
			);

	binary_bcd : entity work.binary_bcd
			port map (
				clk => clk_i,
			   srst_n_i => s_srst_n_i,
				binary_in => s_mod_num,
				bcd3 => s_bcd(16-1 downto 12),
				bcd2 => s_bcd(12-1 downto 8),
				bcd1 => s_bcd(8-1 downto 4), 
				bcd0 => s_bcd(4-1 downto 0)
			);

	op : entity work.op
			port map (
				clk_i => clk_i,
				enable_0_i => s_cnt_0_rst,
				enable_1_i => s_cnt_1_rst,
				en_i => s_cnt_0_en,	
		      disp_seg_o => s_cnt_0,
				disp_dig_o => s_cnt_1
			);

	driver_7seg : entity work.driver_7seg
			port map (
				clk_i => clk_i,  				
				data3_i => s_bcd(16-1 downto 12),
				data2_i => s_bcd(12-1 downto 8), 
				data1_i => s_bcd(8-1 downto 4), 
				data0_i => s_bcd(4-1 downto 0),
				an_o => disp_dig_o,	-- 1-of-4
				seg_o => disp_seg_o	-- 7-segment
			);
end behavioral;
