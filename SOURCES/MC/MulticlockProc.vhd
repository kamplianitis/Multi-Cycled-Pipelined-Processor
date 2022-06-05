----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:51 05/18/2020 
-- Design Name: 
-- Module Name:    MulticlockProc - Behavioral 
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

entity MulticlockProc is
	port
		(
			Clk: in std_logic;
			Reset: in std_logic;
			inst_addr : out std_logic_vector(31 downto 0);
			inst_dout : in std_logic_vector(31 downto 0);
			data_we : out std_logic;
			data_addr :out std_logic_vector(31 downto 0);
			data_din : out std_logic_vector(31 downto 0);
			data_dout : in std_logic_vector(31 downto 0)
		);
end MulticlockProc;

architecture Structural of MulticlockProc is

-- components
--datapath component
COMPONENT Datapath_multiC
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		PC_LdEn : IN std_logic;
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		ImmExt : IN std_logic_vector(1 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		rfa_sel : IN std_logic;
		fourorImmed_sel : IN std_logic;
		pcselection : in std_logic;
		ByteOp : IN std_logic;
		MM_RdData : IN std_logic_vector(31 downto 0);          
		Pc_Instr : OUT std_logic_vector(31 downto 0);
		MM_Addr : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic;
		MM_WrData : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

-- control component 
COMPONENT Control_Mult
	PORT(
		Rst : IN std_logic;
		Clk : IN std_logic;
		Instr : IN std_logic_vector(31 downto 0);
		ALU_zero : IN std_logic;          
		PC_LdEn : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_WrData_sel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		ImmExt : OUT std_logic_vector(1 downto 0);
		ALU_Bin_sel : OUT std_logic;
		ALU_func : OUT std_logic_vector(3 downto 0);
		rfa_sel : OUT std_logic;
		fourorImmed_sel : OUT std_logic;
		ByteOp : OUT std_logic;
		pc_selection : out std_logic;
		Mem_WrEn : OUT std_logic
		);
END COMPONENT;

--tempsignals
signal temppclden : std_logic;
signal rfwren : std_logic;
signal rfwrdatasel: std_logic;
signal rfbsel: std_logic;
signal immex: std_logic_vector(1 downto 0);
signal alubinsel : std_logic;
signal alufunct : std_logic_vector(3 downto 0);
signal rfasel : std_logic;
signal fourimmed : std_logic;
signal Byteopsel : std_logic;
signal mmwren : std_logic;
signal aluzero : std_logic;
signal MemWrEn : std_logic;
signal pcsel : std_logic;


begin

Inst_Datapath_multiC: Datapath_multiC PORT MAP(
		Clk => Clk,
		Rst => Reset,
		PC_LdEn => temppclden,
		Instr => inst_dout,
		RF_WrEn => rfwren,
		RF_WrData_sel => rfwrdatasel,
		RF_B_sel => rfbsel,
		ImmExt => immex,
		ALU_Bin_sel => alubinsel,
		ALU_func => alufunct,
		rfa_sel => rfasel,
		fourorImmed_sel => fourimmed,
		ByteOp => Byteopsel,
		MM_RdData => data_dout,
		Pc_Instr => inst_addr,
		MM_Addr => data_addr,
		ALU_zero => ALUzero,
		MM_WrData => data_din,
		pcselection => pcsel
);

Inst_Control_Mult: Control_Mult PORT MAP(
		Rst => Reset,
		Clk => Clk,
		Instr => inst_dout,
		ALU_zero => ALUzero,
		PC_LdEn => temppclden,
		RF_WrEn => rfwren,
		RF_WrData_sel => rfwrdatasel,
		RF_B_sel => rfbsel,
		ImmExt => immex,
		ALU_Bin_sel => alubinsel,
		ALU_func => alufunct,
		rfa_sel => rfasel,
		fourorImmed_sel => fourimmed,
		pc_selection => pcsel,
		ByteOp => Byteopsel,
		Mem_WrEn => data_we
);

data_we <=  MemWrEn;

end Structural;

