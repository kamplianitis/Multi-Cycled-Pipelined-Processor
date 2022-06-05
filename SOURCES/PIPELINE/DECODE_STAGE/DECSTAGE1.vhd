----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:58:35 04/05/2020 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.arraypackage.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE1 is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in std_logic;
			  Awr : in std_logic_vector(4 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
			 );
			  
end DECSTAGE1;

architecture Structural of DECSTAGE1 is

-- initiating the components we're going to use

component Mux5bit2to1
Port ( 
		A : in  STD_LOGIC_VECTOR (4 downto 0);
      B : in  STD_LOGIC_VECTOR (4 downto 0);
      SEL : in  STD_LOGIC;
      X : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component Mux32bit2to1
Port ( 
			A : in  STD_LOGIC_VECTOR (31 downto 0);
         B : in  STD_LOGIC_VECTOR (31 downto 0);
         SEL : in  STD_LOGIC;
         X : out  STD_LOGIC_VECTOR (31 downto 0)
		);
end component;			  

component Littlecloud
Port ( 
		Din : in  STD_LOGIC_VECTOR (15 downto 0);
		Immed : out  STD_LOGIC_VECTOR (31 downto 0);
		OpCode : in  STD_LOGIC_VECTOR (1 downto 0));
end component;

component RF
	port
		(
			Adr1 : in std_logic_vector(4 downto 0);
			Adr2 : in std_logic_vector(4 downto 0);
			Awr : in std_logic_vector(4 downto 0);
			Dout1: out std_logic_vector(31 downto 0);
			Dout2: out std_logic_vector(31 downto 0);
			Din : in std_logic_vector(31 downto 0);
			WrEn : in std_logic;
			Clk : in std_logic;
			Rst : in std_logic
		);
end component;

-- the signals that we will use
signal MUX1out : STD_LOGIC_VECTOR (4 downto 0);
signal MUX2out : STD_LOGIC_VECTOR (31 downto 0);
  
begin

MUX1 : Mux5bit2to1
port map(
			A => Instr(15 downto 11),
			B => Instr(20 downto 16),
			SEL => RF_B_sel,
			X => MUX1out -- signal
			);
			
MUX2: Mux32bit2to1
port map (			
			 A => ALU_out,
			 B => MEM_out,
			 SEL => RF_WrData_sel,
			 X => MUX2out --signal
			 );
			 
Immed16to32:Littlecloud 
port map (
			 Din => Instr(15 downto 0),
			 Immed => Immed,
			 OpCode => ImmExt
			 );
			 
RFile:RF
port map
		(
			Adr1 => Instr(25 downto 21), 
			Adr2 => MUX1out, -- signal
			Awr => Awr,
			Dout1 => RF_A,
			Dout2 => RF_B,
			Din => MUX2out, -- signal
			WrEn => RF_WrEn,
			Clk => Clk,
			Rst => Rst
		);



end Structural;

