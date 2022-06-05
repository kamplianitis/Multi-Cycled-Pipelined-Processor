----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:45:03 05/20/2020 
-- Design Name: 
-- Module Name:    PipelineIFID - Behavioral 
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

entity PipelineIFID is
	port 
		(
			Clk : in std_logic;
			Rst : in std_logic;
			MemoryInstruction : in std_logic_vector(31 downto 0);
			IFIDWrite : in std_logic;
			InstructionOutput : out std_logic_vector(31 downto 0)
		);
end PipelineIFID;

architecture Behavioral of PipelineIFID is


-- we need the register that will pass the new info
COMPONENT Reg
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

begin

Inst_Reg: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => IFIDWrite,
		Datain => MemoryInstruction,
		Dataout => InstructionOutput
	);
	
end Behavioral;

