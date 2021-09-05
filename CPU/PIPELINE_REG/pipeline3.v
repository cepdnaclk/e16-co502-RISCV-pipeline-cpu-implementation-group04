`timescale 1ns/100ps

module pipeline3(CLK, RESET, BUSY_WAIT,REG_WRITE, MEM_READ, MEM_TO_REG, MEM_WRITE, BRANCH_RES, ALU_RESULT,ZERO, OUT2, IN_ADDRESS, PC_NEXT,
				BRANCH_RES_OUT, REG_WRITE_OUT, MEM_READ_OUT,MEM_WRITE_OUT, MEM_TO_REG_OUT, IN_ADDRESS_OUT, ALU_RESULT_OUT,ZERO_OUT, OUT2_OUT, PC_NEXT_OUT);
	input CLK, RESET, BUSY_WAIT, BRANCH_RES, REG_WRITE,ZERO;
	input [2:0] MEM_READ,MEM_WRITE;
	input [1:0] MEM_TO_REG;
	input [4:0] IN_ADDRESS;
	input [31:0] ALU_RESULT, OUT2, PC_NEXT;
	
	output reg BRANCH_RES_OUT,REG_WRITE_OUT,ZERO_OUT;
	output reg [2:0] MEM_READ_OUT,MEM_WRITE_OUT;
	output reg [1:0] MEM_TO_REG_OUT;
	output reg [4:0] IN_ADDRESS_OUT;
	output reg [31:0] ALU_RESULT_OUT, OUT2_OUT, PC_NEXT_OUT;
	
	always @(posedge CLK) begin
		#1
		if (!BUSY_WAIT & !RESET) begin
			BRANCH_RES_OUT <= BRANCH_RES;
			ZERO_OUT <= ZERO;
			REG_WRITE_OUT <= #1 REG_WRITE;
			MEM_READ_OUT <= MEM_READ;
			MEM_WRITE_OUT <= MEM_WRITE;
			MEM_TO_REG_OUT <= #1 MEM_TO_REG;
			IN_ADDRESS_OUT <= #1 IN_ADDRESS;
			ALU_RESULT_OUT <= ALU_RESULT;
			OUT2_OUT <= OUT2;
			PC_NEXT_OUT <= #1 PC_NEXT;
		end
	end
	
	//when reset do we need to reset all
	always @(*) begin
		#1
		if(RESET == 1'b1) begin
			BRANCH_RES_OUT = 0;
			REG_WRITE_OUT = 0;
			MEM_READ_OUT = 0;
			MEM_WRITE_OUT = 0;
			MEM_TO_REG_OUT = 0;
			IN_ADDRESS_OUT = 0;
			ALU_RESULT_OUT = 0;
			OUT2_OUT = 0;
			PC_NEXT_OUT = 0;
			ZERO_OUT = 0 ;
		end
	end
endmodule