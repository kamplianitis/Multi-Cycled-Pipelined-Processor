----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:38 05/19/2020 
-- Design Name: 
-- Module Name:    decstage_pip - Behavioral 
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

entity decstage_pipeline is
	port
		(
			Clk : in std_logic;
			Rst: in std_logic;
			Instructionfrommem : in std_logic_vector(31 downto 0);
			RF_B_sel : in  std_logic;
			RF_WrEn : in  std_logic;
			Awr : in std_logic_vector(4 downto 0);
			DataInput : in std_logic_vector(31 downto 0);
			ImExtcloud : in std_logic_vector(1 downto 0);
			Immediate : out std_logic_vector(31 downto 0);
			Rf_a : out std_logic_vector(31 downto 0);
			Rf_b : out std_logic_vector(31 downto 0)	
		);
			
end decstage_pipeline;

architecture Behavioral of decstage_pipeline is

-- components that we will need
COMPONENT DECSTAGE1
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		ImmExt : IN std_logic_vector(1 downto 0);
		Clk : IN std_logic;
		Rst : IN std_logic;
		Awr : IN std_logic_vector(4 downto 0);          
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


begin

Inst_DECSTAGE1: DECSTAGE1 PORT MAP(
		Instr => Instructionfrommem,
		RF_WrEn => RF_WrEn,
		ALU_out => DataInput,
		MEM_out => DataInput,
		RF_WrData_sel => '0',
		RF_B_sel => RF_B_sel,
		ImmExt => ImExtcloud,
		Clk => Clk,
		Awr => Awr,
		Rst => Rst,
		Immed => Immediate,
		RF_A => Rf_a,
		RF_B => Rf_b
);

end Behavioral;

