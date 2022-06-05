----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:51:49 05/16/2020 
-- Design Name: 
-- Module Name:    memstage_Reg - Behavioral 
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

entity memstage_Reg is
port ( 
				Clk : in std_logic;
				Rst : in std_logic;
				ByteOp : in  STD_LOGIC;
				ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
				MM_RdData : in std_logic_vector (31 downto 0);
				MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
				MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataOut : out std_logic_vector(31 downto 0)
			 );
end memstage_Reg;

architecture Structural of memstage_Reg is

component mem_stage
port ( 
				ByteOp : in  STD_LOGIC;
				ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
				MM_RdData : in std_logic_vector (31 downto 0);
				MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
				MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataOut : out std_logic_vector(31 downto 0)
		);
end component;



component Reg 
	port
		(
			Clk : in std_logic;
			Rst : in std_logic;
			WE : in std_logic;
			Datain : in std_logic_vector(31 downto 0);
			Dataout: out std_logic_vector(31 downto 0)
		);
end component;

-- temp signals
signal addres : std_logic_vector(31 downto 0);
signal writedata : std_logic_vector(31 downto 0);
signal dataout : std_logic_vector (31 downto 0);


begin

mmstage : mem_stage
	port map
			(
				ByteOp => ByteOp,
				ALU_MEM_Addr => ALU_MEM_Addr,
				MEM_DataIn => MEM_DataIn,
				MM_RdData => MM_RdData,
				MM_Addr => MM_Addr,
				MM_WrData => writedata,
				MEM_DataOut => MEM_DataOut
			);
			

Inst_Reg: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => writedata,
		Dataout => MM_WrData
	);
end Structural;


	
	