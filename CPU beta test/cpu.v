`timescale 1ns/100ps
`include "gates.v"
`include "PC.v"
`include "pipeline1.v"
`include "pipeline2.v"
`include "pipeline3.v"
`include "pipeline4.v"
`include "sign.v"
`include "control_unit.v"
`include "reg.v"
`include "mem_read_con.v"
`include "mem_write_con.v"
`include "adder.v"
`include "alu.v"
//************************CPU module***************************************
module cpu(CLK,RESET,INSTRUCTIONS,I_BUSYWAIT,M_READDATA,M_BUSYWAIT,PC,M_WRITEDATA,M_ADDRESS,READ,WRITE);
	//declaring inputs and outputs
	input CLK,RESET;
	
	input [31:0] INSTRUCTIONS,M_READDATA;
	input I_BUSYWAIT,M_BUSYWAIT;
	
	output  [31:0] PC;
	
	output  [31:0]  M_WRITEDATA,M_ADDRESS;
	output  WRITE,READ;
	
	//declaring wires
	wire AND_OUT,BUSYWAIT;
	wire  reg GATE_OUT,GATE_OUT2;
	wire [31:0] PC_4,MUX4_OUT,P1_INSTRUCTION_OUT,P1_PC_4_OUT,SIGNOUT,OUT1,OUT2,P2_OUT1_OUT, P2_OUT2_OUT,P2_PC_4_OUT,P2_SIGNOUT_OUT,P3_OUT2_OUT;
	wire [2:0] IMMI_SEL,MEM_READ,MEM_WRITE,P2_MEM_READ_OUT,P2_MEM_WRITE_OUT,P2_IMMI_SEL_OUT,P3_MEM_READ_OUT,P3_MEM_WRITE_OUT;
	wire REG_WRITE,BRANCH,REG_DEST,PC_SEL,P4_REG_WRITE_OUT;
	wire [1:0] MEM_TO_REG,ALU_SOURCE,P2_MEM_TO_REG_OUT,P2_ALU_SOURCE_OUT,P3_MEM_TO_REG_OUT,P4_MEM_TO_REG_OUT; 
	wire [4:0] ALU_OP,P2_ALU_OP_OUT;
	wire [4:0] P4_IN_ADDRESS_OUT, P2_RD1_OUT, P2_RD2_OUT,MUX1_OUT,P3_IN_ADDRESS_OUT;
	
	wire P2_BRANCH_OUT,P2_REG_DEST_OUT,P2_REG_WRITE_OUT,P2_PC_SEL_OUT,ZERO,P3_BRANCH_OUT,P3_REG_WRITE_OUT,P3_ZERO_OUT;
	wire [31:0] MUX2_OUT,MUX3_OUT,ADDER_OUT,ALU_OUT,P3_ALU_OUT,P4_ALU_OUT,P3_PC_NEXT_OUT,M_READDATA_OUT,P4_M_READDATA_OUT,P4_PC_NEXT_OUT;
	
	
	
	initial begin   //initial settings
		  //initialy it is zero
		
		end
		
		

//OR gate for busy signals
	OR_2 OR_21(BUSYWAIT,I_BUSYWAIT,M_BUSYWAIT);
	
//PC connect	
	PC_UNIT PC_UNIT1(PC,PC_4,MUX4_OUT,CLK,RESET,AND_OUT,BUSYWAIT);

	
//connect first pipeline
	pipeline1 pipeline11(CLK, RESET, INSTRUCTIONS, PC_4, BUSYWAIT, P1_INSTRUCTION_OUT, P1_PC_4_OUT);
	
//connect sign extender
	sign sign1(P1_INSTRUCTION_OUT[31:0],IMMI_SEL,SIGNOUT);
	
	
//connect control unit	
	ctrl_unit ctrl_unit1(P1_INSTRUCTION_OUT[6:0],P1_INSTRUCTION_OUT[14:12],P1_INSTRUCTION_OUT[31:25],CLK,RESET,MEM_READ,MEM_WRITE,REG_WRITE,MEM_TO_REG,BRANCH,REG_DEST,ALU_SOURCE,ALU_OP,IMMI_SEL,PC_SEL);

//connect mux for regdest	

