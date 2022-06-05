----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:16:59 05/17/2020 
-- Design Name: 
-- Module Name:    PC_stage - Behavioral 
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

entity PCIf_stage is
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);    
		Dataout : OUT std_logic_vector(31 downto 0)
		);
end PCIf_stage;

architecture Behavioural of PCIf_stage is
		
begin
	process 
		begin 
			wait until Clk'Event and Clk='1'; --clock palm
			if (Rst = '1') then -- synchronus reset (we can make it asycronus by making another if)
				Dataout <= "00000000000000000000000000000000";
			elsif(WE = '1') then 
				Dataout <= Datain;
			end if ;
	end process;
 -- i think we need to have the register here
end Behavioural;

