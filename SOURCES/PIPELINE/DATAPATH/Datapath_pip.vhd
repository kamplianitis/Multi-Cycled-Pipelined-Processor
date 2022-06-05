----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:40:04 05/21/2020 
-- Design Name: 
-- Module Name:    Datapath_Pip - Behavioral 
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

entity Datapath_Pipeline is
port( 
		Clk : in std_logic;
		Rst : in std_logic;
		MemoryInstruction : in std_logic_vector(31 downto 0);
		mm_rdData : in std_logic_vector(31 downto 0);
		--outputs
		pcinsttomem : out std_logic_vector(31 downto 0);
		mem_writeEn : out std_logic;
		datatomem : out std_logic_vector(31 downto 0);
		ByteOp : out std_logic;
		ALU_MEM_Addr : out std_logic_vector(31 downto 0)
	 );
end Datapath_Pipeline;



architecture Structural of Datapath_Pipeline is
-- begin the synthesis of the processor 
COMPONENT If_stage_pipeline
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		pc_ldEn : IN std_logic;          
		pcinsttomem : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT PipelineIFID
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		MemoryInstruction : IN std_logic_vector(31 downto 0);
		IFIDWrite : IN std_logic;          
		InstructionOutput : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT HazardDetectionUnit
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		Regrs : IN std_logic_vector(4 downto 0);
		Regrt : IN std_logic_vector(4 downto 0);
		RDfrompipe : IN std_logic_vector(4 downto 0);
		OPcode_after_the_pipeline : IN std_logic_vector(5 downto 0);          
		Pc_ldEn : OUT std_logic;
		IFIDwrite : OUT std_logic;
		controlsignals_sel : OUT std_logic
		);
END COMPONENT;


