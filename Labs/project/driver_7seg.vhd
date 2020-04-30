library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation
use ieee.numeric_std.all;

--------------------------------------------------------------------------------
-- Entity declaration for driver 7seg
--------------------------------------------------------------------------------
entity driver_7seg is

    port (
        -- Entity input signals
        data3_i : in unsigned(4-1 downto 0);
        data2_i : in unsigned(4-1 downto 0);
        data1_i : in unsigned(4-1 downto 0);
        data0_i : in unsigned(4-1 downto 0);
        clk_i   : in std_logic;

        -- Entity output signals
        an_o   : out unsigned(4-1 downto 0);    -- 1-of-4 decoder
        seg_o : out unsigned(7-1 downto 0)     -- 7-segment display
    );
end driver_7seg;



--------------------------------------------------------------------------------
architecture Behavioral of driver_7seg is
    constant c_NBIT 	: integer := 7;
    signal s_cnt		: unsigned(c_NBIT-1 downto 0);
    signal s_hex 		: unsigned(4-1 downto 0);

begin

-----------------------------------------------------------------------------
-- sub-block of binary counter (display multiplexing)

    BINCNT : entity work.binary_cnt
        generic map (
            g_NBIT => c_NBIT
        )
        port map (
            clk_i => clk_i,
            srst_n_i => '1',
            cnt_o => s_cnt,
				en_i => '1'
        );
		  
-----------------------------------------------------------------------------              
-- sub-block of 4-bit 4-to-1 multiplexer

    s_hex <= data0_i when (s_cnt(c_NBIT-1 downto c_NBIT-2) = "00") else
             data1_i when (s_cnt(c_NBIT-1 downto c_NBIT-2) = "01") else
             data2_i when (s_cnt(c_NBIT-1 downto c_NBIT-2) = "10") else
             data3_i;
				 
-----------------------------------------------------------------------------
-- sub-block of hex_to_7seg entity

    HEX27SEG : entity work.hex_to_7seg
        port map (
            hex_i => s_hex,     -- 4-bit data to decode
            seg_o => seg_o    -- 7-bit signal for 7-segment display
        );
		  
-----------------------------------------------------------------------------
-- sub-block of one_of_four entity
    ONEOFFOUR : entity work.one_of_four
        port map (
            a_i => s_cnt(c_NBIT-1 downto c_NBIT-2),
            y_o => an_o 
        );

end behavioral;
