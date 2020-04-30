----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:08:05 04/26/2020 
-- Design Name: 
-- Module Name:    one_of_four - Behavioral 
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--------------------------------------------------------------------------------

entity one_of_four is
port (
    a_i : in  unsigned(2-1 downto 0);
    y_o : out unsigned(4-1 downto 0)
);
end entity one_of_four;

architecture behavioral of one_of_four is

begin

    y_o(3) <= not(a_i(0)) or not(a_i(1));
    y_o(2) <= a_i(0) or not(a_i(1));
    y_o(1) <= not(a_i(0)) or a_i(1);
    y_o(0) <= a_i(0) or a_i(1);

end behavioral;
