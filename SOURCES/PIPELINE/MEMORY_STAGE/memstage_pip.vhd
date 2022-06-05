----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:21:14 05/20/2020 
-- Design Name: 
-- Module Name:    memstage_pip - Behavioral 
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

entity memstage_pip is
PORT(
		ByteOp : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);
		MM_RdData : IN std_logic_vector(31 downto 0);          
		MM_Addr : OUT std_logic_vector(31 downto 0);
		MM_WrData : OUT std_logic_vector(31 downto 0);
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
	);
end memstage_pip;

architecture Behavioral of memstage_pip is

COMPONENT mem_stage
	PORT(
		ByteOp : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);
		MM_RdData : IN std_logic_vector(31 downto 0);          
		MM_Addr : OUT std_logic_vector(31 downto 0);
		MM_WrData : OUT std_logic_vector(31 downto 0);
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

begin

Inst_mem_stage: mem_stage PORT MAP(
		ByteOp => ByteOp,
		ALU_MEM_Addr => ALU_MEM_Addr,
		MEM_DataIn => MEM_DataIn,
		MM_RdData => MM_RdData,
		MM_Addr => MM_Addr,
		MM_WrData => MM_WrData,
		MEM_DataOut => MEM_DataOut
);
end Behavioral;