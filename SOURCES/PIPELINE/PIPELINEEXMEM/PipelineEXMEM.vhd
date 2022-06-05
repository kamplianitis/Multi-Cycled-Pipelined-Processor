----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:34 05/20/2020 
-- Design Name: 
-- Module Name:    PipelineMEMEX - Behavioral 
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

entity PipelineEXMEM is
port 
	(
		Clk : in std_logic;
		Rst : in std_logic;
		Aluresultin : in std_logic_vector(31 downto 0);
		AluresultOut : out std_logic_vector(31 downto 0);
		RegtoMemoryIn : in std_logic_vector(31 downto 0);
		RegtoMemoryOut : out std_logic_vector(31 downto 0);
		RDorRtIn : in std_logic_vector(4 downto 0);
		rf_wr_en_in : in std_logic;
		rf_wr_en_out: out std_logic;
		RDorRtOut : out std_logic_vector(4 downto 0);
		rf_write_data_selIn : in std_logic;
		rf_write_data_selOut : out std_logic;
		MEMWrEnIn : in std_logic;
		MEMWrEnOut : out std_logic;
		InstuctionIn : in std_logic_vector(31 downto 0);
		InstuctionOut : out std_logic_vector(31 downto 0)
	);
end PipelineEXMEM;

architecture Behavioral of PipelineEXMEM is

COMPONENT Reg
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT RegOne
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic;          
		Dataout : OUT std_logic
		);
END COMPONENT;

COMPONENT Reg4Bit
PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(4 downto 0);          
		Dataout : OUT std_logic_vector(4 downto 0)
		);
END COMPONENT;

begin

Inst_RegOne: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rf_write_data_selIn,
		Dataout => rf_write_data_selOut
	);

Inst_RegOnemem: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => MEMWrEnIn,
		Dataout => MEMWrEnOut
	);

Inst_RegOnerfWE: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rf_wr_en_in,
		Dataout => rf_wr_en_out
	);
Inst_RegALuresult: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => Aluresultin,
		Dataout => AluresultOut
	);

Inst_RegRegtoMemory: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => RegtoMemoryIn,
		Dataout => RegtoMemoryOut
	);
Inst_RegInstr: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => InstuctionIn,
		Dataout => InstuctionOut
	);

Inst_Reg4Bit: Reg4Bit PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => RDorRtIn,
		Dataout => RDorRtOut
	);
end Behavioral;

