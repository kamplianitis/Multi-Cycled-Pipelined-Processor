----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:41:08 05/19/2020 
-- Design Name: 
-- Module Name:    If_stage_pip - Behavioral 
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

entity If_stage_pipeline is
	port 
		(
			Clk : in std_logic;
			Rst : in std_logic;
			pc_ldEn : in std_logic;
			pcinsttomem : out std_logic_vector(31 downto 0)
		);
end If_stage_pipeline;

architecture Behavioral of If_stage_pipeline is


-- the pc register
COMPONENT Reg
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

-- i do not need to use the + immed so i just add +4 all the time

--temp signals that we used
signal temppcin : std_logic_vector(31 downto 0);
signal tempfour : std_logic_vector(31 downto 0);
signal addtionoffourandpcout : std_logic_vector(31 downto 0);
signal temppcout : std_logic_vector(31 downto 0);

begin

-- stabilizing the signal that shows the number 4
tempfour <= "00000000000000000000000000000100";

-- begin the synthesis of the ifstage
PC: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => pc_ldEn,
		Datain => temppcin,
		Dataout => temppcout
);

-- making the addition with the use of the library 
addtionoffourandpcout <= temppcout + tempfour; -- the plus four 

temppcin <= addtionoffourandpcout; -- make the input of the pc the pc.old + 4

-- now i make the temppcout the address that will go to the text memory 

pcinsttomem <= temppcout; 

end Behavioral;

