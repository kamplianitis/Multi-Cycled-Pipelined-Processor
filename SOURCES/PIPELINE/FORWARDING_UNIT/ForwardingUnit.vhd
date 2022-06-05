----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:21:53 05/21/2020 
-- Design Name: 
-- Module Name:    ForwardingUnit - Behavioral 
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

entity ForwardingUnit is
port
	(
		Clk : in std_logic;
		Rst : in std_logic;
		RegRs : in std_logic_vector(4 downto 0);
		RegRt : in std_logic_vector(4 downto 0);
		RdfromPipe2 : in std_logic_vector(4 downto 0);
		RdfromPipe3 : in std_logic_vector(4 downto 0);
		Opcode : in std_logic_vector(5 downto 0);
		Rfa_sel : out std_logic_vector(1 downto 0);
		Rfb_sel : out std_logic_vector(1 downto 0)
	);
end ForwardingUnit;

architecture Behavioral of ForwardingUnit is

begin

	process(RegRs, RegRt, Opcode, RdfromPipe3, RdfromPipe2)
		begin 
			if ( RegRs = RdfromPipe2 or RegRt = RdfromPipe2 ) and Opcode = "100000"  then 
				if(RegRs = RdfromPipe2) then 
					Rfa_sel <= "01";
				else
					Rfa_sel <= "00";
				end if;
				if(RegRt = RdfromPipe2) then 
					Rfb_sel <= "01";
				else
					Rfb_sel <= "00";
				end if; -- the reason we have two if statements is that we need to make sure we have the case when both the ifs are true 	
			elsif(RegRs = RdfromPipe3 or RegRt = RdfromPipe3) and Opcode = "001111" then
				if(RegRs = RdfromPipe3) then -- check the case rd/rt with the same procedure
					Rfa_sel <= "10";
				else
					Rfa_sel <= "00";
				end if;
				if(RegRt = RdfromPipe3) then 
					Rfb_sel <= "10";
				else
					Rfb_sel <= "00";
				end if;
			else
				Rfa_sel <= "00";
				Rfb_sel <= "00";
			end if;
	end process;
end Behavioral;