COMPONENT Control_pipeline
	PORT(
		Instruction : IN std_logic_vector(31 downto 0);
		signaldefiner : IN std_logic;
		Alu_func : OUT std_logic_vector(3 downto 0);          
		ALU_Bin_Sel : OUT std_logic;
		MEM_WrEn : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_WrData_Sel : OUT std_logic;
		RF_B_Sel : OUT std_logic;
		Immext : OUT std_logic_vector(1 downto 0);
		Opcode : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

COMPONENT decstage_pipeline
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Instructionfrommem : IN std_logic_vector(31 downto 0);
		RF_B_sel : IN std_logic;
		RF_WrEn : IN std_logic;
		Awr : IN std_logic_vector(4 downto 0);
		DataInput : IN std_logic_vector(31 downto 0);
		ImExtcloud : IN std_logic_vector(1 downto 0);          
		Immediate : OUT std_logic_vector(31 downto 0);
		Rf_a : OUT std_logic_vector(31 downto 0);
		Rf_b : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT PipelineIDEX
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		InstuctionIn : IN std_logic_vector(31 downto 0);
		ALUBINSelIn : IN std_logic;
		MEMWrEnIn : IN std_logic;
		rf_write_data_selIn : IN std_logic;
		rf_wr_en_in : IN std_logic;
		alu_func_in : IN std_logic_vector(3 downto 0);
		Opcode : IN std_logic_vector(5 downto 0);
		rfain : IN std_logic_vector(31 downto 0);
		rfbin : IN std_logic_vector(31 downto 0);
		ImmediateIn : IN std_logic_vector(31 downto 0);          
		InstuctionOut : OUT std_logic_vector(31 downto 0);
		ALUBINSelOut : OUT std_logic;
		MEMWrEnOut : OUT std_logic;
		OpcodeOut : OUT std_logic_vector(5 downto 0);
		alu_func_out : OUT std_logic_vector(3 downto 0);
		rf_wr_en_out : OUT std_logic;
		rf_write_data_selOut : OUT std_logic;
		rfaout : OUT std_logic_vector(31 downto 0);
		rfbout : OUT std_logic_vector(31 downto 0);
		ImmediateOut : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT exstage_pip
PORT(
		pcinput : IN std_logic_vector(31 downto 0);
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		DataOutInp : IN std_logic_vector(31 downto 0);
		rfa_sel : IN std_logic_vector(1 downto 0);
		rfb_sel : IN std_logic_vector(1 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		ALU_outafterpipeline : IN std_logic_vector(31 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		pcoutput : OUT std_logic_vector(4 downto 0);
		ALU_zero : OUT std_logic
		);
END COMPONENT;

COMPONENT PipelineEXMEM
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Aluresultin : IN std_logic_vector(31 downto 0);
		RegtoMemoryIn : IN std_logic_vector(31 downto 0);
		RDorRtIn : IN std_logic_vector(4 downto 0);
		rf_wr_en_in : IN std_logic;
		rf_write_data_selIn : IN std_logic;
		MEMWrEnIn : IN std_logic;
		InstuctionIn : IN std_logic_vector(31 downto 0);          
		AluresultOut : OUT std_logic_vector(31 downto 0);
		RegtoMemoryOut : OUT std_logic_vector(31 downto 0);
		rf_wr_en_out : OUT std_logic;
		RDorRtOut : OUT std_logic_vector(4 downto 0);
		rf_write_data_selOut : OUT std_logic;
		MEMWrEnOut : OUT std_logic;
		InstuctionOut : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT ForwardingUnit
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		RegRs : IN std_logic_vector(4 downto 0);
		RegRt : IN std_logic_vector(4 downto 0);
		RdfromPipe2 : IN std_logic_vector(4 downto 0);
		RdfromPipe3 : IN std_logic_vector(4 downto 0);
		Opcode : in std_logic_vector(5 downto 0);
		Rfa_sel : OUT std_logic_vector(1 downto 0);
		Rfb_sel : OUT std_logic_vector(1 downto 0)
		);
END COMPONENT;

COMPONENT memstage_pip
	PORT(
		ByteOp : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);
		MM_RdData : IN std_logic_vector(31 downto 0);          
		MM_Addr : OUT std_logic_vector(31 downto 0);
		MM_WrData : OUT std_logic_vector(31 downto 0);
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT PipelineMemWB
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Instructions : IN std_logic_vector(31 downto 0);
		DatafromMemIn : IN std_logic_vector(31 downto 0);
		rf_write_data_selIn : IN std_logic;
		rf_wr_en_in : IN std_logic;
		AluresultIn : IN std_logic_vector(31 downto 0);          
		Instructionsfinal : OUT std_logic_vector(31 downto 0);
		DatafromMemOut : OUT std_logic_vector(31 downto 0);
		rf_wr_en_out : OUT std_logic;
		rf_write_data_selOut : OUT std_logic;
		AluresultOut : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;


COMPONENT Mux32bit2to1
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		SEL : IN std_logic;          
		X : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

--temp signals that we will use
signal pcloadEn : std_logic;
signal ifidwriteEn : std_logic;
signal instrOutPipe1 : std_logic_vector(31 downto 0);
signal rfbsel : std_logic; -- comes from the control 
signal rfwrenable : std_logic;
signal dadainputfrompipe3 : std_logic_vector(31 downto 0); -- this will come from the multiplexer after the pipeline 3
signal immext1 : std_logic_vector(1 downto 0); -- the control 
signal immeddecstage : std_logic_vector(31 downto 0);
signal rfa : std_logic_vector(31 downto 0);
signal rfb : std_logic_vector(31 downto 0);
signal rdFrompipelineIDEX : std_logic_vector(4 downto 0);
signal instrOutPipe2 : std_logic_vector(31 downto 0);
signal alu_bin_seli : std_logic;
signal alu_bin_selo : std_logic;
signal memweI : std_logic;
signal memweO : std_logic;
signal rf_a_o : std_logic_vector(31 downto 0);
signal rf_b_o : std_logic_vector(31 downto 0);
signal singalHazard : std_logic;
signal alubinselcontrol : std_logic;
signal opcoder : std_logic_vector(5 downto 0);
signal opcoderout : std_logic_vector(5 downto 0);
signal immedOut : std_logic_vector(31 downto 0);
signal aluoutexstage : std_logic_vector(31 downto 0);
signal aluzero_o : std_logic;
signal Aluresultoutpipel : std_logic_vector(31 downto 0);
signal regtomempipe : std_logic_vector(31 downto 0);
signal rdorrttemp : std_logic_vector(4 downto 0);
signal memen_pipelineout : std_logic;
signal instrpipemem : std_logic_vector(31 downto 0);
signal rfasel : std_logic_vector(1 downto 0);
signal rf_bbsel: std_logic_vector(1 downto 0);
signal mmwrite_data : std_logic_vector(31 downto 0);
signal mmaddr : std_logic_vector(31 downto 0);
signal data_out : std_logic_vector(31 downto 0);
signal mm_rdataout : std_logic_vector(31 downto 0);
signal Aluresultoutpipelast : std_logic_vector(31 downto 0);
signal rfwritedatasel : std_logic;
signal rfwritedataseloutpipelineidex : std_logic;
signal rfwritedataseloutpipelineexmem : std_logic;
signal rfwriteDataselfinal : std_logic;
signal instrFinal : std_logic_vector(31 downto 0);
signal pcOut_put : std_logic_vector(4 downto 0);
signal alufunc : std_logic_vector(3 downto 0);
signal data_input : std_logic_vector(31 downto 0);
signal rfwrenableidex : std_logic;
signal rfwrenableEXMEM : std_logic;
signal rfwrenableFinal : std_logic;
signal alufunctout : std_logic_vector(3 downto 0);

begin

-- first the if stage
Inst_If_stage_pip: If_stage_pipeline PORT MAP(
		Clk => Clk,
		Rst => Rst,
		pc_ldEn => pcloadEn, -- checks if the pc should load or not... it's given from the hazard detection unit
		pcinsttomem => pcinsttomem
);


Inst_PipelineIFID: PipelineIFID PORT MAP(
		Clk => Clk,
		Rst => Rst,
		MemoryInstruction => MemoryInstruction,
		IFIDWrite => ifidwriteEn, -- declares if the register will write the given data
		InstructionOutput => instrOutPipe1 -- gives the instruction from the memory that goes to the dec stage
);

Inst_Control_pipeline: Control_pipeline PORT MAP(
		Instruction => instrOutPipe1,
		ALU_Bin_Sel => alubinselcontrol,
		signaldefiner => singalHazard,
		MEM_WrEn => memweI,
		RF_WrEn => rfwrenable,
		RF_WrData_Sel => rfwritedatasel,
		RF_B_Sel => rfbsel,
		Alu_func => alufunc,
		Immext => immext1,
		Opcode => opcoder
	);

Inst_decstage_pipeline: decstage_pipeline PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Instructionfrommem => instrOutPipe1,
		RF_B_sel => rfbsel,
		RF_WrEn => rfwrenableFinal,
		Awr => instrFinal(20 downto 16),
		DataInput => dadainputfrompipe3,
		ImExtcloud => immext1,
		Immediate => immeddecstage,
		Rf_a =>  rfa,
		Rf_b => rfb
	);


Inst_HazardDetectionUnit: HazardDetectionUnit PORT MAP(
		Clk => Clk,
		Reset => Rst,
		Regrs => instrOutPipe1(25 downto 21),
		Regrt => instrOutPipe1(15 downto 11),
		RDfrompipe => instrOutPipe2(20 downto 16),
		OPcode_after_the_pipeline => instrOutPipe2(31 downto 26),
		Pc_ldEn => pcloadEn,
		IFIDwrite => ifidwriteEn,
		controlsignals_sel => singalHazard
	);
	
Inst_PipelineIDEX: PipelineIDEX PORT MAP(
		Clk => Clk,
		Rst => Rst,
		InstuctionIn => instrOutPipe1,
		InstuctionOut => instrOutPipe2,
		ALUBINSelIn => alubinselcontrol,
		ALUBINSelOut => alu_bin_selo,
		MEMWrEnIn => memweI,
		MEMWrEnOut => memweO,
		rf_write_data_selIn => rfwritedatasel,
		rf_wr_en_in => rfwrenable,
		alu_func_in => alufunc,
		alu_func_out => alufunctout,
		rf_wr_en_out => rfwrenableidex,
		rf_write_data_selOut => rfwritedataseloutpipelineidex,
		Opcode => opcoder,
		OpcodeOut => opcoderout,
		rfain => rfa,
		rfaout => rf_a_o,
		rfbin => rfb,
		rfbout => rf_b_o,
		ImmediateIn => immeddecstage,
		ImmediateOut => immedOut
	);


Inst_exstage_pip: exstage_pip PORT MAP(
		pcinput => instrOutPipe2,
		RF_A => rf_a_o,
		RF_B => rf_b_o,
		Immed => immedOut,
		DataOutInp => dadainputfrompipe3,
		rfa_sel => rfasel,
		rfb_sel => rf_bbsel,
		ALU_Bin_sel => alu_bin_selo,
		ALU_func => alufunctout,
		ALU_out => aluoutexstage,
		ALU_outafterpipeline => Aluresultoutpipel,
		pcoutput => pcOut_put,
		ALU_zero => aluzero_o
	);


Inst_ForwardingUnit: ForwardingUnit PORT MAP(
		Clk => Clk,
		Rst => Rst,
		RegRs => instrOutPipe2(25 downto 21),
		RegRt => instrOutPipe2(15 downto 11),
		RdfromPipe2 => rdorrttemp,
		Opcode => opcoderout,
		RdfromPipe3 => instrFinal(20 downto 16) ,
		Rfa_sel => rfasel,
		Rfb_sel => rf_bbsel
	);

--		Inst_ForwardingUnit: ForwardingUnit PORT MAP(
--		CLK => Clk,
--		RST => Rst,
--		Opcode => opcoder,
--		RS => instrOutPipe2(25 downto 21),
--		RT => instrOutPipe2(15 downto 11),
--		EX_MEM_IN => rdorrttemp,
--		MEM_WB_IN => instrFinal(20 downto 16),
--		rfa_sel => rfasel,
--		rfb_sel => rf_bbsel
--	);
Inst_PipelineEXMEM: PipelineEXMEM PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Aluresultin => aluoutexstage,
		AluresultOut => Aluresultoutpipel,
		RegtoMemoryIn => rf_b_o,
		RegtoMemoryOut => regtomempipe,
		RDorRtIn => instrOutPipe2(20 downto 16),
		rf_wr_en_in => rfwrenableidex,
		rf_wr_en_out => rfwrenableEXMEM,
		RDorRtOut => rdorrttemp,
		rf_write_data_selIn => rfwritedataseloutpipelineidex,
		rf_write_data_selOut => rfwritedataseloutpipelineexmem,
		MEMWrEnIn => memweO,
		MEMWrEnOut => memen_pipelineout,
		InstuctionIn => instrOutPipe2,
		InstuctionOut => instrpipemem
	);


Inst_memstage_pip: memstage_pip PORT MAP(
		ByteOp => '0',
		ALU_MEM_Addr => Aluresultoutpipel,
		MEM_DataIn => regtomempipe,
		MM_RdData => mm_rdData,
		MM_Addr => ALU_MEM_Addr,
		MM_WrData => datatomem,
		MEM_DataOut => data_out
	);	
ByteOp <= '0';


Inst_PipelineMemWB: PipelineMemWB PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Instructions => instrpipemem,
		Instructionsfinal => instrFinal,
		DatafromMemIn => regtomempipe,
		DatafromMemOut => mm_rdataout,
		rf_write_data_selIn => rfwritedataseloutpipelineexmem,
		rf_wr_en_in => rfwrenableEXMEM,
		rf_wr_en_out => rfwrenableFinal,
		rf_write_data_selOut => rfwriteDataselfinal,
		AluresultIn => Aluresultoutpipel,
		AluresultOut => Aluresultoutpipelast
);

Inst_Mux32bit2to1: Mux32bit2to1 PORT MAP(
		A => Aluresultoutpipelast,
		B => mm_rdataout,
		SEL => rfwriteDataselfinal,
		X => dadainputfrompipe3
	);

end Structural;

