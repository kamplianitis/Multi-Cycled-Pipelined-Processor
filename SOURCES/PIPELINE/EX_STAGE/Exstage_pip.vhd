----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:01 05/20/2020 
-- Design Name: 
-- Module Name:    exstage_pip - Behavioral 
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

entity exstage_pip is
port
		(
			pcinput : in std_logic_vector(31 downto 0);
			RF_A : in std_logic_vector(31 downto 0);
			RF_B : in std_logic_vector(31 downto 0);
			Immed : in std_logic_vector(31 downto 0);
			DataOutInp : in std_logic_vector(31 downto 0);
			rfa_sel : in std_logic_vector(1 downto 0);
			rfb_sel : in std_logic_vector(1 downto 0);
			ALU_Bin_sel : in std_logic;
			ALU_func : in std_logic_vector(3 downto 0);
			ALU_out : out std_logic_vector(31 downto 0);
			ALU_outafterpipeline : in std_logic_vector(31 downto 0);	
			pcoutput : out std_logic_vector(4 downto 0);
			ALU_zero : out std_logic
		);
			
end exstage_pip;



architecture Behavioral of exstage_pip is

COMPONENT EXSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic
		);
END COMPONENT;

COMPONENT Mux3Inputs
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		C : IN std_logic_vector(31 downto 0);
		sel : IN std_logic_vector(1 downto 0);          
		X : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

-- temp signals
signal temprfa : std_logic_vector(31 downto 0);
signal temprfb : std_logic_vector(31 downto 0);
signal pc_out : std_logic_vector(4 downto 0);

begin
Inst_Mux3Inputs: Mux3Inputs PORT MAP(
		A => RF_A,
		B => DataOutInp,
		C => ALU_outafterpipeline,
		sel => rfa_sel,
		X => temprfa
	);

Inst_Mux3Inputs2: Mux3Inputs PORT MAP(
		A => RF_B,
		B => DataOutInp,
		C => ALU_outafterpipeline,
		sel => rfb_sel,
		X => temprfb
	);
	
EXSTAGE1: EXSTAGE PORT MAP(
		RF_A => temprfa,
		RF_B => temprfb,
		Immed => Immed,
		ALU_Bin_sel => ALU_Bin_sel,
		ALU_func => ALU_func,
		ALU_out => ALU_out,
		ALU_zero => ALU_zero
);
pc_out <= pcinput(20 downto 16);
pcoutput <= pc_out;

end Behavioral;

