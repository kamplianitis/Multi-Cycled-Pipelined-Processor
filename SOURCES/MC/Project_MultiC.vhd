----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:01 05/18/2020 
-- Design Name: 
-- Module Name:    Project_MultiC - Behavioral 
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

entity Project_MultiC is
	port(
			Clk : in std_logic;
			Rst : in std_logic
		 );
end Project_MultiC;

architecture Structural of Project_MultiC is

-- the processor 
COMPONENT MulticlockProc
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		inst_dout : IN std_logic_vector(31 downto 0);
		data_dout : IN std_logic_vector(31 downto 0);          
		inst_addr : OUT std_logic_vector(31 downto 0);
		data_we : OUT std_logic;
		data_addr : OUT std_logic_vector(31 downto 0);
		data_din : OUT std_logic_vector(31 downto 0)
	);
END COMPONENT;

-- the ram
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


--temp signals that we will use 
signal instaddr : std_logic_vector(31 downto 0);
signal instdout : std_logic_vector(31 downto 0);
signal datawe : std_logic;
signal dataaddr : std_logic_vector(31 downto 0);
signal datadin : std_logic_vector (31 downto 0);
signal datadout : std_logic_vector(31 downto 0);

begin

Inst_MulticlockProc: MulticlockProc PORT MAP(
		Clk => Clk,
		Reset => Rst,
		inst_addr => instaddr,
		inst_dout => instdout,
		data_we => datawe,
		data_addr => dataaddr,
		data_din => datadin,
		data_dout => datadout
);

Inst_RAM: RAM PORT MAP(
		clk => Clk,
		inst_addr => instaddr(12 downto 2),
		inst_dout => instdout,
		data_we => datawe,
		data_addr => dataaddr(12 downto 2),
		data_din => datadin,
		data_dout => datadout
);

end Structural;

