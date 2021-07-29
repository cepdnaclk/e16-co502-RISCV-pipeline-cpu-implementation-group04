`timescale 1ns/100ps

module pipeline2(CLK, RESET, BUSY_WAIT,REG_WRITE, MEM_READ, MEM_TO_REG, MEM_WRITE, BRANCH_RES, ALU_RESULT, OUT2, IN_ADDRESS, PC_NEXT
				BRANCH_RES_OUT, REG_DEST_OUT, REG_WRITE_OUT, MEM_READ_OUT,MEM_WRITE_OUT, MEM_TO_REG_OUT, IN_ADDRESS_OUT, ALU_RESULT_OUT, OUT2_OUT, PC_NEXT_OUT);
	input CLK, RESET, BUSY_WAIT, BRANCH_RES,REG_DEST, REG_WRITE;
	input [2:0] MEM_READ,MEM_WRITE;
	input [1:0] MEM_TO_REG;
	input [4:0] IN_ADDRESS;
	input [31:0] ALU_RESULT, OUT2, PC_NEXT;
	
	output reg BRANCH_RES_OUT,REG_DEST_OUT, REG_WRITE_OUT;
	output reg [2:0] MEM_READ_OUT,MEM_WRITE_OUT;
	output reg [1:0] MEM_TO_REG_OUT;
	output reg [4:0] IN_ADDRESS_OUT;
	output reg [31:0] ALU_RESULT_OUT, OUT2_OUT, PC_NEXT_OUT;
	
	always @(posedge CLK) begin
		if (!BUSY_WAIT) begin
			BRANCH_RES_OUT = BRANCH_RES;
			REG_DEST_OUT = REG_DEST;
			REG_WRITE_OUT = REG_WRITE;
			MEM_READ_OUT = MEM_READ;
			MEM_WRITE_OUT = MEM_WRITE;
			MEM_TO_REG_OUT = MEM_TO_REG;
			IN_ADDRESS_OUT = IN_ADDRESS;
			ALU_RESULT_OUT = ALU_RESULT;
			OUT2_OUT = OUT2;
			PC_NEXT_OUT = PC_NEXT;
		end
	end
	
	//when reset do we need to reset all
	always @(reset) begin
		if(reset == 1'b1) begin
			
		end
	end
endmodule