//connect the register file
	reg_file reg_file1(MUX4_OUT, OUT1, OUT2, P4_IN_ADDRESS_OUT, P1_INSTRUCTION_OUT[19:15], P1_INSTRUCTION_OUT[24:20], P4_REG_WRITE_OUT, CLK, RESET);
	

//connect 2ND pipeline
	pipeline2 pipeline21(CLK, RESET, BRANCH, REG_DEST,REG_WRITE,MEM_TO_REG,ALU_SOURCE,MEM_READ,MEM_WRITE,IMMI_SEL, ALU_OP, OUT1, OUT2, P1_PC_4_OUT,SIGNOUT, 
	P1_INSTRUCTION_OUT[24:20], P1_INSTRUCTION_OUT[11:7], BUSYWAIT,PC_SEL,
	P2_BRANCH_OUT,P2_REG_DEST_OUT,P2_REG_WRITE_OUT,P2_PC_SEL_OUT,P2_MEM_TO_REG_OUT,P2_ALU_SOURCE_OUT,P2_MEM_READ_OUT,P2_MEM_WRITE_OUT,P2_IMMI_SEL_OUT,P2_ALU_OP_OUT,P2_OUT1_OUT, P2_OUT2_OUT, P2_PC_4_OUT, 
	P2_SIGNOUT_OUT, P2_RD1_OUT, P2_RD2_OUT);
	

	
//mux1
	mux_5bit mux1(P2_RD1_OUT, P2_RD2_OUT,P2_REG_DEST_OUT,MUX1_OUT);
	
//mux2
	mux_32bit mux2(P2_PC_4_OUT, P2_OUT1_OUT,P2_PC_SEL_OUT,MUX2_OUT);

//mux3
	mux_32bitx3 mux3(P2_OUT2_OUT, P2_SIGNOUT_OUT,P2_PC_4_OUT,P2_ALU_SOURCE_OUT,MUX3_OUT);
	
//connect adder
	adder adder1(P2_SIGNOUT_OUT, MUX2_OUT, ADDER_OUT); 
		
//connect the ALU
	alu alu1(P2_OUT1_OUT, MUX3_OUT, ALU_OUT,ZERO,P2_ALU_OP_OUT);	

// connect the 3rd pipeline
	pipeline3 pipeline31(CLK, RESET, BUSYWAIT,P2_REG_WRITE_OUT,P2_MEM_READ_OUT, P2_MEM_TO_REG_OUT, P2_MEM_WRITE_OUT, P2_BRANCH_OUT, ALU_OUT,ZERO, P2_OUT2_OUT, MUX1_OUT, ADDER_OUT,
				P3_BRANCH_OUT, P3_REG_WRITE_OUT, P3_MEM_READ_OUT,P3_MEM_WRITE_OUT, P3_MEM_TO_REG_OUT, P3_IN_ADDRESS_OUT, P3_ALU_OUT,P3_ZERO_OUT, P3_OUT2_OUT, P3_PC_NEXT_OUT);
	
//and gate for branch
	AND_2 AND_21(AND_OUT,P3_BRANCH_OUT,P3_ZERO_OUT)	;
	
//memeory Write controller
	mem_write_con mem_write_con1(P3_OUT2_OUT,M_WRITEDATA, P3_MEM_WRITE_OUT,WRITE  );
	
//memeory read controller
	MEM_READ_con MEM_READ_con1(M_READDATA,M_READDATA_OUT,P3_MEM_READ_OUT,READ);
	
//connect the 4th pipeline
	pipeline4 pipeline41(CLK, RESET, BUSYWAIT,P3_REG_WRITE_OUT, P3_MEM_TO_REG_OUT, P3_ALU_OUT, M_READDATA_OUT, P3_IN_ADDRESS_OUT, P3_PC_NEXT_OUT, 
 P4_REG_WRITE_OUT, P4_MEM_TO_REG_OUT, P4_ALU_OUT, P4_M_READDATA_OUT, P4_IN_ADDRESS_OUT, P4_PC_NEXT_OUT);
	

//conect the mux4
		mux_32bitx3 mux_32bitx31(P4_ALU_OUT,P4_M_READDATA_OUT,P4_PC_NEXT_OUT,P4_MEM_TO_REG_OUT,MUX4_OUT);
	
	
	
	

	

	
	
	
	
	
	

endmodule



















