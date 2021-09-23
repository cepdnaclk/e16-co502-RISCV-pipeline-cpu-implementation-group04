`timescale 1ns/100ps
 module pipeline4(CLK, RESET, BUSY_WAIT,REG_WRITE, MEM_TO_REG, ALU_RESULT, DATA_READED, IN_ADDRESS, PC_NEXT,
 REG_WRITE_OUT, MEM_TO_REG_OUT, ALU_RESULT_OUT, DATA_READED_OUT, IN_ADDRESS_OUT, PC_NEXT_OUT);
	//inputs for clock, busy wait
	input CLK, RESET, BUSY_WAIT, REG_WRITE;
	input [1:0] MEM_TO_REG;
	input [4:0] IN_ADDRESS;
	input [31:0] ALU_RESULT, DATA_READED, PC_NEXT;
	
	output reg REG_WRITE_OUT;
	output reg [1:0] MEM_TO_REG_OUT;
	output reg [2:0] MEM_READ_OUT;
	output reg [4:0] IN_ADDRESS_OUT;
	output reg [31:0] ALU_RESULT_OUT, DATA_READED_OUT, PC_NEXT_OUT;
	
	always @(posedge CLK) begin
		#1
		if (!BUSY_WAIT & !RESET) begin
			REG_WRITE_OUT <=  REG_WRITE;
			MEM_TO_REG_OUT <=  MEM_TO_REG;
			IN_ADDRESS_OUT <=  IN_ADDRESS;
			ALU_RESULT_OUT <=  ALU_RESULT;
			DATA_READED_OUT <=  DATA_READED;
			PC_NEXT_OUT <=  PC_NEXT;
			//BRANCH_SEL_OUT <= BRANCH_SET;
		end
	end
	
	always @(*) begin
	#1
		if(RESET == 1'b1) begin
			REG_WRITE_OUT = 0;
			MEM_TO_REG_OUT = 0;
			IN_ADDRESS_OUT = 0;
			ALU_RESULT_OUT = 0;
			DATA_READED_OUT = 0;
			PC_NEXT_OUT = 0;
			//BRANCH_SEL_OUT = 0;
		end
	end
endmodule