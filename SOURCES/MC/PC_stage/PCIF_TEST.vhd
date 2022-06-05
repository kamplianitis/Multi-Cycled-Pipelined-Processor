--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:42:36 05/24/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/PCIF_TEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PCIf_stage
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PCIF_TEST IS
END PCIF_TEST;
 
ARCHITECTURE behavior OF PCIF_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PCIf_stage
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         WE : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PCIf_stage PORT MAP (
          Clk => Clk,
          Rst => Rst,
          WE => WE,
          Datain => Datain,
          Dataout => Dataout
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		Rst <= '1';
		Datain<= "01110000111001011101110000011001";
      wait for Clk_period*2;
		
		Rst <= '0';
		WE  <='0';
		Datain<= "01110000111001011101110000011001";
      wait for Clk_period*2;
		
		Rst <= '0';
		WE  <='1';
		Datain<= "01110000111001011101110000011001";
      wait for Clk_period*2;
		
		
      -- insert stimulus here 

      wait;
   end process;

END;
