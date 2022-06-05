----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:45 05/20/2020 
-- Design Name: 
-- Module Name:    HazardDetectionUnit - Behavioral 
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

entity HazardDetectionUnit is
port
	(
		Clk : in STD_LOGIC;
		Reset: in  STD_LOGIC;
		Regrs : in std_logic_vector(4 downto 0);
		Regrt : in std_logic_vector(4 downto 0);
		RDfrompipe : in std_logic_vector(4 downto 0);
		OPcode_after_the_pipeline : in std_logic_vector(5 downto 0); -- we need this in order to see when we have to load
		Pc_ldEn : out std_logic;
		IFIDwrite : out std_logic;
		controlsignals_sel : out std_logic
	);
end HazardDetectionUnit;

architecture Behavioral of HazardDetectionUnit is

type state is( Starting_state, Hazard_state);
signal current_state : state;
signal next_state : state;

begin

	process(current_state, OPcode_after_the_pipeline, Regrs, Regrt)
		begin 
			case current_state is 
				when Starting_state =>
					if ( OPcode_after_the_pipeline = "001111" and (RDfrompipe = Regrs or RDfrompipe = Regrt)) then 
						Pc_ldEn <= '0';
						IFIDwrite <= '1';
						controlsignals_sel <= '1';
						next_state <= Hazard_state;
					else
						Pc_ldEn <= '1';
						IFIDwrite <= '1';
						controlsignals_sel <= '1';
						next_state <= Starting_state;
					end if;
				when Hazard_state =>
					Pc_ldEn <= '0';
					IFIDwrite <= '0';
					controlsignals_sel <= '0';
					next_state <= Starting_state;
				end case;
			end process;

process (clk)
	begin
		if (Reset ='1') then
			current_state <= Starting_state;
		elsif (Clk' Event and Clk = '1') then
		  current_state <= next_state;
		end if;
	end process;
end Behavioral;

