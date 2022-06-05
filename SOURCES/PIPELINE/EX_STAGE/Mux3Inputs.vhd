----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:23:48 05/21/2020 
-- Design Name: 
-- Module Name:    Mux3Inputs - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux3Inputs is
port 
	(
		A : in std_logic_vector (31 downto 0);
		B : in std_logic_vector (31 downto 0);
		C : in std_logic_vector (31 downto 0);
		sel : in std_logic_vector(1 downto 0);
		X : out std_logic_vector (31 downto 0)
	);
end Mux3Inputs;

architecture Behavioral of Mux3Inputs is

begin
	process(sel, A, B, C)
		begin
		if (sel = "00") then 
			X<= A;
		elsif(sel ="01") then 
			X<=B;
		elsif(sel="10") then 
			X<=C;
		else
			X<= A;
		end if;
	end process;
end Behavioral;

