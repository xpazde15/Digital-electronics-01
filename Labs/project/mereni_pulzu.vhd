library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--------------------------------------------------------------------------

entity vzdalenost is 
	port( 
		clk_i : in std_logic;
		echo_i : in std_logic;
		BTN0 : in std_logic;
		cnt_0_i : unsigned(15 downto 0);
		cnt_1_i : in unsigned(3 downto 0);

		trigger_o : out std_logic := '0';
		cnt_0_en_o : out std_logic; 
		cnt_0_rst_o : out std_logic;
		cnt_1_rst_o : out std_logic :='0';
		mod_num_o : out unsigned(15 downto 0);
		srst_n_o : out std_logic
	);
end vzdalenost;

architecture behavioral of vzdalenost is 

	signal s_pulz	 	 : unsigned(15 downto 0) := (others => '0');
	signal s_echo_i_delay_r	 : std_logic := '0';
	signal s_echo_i_delay_f	 : std_logic := '0';
	signal s_BTN0_delay_r	 : std_logic := '0';
	signal s_BTN0_delay_f	 : std_logic := '0';

begin 

	-- Rising edge - echo_i
	process(clk_i) begin
		if rising_edge(clk_i) then
			s_echo_i_delay_r <= echo_i;
			if s_echo_i_delay_r = '0' and echo_i = '1' then
				cnt_0_rst_o <= '1';
				cnt_0_en_o <= '1';
			end if;
	-- Falling edge - echo_i
			s_echo_i_delay_f <= echo_i;
			if s_echo_i_delay_f = '1' and echo_i = '0' then
				cnt_0_en_o <= '0';
			end if;
   -- Falling edge - BTN0
			s_BTN0_delay_r <= BTN0;
			if s_BTN0_delay_r = '1' and BTN0 = '0' then
				trigger_o <= '1';
				cnt_1_rst_o <= '1';
				srst_n_o <= '0';
			end if;
	-- Rising edge - BTN0
			s_BTN0_delay_f <= BTN0;
			if s_BTN0_delay_f = '0' and BTN0 = '1' then
				s_pulz <= shift_right(unsigned(cnt_0_i),6);
				mod_num_o <= unsigned(s_pulz);
				srst_n_o <= '1';
				cnt_0_rst_o <= '0';
			end if;
			if cnt_1_i = "1010" then -- waiting 
				trigger_o <= '0';
				cnt_1_rst_o <= '0';
			end if;
		end if;
  end process;
end Behavioral;