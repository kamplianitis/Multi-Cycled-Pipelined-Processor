--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:55:52 05/26/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/HDU_test.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HazardDetectionUnit
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
 
ENTITY HDU_test IS
END HDU_test;
 
ARCHITECTURE behavior OF HDU_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HazardDetectionUnit
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Regrs : IN  std_logic_vector(4 downto 0);
         Regrt : IN  std_logic_vector(4 downto 0);
         RDfrompipe : IN  std_logic_vector(4 downto 0);
         OPcode_after_the_pipeline : IN  std_logic_vector(5 downto 0);
         Pc_ldEn : OUT  std_logic;
         IFIDwrite : OUT  std_logic;
         controlsignals_sel : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Regrs : std_logic_vector(4 downto 0) := (others => '0');
   signal Regrt : std_logic_vector(4 downto 0) := (others => '0');
   signal RDfrompipe : std_logic_vector(4 downto 0) := (others => '0');
   signal OPcode_after_the_pipeline : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Pc_ldEn : std_logic;
   signal IFIDwrite : std_logic;
   signal controlsignals_sel : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HazardDetectionUnit PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Regrs => Regrs,
          Regrt => Regrt,
          RDfrompipe => RDfrompipe,
          OPcode_after_the_pipeline => OPcode_after_the_pipeline,
          Pc_ldEn => Pc_ldEn,
          IFIDwrite => IFIDwrite,
          controlsignals_sel => controlsignals_sel
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
       Reset<= '1';
      wait for Clk_period*2;
		 
		 Reset<= '0';
		 Regrs <= "00001";
       Regrt <= "00001"; 
       RDfrompipe <= "00001";
       OPcode_after_the_pipeline <= "001111"; 
		wait for Clk_period*2;
		 Reset<= '0';
		 Regrs <= "00001";
       Regrt <= "00011"; 
       RDfrompipe <= "00001";
       OPcode_after_the_pipeline <= "001111"; 
		wait for Clk_period*2;
		 Reset<= '0';
		 Regrs <= "00101";
       Regrt <= "00011"; 
       RDfrompipe <= "00001";
       OPcode_after_the_pipeline <= "001111"; 
		wait for Clk_period*2;
		
      -- insert stimulus here 

      wait;
   end process;

END;
