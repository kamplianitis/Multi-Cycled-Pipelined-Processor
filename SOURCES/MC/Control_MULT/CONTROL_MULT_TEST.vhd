--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:44:13 05/24/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/CONTROL_MULT_TEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control_Mult
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
 
ENTITY CONTROL_MULT_TEST IS
END CONTROL_MULT_TEST;
 
ARCHITECTURE behavior OF CONTROL_MULT_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control_Mult
    PORT(
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_zero : IN  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         rfa_sel : OUT  std_logic;
         fourorImmed_sel : OUT  std_logic;
         ByteOp : OUT  std_logic;
         Mem_WrEn : OUT  std_logic;
         pc_selection : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_zero : std_logic := '0';

 	--Outputs
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal rfa_sel : std_logic;
   signal fourorImmed_sel : std_logic;
   signal ByteOp : std_logic;
   signal Mem_WrEn : std_logic;
   signal pc_selection : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control_Mult PORT MAP (
          Rst => Rst,
          Clk => Clk,
          Instr => Instr,
          ALU_zero => ALU_zero,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          rfa_sel => rfa_sel,
          fourorImmed_sel => fourorImmed_sel,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          pc_selection => pc_selection
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
      wait for Clk_period*2;
		
		--ALU
		Rst <= '0';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110000";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		--ALU
		Rst <= '0';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110001";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
      wait;
   end process;

END;
