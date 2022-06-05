----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:26:06 05/18/2020 
-- Design Name: 
-- Module Name:    Control_Mult - Behavioral 
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

entity Control_Mult is
	port 
		(
			-- the inputs i need
			Rst : in std_logic;
			Clk : in std_logic;
			Instr : in std_logic_vector(31 downto 0);
			ALU_zero : in std_logic;
			-- now the outputs
			PC_LdEn : out std_logic;
			RF_WrEn : out std_logic;
			RF_WrData_sel : out std_logic;
			RF_B_sel : out std_logic;
			ImmExt : out std_logic_vector(1 downto 0);
			ALU_Bin_sel : out std_logic;
			ALU_func: out std_logic_vector(3 downto 0);
			rfa_sel : out std_logic;
			fourorImmed_sel : out std_logic;
			ByteOp : out std_logic;
			Mem_WrEn : out std_logic;
			pc_selection : out std_logic
		);		
end Control_Mult;

architecture Behavioral of Control_Mult is

type state is (reset_state,inst_fecth, check_instr_state,Alu_state,li_state,lui_state,addi_state,nandi_state,ori_state,b_state,beq_state,bne_state,lb_state,sb_state, lw_state, sw_state, pnext_state, pcnext_state, pcnextjump_state);
signal current_state: state;
signal next_state: state;

begin

	process(current_state,Instr,ALU_zero)
		begin
			case current_state is 
				when reset_state => -- everything must stop working
					PC_LdEn <= '0';
					RF_WrEn <= '0';
					RF_WrData_sel <= '0';
					RF_B_sel <= '0';
					ImmExt <= "00";
					ALU_Bin_sel <= '0';
					ALU_func <= "0000";
					rfa_sel <= '0';
					fourorImmed_sel <= '0';
					ByteOp <= '0';
					Mem_WrEn <= '0';
					pc_selection <= '0';
					next_state <= inst_fecth;
				when inst_fecth => -- this will be used to create the appropriate delay
					PC_LdEn <= '0'; -- we start the PC
					next_state <= check_instr_state;
				when check_instr_state => 
					PC_LdEn <= '0'; -- we stop the PC
					if(Instr(31 downto 26) = "100000") then -- that means that we have to check the fucntion bacause we are in AlU
						ImmExt <="00"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- 
						RF_B_sel <= '0'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='0'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '0'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= Alu_state;
					elsif Instr(31 downto 26) = "111000" then -- li
						next_state <= li_state;
					elsif Instr(31 downto 26) = "111001" then -- lui
						next_state <= lui_state;
					elsif Instr(31 downto 26) = "110000" then -- addi	
						next_state <= addi_state;
					elsif Instr(31 downto 26) = "110010" then -- nandi 
						next_state<= nandi_state;
					elsif Instr(31 downto 26) = "110011" then -- ori 	
						next_state<= ori_state;
					elsif Instr(31 downto 26) = "111111" then -- b 	
						next_state<= b_state;
					elsif Instr(31 downto 26) = "000000" then -- beq
						next_state<= beq_state;
					elsif Instr(31 downto 26) = "000001" then -- bne
						next_state <= bne_state;
					elsif Instr(31 downto 26) = "000011" then -- lb
						next_state <= lb_state;
					elsif Instr(31 downto 26) = "000111" then -- sb
						next_state <= sb_state;
					elsif Instr(31 downto 26) = "001111" then -- lw
						next_state <= lw_state;
					elsif Instr(31 downto 26) = "011111" then -- sw
						next_state<= sw_state;
					else 
						next_state <= check_instr_state;
					end if;
				when Alu_state =>
					PC_LdEn <= '0'; -- we stop the PC
					ALU_func<= Instr(3 downto 0);
					next_state <= pnext_state;
				when li_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="10"; -- we sign extend 
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- Immediate taker
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- Immediate taker 
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "1111"; -- 1111 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				
				when lui_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="01"; -- zero fill the immediate
						RF_WrEn <='0'; -- we dont have to write in the registers
						RF_B_sel <= '1'; -- rd register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- Immediate taker
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "1111"; -- 1111 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when addi_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="10"; -- sign extend
						RF_WrEn <='0'; -- we don't have to write in the registers
						RF_B_sel <= '1'; -- rd register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0000"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when nandi_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="00"; -- zero fill
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rd register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- Immediate taker
						rfa_sel <= '1'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0101"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when ori_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="00"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0011"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when b_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="11"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '0'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0000"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pcnextjump_state;
				when beq_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="11"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '0'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0001"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						if ALU_zero = '0' then
								next_state <= pcnext_state;
						else 
							 next_state <= pcnextjump_state;
						end if;
				when bne_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="11"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we dont write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='0'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '0'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0001"; 
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						if ALU_zero = '0' then
								next_state <= pcnextjump_state;
						else 
							 next_state <= pcnext_state;
						end if;
				when lb_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="10"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '1'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='1';  -- we dont care about it
						ALU_func <= "0000"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when sb_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="10"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='1';  -- we dont care about it
						ALU_func <= "0000"; -- 0000 for Rf B
						Mem_WrEn <= '1'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when lw_state =>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="10"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '1'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; -- we don't care about that cause we take the rf_b
						ByteOp <='0';  -- we dont care about it
						ALU_func <= "0000"; -- 0000 for Rf B
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						next_state <= pnext_state;
				when sw_state=>
						PC_LdEn <= '0'; -- we stop the PC
						ImmExt <="10"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='0'; -- we have to write in the registers
						RF_B_sel <= '1'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='1'; 
						rfa_sel <= '0'; -- we want to take the rf_a
						fourorImmed_sel <= '1'; 
						ByteOp <='1';  
						ALU_func <= "0000"; 
						Mem_WrEn <= '1'; 
						next_state <= pnext_state;
				when pnext_state =>
						PC_LdEn <= '1'; -- we start the PC
						rfa_sel <= '1'; -- we want to take the rf_a
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						fourorImmed_sel <= '0'; -- we don't care about that cause we take the rf_b
						RF_WrEn <='1'; -- we have to write in the registers
						pc_selection <= '0';
						ALU_func <= "0000"; 
						next_state <= inst_fecth;
				when pcnext_state =>
						PC_LdEn <= '1'; -- we start the PC
						pc_selection <= '0';
						rfa_sel <= '1'; -- we want to take the rf_a
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						fourorImmed_sel <= '0'; -- we don't care about that cause we take the rf_b
						RF_WrEn <='0'; -- we have to write in the register		
						ALU_func <= "0000"; 
						next_state <= inst_fecth;
				when pcnextjump_state =>
						PC_LdEn <= '1'; -- we start the PC
						rfa_sel <= '1'; -- we want to take the rf_a
						ALU_Bin_sel <='1'; -- we need always the RF_B when we are in ALU
						fourorImmed_sel <= '0'; -- we don't care about that cause we take the rf_b
						pc_selection <= '1';
						RF_WrEn <='0'; -- we have to write in the registers
						ALU_func <= "0000"; 
						next_state <= inst_fecth;
				end case;
			end process;
			

	process(Clk,Rst,current_state)
		begin	
				if(Rst ='1') then 
					current_state <= reset_state;
				elsif(Clk' Event and Clk = '1') then 
					current_state <= next_state;
				else 
					current_state <= current_state;
				end if;
	end process;
end Behavioral;

