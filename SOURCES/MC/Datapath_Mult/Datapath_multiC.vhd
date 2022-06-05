----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:03:05 05/17/2020 
-- Design Name: 
-- Module Name:    Datapath_multiC - Behavioral 
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

entity Datapath_multiC is
	port 
		(
			Clk : in std_logic;
			Rst : in std_logic;
			PC_LdEn : in std_logic;
			Instr : in std_logic_vector(31 downto 0);
			RF_WrEn : in std_logic;
			RF_WrData_sel : in std_logic;
			RF_B_sel : in std_logic;
			ImmExt : in std_logic_vector(1 downto 0);
			ALU_Bin_sel : in std_logic;
			ALU_func: in std_logic_vector(3 downto 0);
			rfa_sel : in std_logic;
			fourorImmed_sel : in std_logic;
			pcselection : in std_logic;
			ByteOp : in std_logic;
			-- outputs
			MM_RdData: in std_logic_vector (31 downto 0);
			Pc_Instr : out std_logic_vector(31 downto 0);
			MM_Addr : out std_logic_vector(31 downto 0);
			ALU_zero: out std_logic;
			MM_WrData: out std_logic_vector(31 downto 0)
		);
			
end Datapath_multiC;

architecture Structural of Datapath_multiC is

-- the components that the datapath will use

COMPONENT PCIf_stage
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;


COMPONENT decstage_Reg
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
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT exstage_Reg
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		RF_A : IN std_logic_vector(31 downto 0);
		Pc_in : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		pcalusel : IN std_logic;
		pc_selection : IN std_logic;
		immedfour_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out_reg : OUT std_logic_vector(31 downto 0);
		Pc_fourOrImmed : OUT std_logic_vector(31 downto 0);
		ALU_zero_reg : OUT std_logic
		);
END COMPONENT;


COMPONENT memstage_Reg
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		ByteOp : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);
		MM_RdData : IN std_logic_vector(31 downto 0);          
		MM_Addr : OUT std_logic_vector(31 downto 0);
		MM_WrData : OUT std_logic_vector(31 downto 0);
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
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

-- temp signals that we use
signal pcInstAddress : std_logic_vector(31 downto 0);
signal TextInstrOut : std_logic_vector(31 downto 0);
signal rf_a_reg : std_logic_vector(31 downto 0);
signal rf_b_reg : std_logic_vector(31 downto 0);
signal immediate_reg : std_logic_vector(31 downto 0);
signal tempaluout : std_logic_vector(31 downto 0);
signal pcInput : std_logic_vector(31 downto 0);
signal tempmemout : std_logic_vector(31 downto 0);

begin


Inst_PCIf_stage: PCIf_stage PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => PC_LdEn, -- control signal 
		Datain => pcInput, --- comes from ex stage
		Dataout => pcInstAddress
	);

Pc_Instr <= pcInstAddress; -- gives the signal to the text memory 


Inst_Reg: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => Instr,
		Dataout => TextInstrOut
	);
	
Inst_decstage_Reg: decstage_Reg PORT MAP(
		Instr => TextInstrOut,
		RF_WrEn => RF_WrEn,
		ALU_out => tempaluout, 
		MEM_out => tempmemout , -- comes from the memstage
		RF_WrData_sel => RF_WrData_sel,
		RF_B_sel => RF_B_sel,
		ImmExt => ImmExt,
		Clk => Clk,
		Rst => Rst,
		Immed => immediate_reg,
		RF_A => rf_a_reg,
		RF_B => rf_b_reg
	);

Inst_exstage_Reg: exstage_Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		RF_A => rf_a_reg,
		Pc_in => pcInstAddress,
		RF_B => rf_b_reg,
		Immed => immediate_reg,
		ALU_Bin_sel => ALU_Bin_sel,
		pcalusel => rfa_sel,
		pc_selection => pcselection, -- has to be added in the control 
		immedfour_sel => fourorImmed_sel,
		ALU_func => ALU_func,
		ALU_out_reg => tempaluout,
		Pc_fourOrImmed => pcInput,
		ALU_zero_reg => ALU_zero
	);
	
Inst_memstage_Reg: memstage_Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		ByteOp => ByteOp,
		ALU_MEM_Addr => tempaluout,
		MEM_DataIn => rf_b_reg,
		MM_RdData => MM_RdData,
		MM_Addr => MM_Addr,
		MM_WrData => MM_WrData,
		MEM_DataOut => tempmemout
	);	

end Structural;


