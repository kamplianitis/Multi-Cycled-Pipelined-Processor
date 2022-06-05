----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:16:44 05/23/2020 
-- Design Name: 
-- Module Name:    PipeLinedProject - Behavioral 
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

entity PipeLinedProject is
port 
	(
		Clk : in std_logic;
		Rst : in std_logic
	);
end PipeLinedProject;

architecture Structural of PipeLinedProject is

COMPONENT Datapath_Pipeline
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		MemoryInstruction : IN std_logic_vector(31 downto 0);
		mm_rdData : IN std_logic_vector(31 downto 0);          
		pcinsttomem : OUT std_logic_vector(31 downto 0);
		mem_writeEn : OUT std_logic;
		datatomem : OUT std_logic_vector(31 downto 0);
		ByteOp : OUT std_logic;
		ALU_MEM_Addr : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT RAM
	PORT(
		clk : IN std_logic;
		inst_addr : IN std_logic_vector(10 downto 0);
		data_we : IN std_logic;
		data_addr : IN std_logic_vector(10 downto 0);
		data_din : IN std_logic_vector(31 downto 0);          
		inst_dout : OUT std_logic_vector(31 downto 0);
		data_dout : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;


-- temp signals 
signal meminst : std_logic_vector(31 downto 0);
signal mmrdData : std_logic_vector(31 downto 0);
signal pc_insttomem : std_logic_vector(31 downto 0);
signal memwriteEn : std_logic;
signal datatomemory : std_logic_vector(31 downto 0);
signal Byte_Op : std_logic;
signal ALUMEMAddr : std_logic_vector(31 downto 0);


begin

Inst_Datapath_Pipeline: Datapath_Pipeline PORT MAP(
		Clk => Clk,
		Rst => Rst,
		MemoryInstruction => meminst,
		mm_rdData => mmrdData,
		pcinsttomem => pc_insttomem,
		mem_writeEn => memwriteEn,
		datatomem => datatomemory,
		ByteOp => Byte_Op,
		ALU_MEM_Addr => ALUMEMAddr
);

Inst_RAM: RAM PORT MAP(
		clk => Clk,
		inst_addr => pc_insttomem(12 downto 2),
		inst_dout => meminst,
		data_we => memwriteEn,
		data_addr => ALUMEMAddr(12 downto 2),
		data_din => mmrdData,
		data_dout => datatomemory
	);



end Structural;

