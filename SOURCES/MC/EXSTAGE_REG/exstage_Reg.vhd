----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:53 05/16/2020 
-- Design Name: 
-- Module Name:    exstage_Reg - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exstage_Reg is
port
		(
			Clk : in std_logic;
			Rst : in std_logic;
			RF_A : in std_logic_vector(31 downto 0);
			Pc_in : in std_logic_vector(31 downto 0);
			RF_B : in std_logic_vector(31 downto 0);
			Immed : in std_logic_vector(31 downto 0);
			ALU_Bin_sel : in std_logic;
			pcalusel : in std_logic;
			pc_selection :  in std_logic;
			immedfour_sel : in std_logic;
			ALU_func : in std_logic_vector(3 downto 0);
			ALU_out_reg : out std_logic_vector(31 downto 0);
			Pc_fourOrImmed : out std_logic_vector(31 downto 0);
			ALU_zero_reg : out std_logic
		);
end exstage_Reg;
architecture Structural of exstage_Reg is

component EXSTAGE
port
		(
			RF_A : in std_logic_vector(31 downto 0);
			RF_B : in std_logic_vector(31 downto 0);
			Immed : in std_logic_vector(31 downto 0);
			ALU_Bin_sel : in std_logic;
			ALU_func : in std_logic_vector(3 downto 0);
			ALU_out : out std_logic_vector(31 downto 0);
			ALU_zero : out std_logic
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

component RegOne
port 
		(
			Clk : in std_logic;
			Rst : in std_logic;
			WE : in std_logic;
			Datain : in std_logic;
			Dataout: out std_logic
		);
end component;


-- need to add another mux here that has the pc or rfa
COMPONENT Mux32bit2to1
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		SEL : IN std_logic;          
		X : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

--temp signals
signal tempaluout : std_logic_vector(31 downto 0);
signal temppcaluout : std_logic_vector(31 downto 0);
signal tempfour : std_logic_vector(31 downto 0);
signal tempimmedf : std_logic_vector(31 downto 0);
signal pc_out_immedor4 : std_logic_vector(31 downto 0);
signal pcplusImmed : std_logic_vector(31 downto 0);

begin
tempfour <= "00000000000000000000000000000100";
pcplusImmed <=tempaluout + Immed;

Inst_Mux32bit2to1: Mux32bit2to1 PORT MAP(
		A => RF_A,
		B => Pc_in,
		SEL => pcalusel,
		X => temppcaluout
	);
	
Inst2_Mux32bit2to1: Mux32bit2to1 PORT MAP(
		A => tempfour,
		B => Immed,
		SEL => immedfour_sel,
		X => tempimmedf
	);
	
exxstage: EXSTAGE
	port map
			(
				RF_A => temppcaluout,
				RF_B => RF_B,
				Immed => tempimmedf,
				ALU_Bin_sel => ALU_Bin_sel,
				ALU_func => ALU_func,
				ALU_out => tempaluout,
				ALU_zero => ALU_zero_reg
			);

Inst_Mux32bit2to1PC: Mux32bit2to1 PORT MAP(
		A => tempaluout,
		B => pcplusImmed,
		SEL => pc_selection,
		X => pc_out_immedor4
);
Pc_fourOrImmed <= pc_out_immedor4;
regout : Reg
	port map 
			(
				Clk => Clk,
				Rst => Rst, 
				WE => '1',
				Datain => tempaluout,
				Dataout => ALU_out_reg
			);



end Structural;

