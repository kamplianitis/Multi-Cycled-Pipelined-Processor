----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:30 05/20/2020 
-- Design Name: 
-- Module Name:    PipelineMemWB - Behavioral 
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

entity PipelineMemWB is
port 
	(
		Clk : in std_logic;
		Rst : in std_logic;
		Instructions : in std_logic_vector(31 downto 0);
		Instructionsfinal : out std_logic_vector(31 downto 0);	
		DatafromMemIn : in std_logic_vector(31 downto 0);
		DatafromMemOut : out std_logic_vector(31 downto 0);
		rf_write_data_selIn : in std_logic;
		rf_wr_en_in : in std_logic;
		rf_wr_en_out: out std_logic;
		rf_write_data_selOut : out std_logic;
		AluresultIn : in std_logic_vector(31 downto 0);
		AluresultOut : out std_logic_vector(31 downto 0)
	);
end PipelineMemWB;

architecture Behavioral of PipelineMemWB is

COMPONENT RegOne
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic;          
		Dataout : OUT std_logic
		);
END COMPONENT;

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
Inst_Regmem: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => DatafromMemIn,
		Dataout => DatafromMemOut
	);

Inst_Regalu : Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => AluresultIn,
		Dataout => AluresultOut
	);

Inst_RegOne : RegOne PORT MAP(
	Clk => Clk, 
	Rst => Rst,
	WE => '1',
	Datain => rf_write_data_selIn,
	Dataout => rf_write_data_selOut
	);

Inst_RegOnerfWE: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rf_wr_en_in,
		Dataout => rf_wr_en_out
	);

Inst_RegIns: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => Instructions,
		Dataout => Instructionsfinal
	);
end Behavioral;

