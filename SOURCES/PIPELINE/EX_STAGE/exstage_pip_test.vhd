--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:39:07 05/26/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/exstage_pip_test.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: exstage_pip
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
 
ENTITY exstage_pip_test IS
END exstage_pip_test;
 
ARCHITECTURE behavior OF exstage_pip_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT exstage_pip
    PORT(
         pcinput : IN  std_logic_vector(31 downto 0);
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         DataOutInp : IN  std_logic_vector(31 downto 0);
         rfa_sel : IN  std_logic_vector(1 downto 0);
         rfb_sel : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_outafterpipeline : IN  std_logic_vector(31 downto 0);
         pcoutput : OUT  std_logic_vector(4 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal pcinput : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal DataOutInp : std_logic_vector(31 downto 0) := (others => '0');
   signal rfa_sel : std_logic_vector(1 downto 0) := (others => '0');
   signal rfb_sel : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal ALU_outafterpipeline : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal pcoutput : std_logic_vector(4 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: exstage_pip PORT MAP (
          pcinput => pcinput,
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          DataOutInp => DataOutInp,
          rfa_sel => rfa_sel,
          rfb_sel => rfb_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_outafterpipeline => ALU_outafterpipeline,
          pcoutput => pcoutput,
          ALU_zero => ALU_zero
        );

--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
			pcinput <= "11010010010000011111111110010011";
         RF_A <= "11000100001101111001111110011111";
         RF_B <= "01011100001111110010010000101001";
         Immed <= "01011100001111000010010000101001";
         DataOutInp <= "01011100001111110010010000101001";
         rfa_sel <= "00";
         rfb_sel <= "01";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";			
			wait for 100 ns;	

			pcinput <= "11010010010000011111111110010011";
         RF_A <= "11000100001101111001111110011111";
         RF_B <= "01011100001111110010010000101001";
         Immed <= "01011100001111000010010000101001";
         DataOutInp <= "01011100001111110010010000101001";
         rfa_sel <= "00";
         rfb_sel <= "00";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";
			wait for 100 ns;	
	
	
			
			pcinput <= "11010010010000011111111110010011";
         RF_A <= "11000100001101111001111110011111";
         RF_B <= "01011100001111110010010000101001";
         Immed <= "01011100001111000010010000101001";
         DataOutInp <= "01011100001111110010010000101001";
         rfa_sel <= "10";
         rfb_sel <= "01";
         ALU_Bin_sel <= '1';
         ALU_func <= "0000";
			wait for 100 ns;
--      wait for <clock>_period*10;
--
--      -- insert stimulus here 

      wait;
   end process;

END;
