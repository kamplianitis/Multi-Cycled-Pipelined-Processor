--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:53:03 05/26/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/Control_pip_test.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control_pipeline
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
 
ENTITY Control_pip_test IS
END Control_pip_test;
 
ARCHITECTURE behavior OF Control_pip_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control_pipeline
    PORT(
         Instruction : IN  std_logic_vector(31 downto 0);
         ALU_Bin_Sel : OUT  std_logic;
         signaldefiner : IN  std_logic;
         MEM_WrEn : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_Sel : OUT  std_logic;
         RF_B_Sel : OUT  std_logic;
         Alu_func : OUT  std_logic_vector(3 downto 0);
         Immext : OUT  std_logic_vector(1 downto 0);
         Opcode : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal signaldefiner : std_logic := '0';

 	--Outputs
   signal ALU_Bin_Sel : std_logic;
   signal MEM_WrEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_Sel : std_logic;
   signal RF_B_Sel : std_logic;
   signal Alu_func : std_logic_vector(3 downto 0);
   signal Immext : std_logic_vector(1 downto 0);
   signal Opcode : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control_pipeline PORT MAP (
          Instruction => Instruction,
          ALU_Bin_Sel => ALU_Bin_Sel,
          signaldefiner => signaldefiner,
          MEM_WrEn => MEM_WrEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_Sel => RF_WrData_Sel,
          RF_B_Sel => RF_B_Sel,
          Alu_func => Alu_func,
          Immext => Immext,
          Opcode => Opcode
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Instruction <= "11100000000000010000000000000010";
		signaldefiner <= '1';
		wait for 100 ns;	
		
		
      Instruction <= "10000000000000010000000000000010";
		signaldefiner <= '0';
		wait for 100 ns;	
		
		
      Instruction <= "00111100000000010000000000000010";
		signaldefiner <= '1';
		wait for 100 ns;	
		
		
      Instruction <= "01111100000000010000000000000010";
		signaldefiner <= '0';
		wait for 100 ns;	
		
			
	-- insert stimulus here 

      wait;
   end process;

END;
