--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:27:58 05/24/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/EXSTAGE_REG_TEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: exstage_Reg
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
 
ENTITY EXSTAGE_REG_TEST IS
END EXSTAGE_REG_TEST;
 
ARCHITECTURE behavior OF EXSTAGE_REG_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT exstage_Reg
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         RF_A : IN  std_logic_vector(31 downto 0);
         Pc_in : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         pcalusel : IN  std_logic;
         pc_selection : IN  std_logic;
         immedfour_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out_reg : OUT  std_logic_vector(31 downto 0);
         Pc_fourOrImmed : OUT  std_logic_vector(31 downto 0);
         ALU_zero_reg : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal Pc_in : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal pcalusel : std_logic := '0';
   signal pc_selection : std_logic := '0';
   signal immedfour_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out_reg : std_logic_vector(31 downto 0);
   signal Pc_fourOrImmed : std_logic_vector(31 downto 0);
   signal ALU_zero_reg : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: exstage_Reg PORT MAP (
          Clk => Clk,
          Rst => Rst,
          RF_A => RF_A,
          Pc_in => Pc_in,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          pcalusel => pcalusel,
          pc_selection => pc_selection,
          immedfour_sel => immedfour_sel,
          ALU_func => ALU_func,
          ALU_out_reg => ALU_out_reg,
          Pc_fourOrImmed => Pc_fourOrImmed,
          ALU_zero_reg => ALU_zero_reg
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
     -- case we take RF B
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "01000000000011111000000001000010";
		Pc_in <= "00000000000000000000000000000000";
		pcalusel <= '0';
		pc_selection <= '0';
		immedfour_sel <= '0';
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0000"; -- add 
		wait for 100 ns;
		
		
		
		-- case we take immed
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "01000000000000111110000001000010";
		Pc_in <= "00000000000000000000000000000000";
		pcalusel <= '0';
		pc_selection <= '0';
		immedfour_sel <= '0';
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0000"; -- add 
		wait for 100 ns;
      wait;
   end process;

END;
