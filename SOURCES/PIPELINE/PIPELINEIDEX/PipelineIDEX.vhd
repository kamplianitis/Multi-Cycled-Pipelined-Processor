----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:05:40 05/20/2020 
-- Design Name: 
-- Module Name:    PipelineIDEX - Behavioral 
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

entity PipelineIDEX is
port 
	(
		Clk : in std_logic;
		Rst : in std_logic;
		InstuctionIn : in std_logic_vector(31 downto 0);
		InstuctionOut : out std_logic_vector(31 downto 0);
		ALUBINSelIn : in std_logic;
		ALUBINSelOut : out std_logic;
		MEMWrEnIn : in std_logic;
		MEMWrEnOut : out std_logic;
		rf_write_data_selIn : in std_logic;
		rf_wr_en_in : in std_logic;
		alu_func_in : in std_logic_vector(3 downto 0);
		Opcode : in std_logic_vector(5 downto 0);
		OpcodeOut : out std_logic_vector(5 downto 0);	
		alu_func_out : out std_logic_vector(3 downto 0);
		rf_wr_en_out: out std_logic;
		rf_write_data_selOut : out std_logic;	
		rfain : in std_logic_vector(31 downto 0);
		rfaout : out std_logic_vector(31 downto 0);
		rfbin : in std_logic_vector (31 downto 0);
		rfbout : out std_logic_vector (31 downto 0);
		ImmediateIn : in std_logic_vector(31 downto 0);
		ImmediateOut : out std_logic_vector(31 downto 0)
	);
end PipelineIDEX;

architecture Behavioral of PipelineIDEX is

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

COMPONENT Reg3down0
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(3 downto 0);          
		Dataout : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;


COMPONENT Reg5downto0
PORT(
	Clk : IN std_logic;
	Rst : IN std_logic;
	WE : IN std_logic;
	Datain : IN std_logic_vector(5 downto 0);          
	Dataout : OUT std_logic_vector(5 downto 0)
	);
END COMPONENT;


begin

Inst_RegInstr: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => InstuctionIn,
		Dataout => InstuctionOut
	);


Inst_Regrfa: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rfain,
		Dataout => rfaout
	);


Inst_Regrfb: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rfbin,
		Dataout => rfbout
	);

Inst_RegOneAlu: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => ALUBINSelIn,
		Dataout => ALUBINSelOut
	);

Inst_RegOneRFWE: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rf_wr_en_in,
		Dataout => rf_wr_en_out
	);

Inst_RegOnememwren: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => MEMWrEnIn,
		Dataout => MEMWrEnOut
	);

Inst_RegOnerfwritedata: RegOne PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => rf_write_data_selIn,
		Dataout => rf_write_data_selOut
	);
	
Inst_RegImmed: Reg PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => ImmediateIn,
		Dataout => ImmediateOut
	);

Inst_Reg3down0: Reg3down0 PORT MAP(
		Clk =>  Clk,
		Rst => Rst,
		WE => '1',
		Datain => alu_func_in,
		Dataout => alu_func_out
);

Inst_Reg5downto0: Reg5downto0 PORT MAP(
		Clk => Clk,
		Rst => Rst,
		WE => '1',
		Datain => Opcode,
		Dataout => OpcodeOut
	);


end Behavioral;

