----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:38 05/21/2020 
-- Design Name: 
-- Module Name:    Control_pip - Behavioral 
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

entity Control_pipeline is
port 
	(
		Instruction : in std_logic_vector(31 downto 0);
		ALU_Bin_Sel : out std_logic;
		signaldefiner : in std_logic;
		MEM_WrEn : out std_logic;
		RF_WrEn : out std_logic;
		RF_WrData_Sel : out std_logic; -- this will be used in the mux after the last pipeline
		RF_B_Sel : out std_logic;
		Alu_func : out std_logic_vector(3 downto 0);
		Immext : out std_logic_vector(1 downto 0);
		Opcode : out std_logic_vector(5 downto 0)
	);
		
end Control_pipeline;

architecture Behavioral of Control_pipeline is

-- temp signals that we will use
signal tempalubinsel : std_logic;
signal tempmemwren : std_logic;
signal rfwren : std_logic;
signal rfwrdatasel : std_logic;
signal rfbsel : std_logic;
signal tempopcode : std_logic_vector(5 downto 0);
begin

	process(Instruction,signaldefiner)
		begin
		if( signaldefiner = '1') then
			if(Instruction(31 downto 26) = "111000") then -- we need the signals for the li function
				tempalubinsel <= '1';
				tempmemwren <= '0';
				rfwren <= '1';
				rfwrdatasel <= '0';
				rfbsel <= '0';
				Immext <= "10";
				Alu_func <= "1111";
				tempopcode <= "111000";
			elsif(Instruction(31 downto 26) = "001111") then -- lw 
				tempalubinsel <= '1';
				tempmemwren <= '0';
				rfwren <= '1';
				rfwrdatasel <= '1';
				rfbsel <= '0';
				Immext <= "00";
				tempopcode <= "001111";
			elsif(Instruction(31 downto 26) = "011111") then -- sw 
				tempalubinsel <= '1';
				tempmemwren <= '1';
				rfwren <= '0';
				rfwrdatasel <= '0';
				rfbsel <= '1';
				Immext <= "00";
				Alu_func <= "0000";
				tempopcode <= "011111";
			elsif(Instruction(31 downto 26) = "100000") then -- add 
				tempalubinsel <= '0';
				tempmemwren <= '0';
				rfwren <= '1';
				rfwrdatasel <= '0';
				rfbsel <= '0';
				Immext <= "00";
				Alu_func <= "0000";
				tempopcode <= "100000";
			else 
				tempalubinsel <= '0';
				tempmemwren <= '0';
				rfwren <= '0';
				rfwrdatasel <= '0';
				rfbsel <= '0';
				Immext <= "00";
				Alu_func <= "0000";
				tempopcode <= "000000";
			end if;
		else 
			tempalubinsel <= '0';
			tempmemwren <= '0';
			rfwren <= '0';
			rfwrdatasel <= '0';
			rfbsel <= '0';
			Immext <= "00";
			Alu_func <= "0000";
			tempopcode <= "000000";
		end if;
	end process;

ALU_Bin_Sel <= tempalubinsel;
MEM_WrEn <= tempmemwren;
RF_WrEn <= rfwren;
RF_WrData_Sel <= rfwrdatasel;
RF_B_Sel <= rfbsel;
Opcode <= tempopcode;
end Behavioral;

