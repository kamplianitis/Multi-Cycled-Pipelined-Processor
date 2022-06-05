--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:07:29 05/26/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/forwarding_test.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ForwardingUnit
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
 
ENTITY forwarding_test IS
END forwarding_test;
 
ARCHITECTURE behavior OF forwarding_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ForwardingUnit
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         RegRs : IN  std_logic_vector(4 downto 0);
         RegRt : IN  std_logic_vector(4 downto 0);
         RdfromPipe2 : IN  std_logic_vector(4 downto 0);
         RdfromPipe3 : IN  std_logic_vector(4 downto 0);
         Opcode : IN  std_logic_vector(5 downto 0);
         Rfa_sel : OUT  std_logic_vector(1 downto 0);
         Rfb_sel : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal RegRs : std_logic_vector(4 downto 0) := (others => '0');
   signal RegRt : std_logic_vector(4 downto 0) := (others => '0');
   signal RdfromPipe2 : std_logic_vector(4 downto 0) := (others => '0');
   signal RdfromPipe3 : std_logic_vector(4 downto 0) := (others => '0');
   signal Opcode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Rfa_sel : std_logic_vector(1 downto 0);
   signal Rfb_sel : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ForwardingUnit PORT MAP (
          Clk => Clk,
          Rst => Rst,
          RegRs => RegRs,
          RegRt => RegRt,
          RdfromPipe2 => RdfromPipe2,
          RdfromPipe3 => RdfromPipe3,
          Opcode => Opcode,
          Rfa_sel => Rfa_sel,
          Rfb_sel => Rfb_sel
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
      RegRs <= "00001";
      RegRt <= "00001";
      RdfromPipe2 <= "00111";
      RdfromPipe3 <= "00001";
      Opcode <= "100000";
      wait for Clk_period*2;
		
      Rst <= '0';
      RegRs <= "00001";
      RegRt <= "00001";
      RdfromPipe2 <= "00111";
      RdfromPipe3 <= "00001";
      Opcode <= "100000";
      wait for Clk_period;
		
		Rst <= '0';
      RegRs <= "00111";
      RegRt <= "00111";
      RdfromPipe2 <= "00111";
      RdfromPipe3 <= "00001";
      Opcode <= "100000";
      wait for Clk_period;
		
		Rst <= '0';
      RegRs <= "00001";
      RegRt <= "00001";
      RdfromPipe2 <= "00111";
      RdfromPipe3 <= "00001";
      Opcode <= "000000";
      wait for Clk_period;
		

      wait;
   end process;

END;
