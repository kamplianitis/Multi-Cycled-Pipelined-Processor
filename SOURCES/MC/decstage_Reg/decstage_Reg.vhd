----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:43 05/16/2020 
-- Design Name: 
-- Module Name:    decstage_Reg - Behavioral 
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

entity decstage_Reg is
   Port (  
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in std_logic;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
			);
end decstage_Reg;

architecture Structural of decstage_Reg is

component DECSTAGE
   Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in std_logic;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
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

--temp signals that we will need
signal temprfa : std_logic_vector(31 downto 0);
signal temprfb : std_logic_vector(31 downto 0);
signal tempimmed : std_logic_vector(31 downto 0);

begin

decc : DECSTAGE
	port map(
				Instr => Instr,
				RF_WrEn => RF_WrEn,
				ALU_out => ALU_out,
				MEM_out => MEM_out,
				RF_WrData_sel => RF_WrData_sel,
				RF_B_sel => RF_B_sel,
				ImmExt => ImmExt,
				Clk => Clk,
				Rst => Rst,
				Immed => tempimmed,
				RF_A => temprfa,
				RF_B => temprfb
				);

regrfa : Reg
	port map 
			(
				Clk => Clk,
				Rst => Rst,
				WE => '1',
				Datain => temprfa,
				Dataout => RF_A
				);

regrfb : Reg
	port map 
			(
				Clk => Clk,
				Rst => Rst,
				WE => '1',
				Datain => temprfb,
				Dataout => RF_B
				);

regImmed : Reg
	port map 
			(
				Clk => Clk,
				Rst => Rst,
				WE => '1',
				Datain => tempimmed,
				Dataout => Immed
			);
end Structural;

