`timescale 1ns/100ps

module pipeline2(CLK, RESET, RESET2, BRANCH, REG_DEST,REG_WRITE,MEM_TO_REG,ALU_SOURCE,MEM_READ,MEM_WRITE,IMMI_SEL, ALU_OP, OUT1, OUT2, PC_INCREMENT4,SIGN_EXTENDED, RD1, RD2, BUSY_WAIT,PC_SEL,OUT1ADDRESS,OUT2ADDRESS,
BRANCH_OUT,REG_DEST_OUT,REG_WRITE_OUT,PC_SEL_OUT,MEM_TO_REG_OUT,ALU_SOURCE_OUT,MEM_READ_OUT,MEM_WRITE_OUT,IMMI_SEL_OUT,ALU_OP_OUT,OUT1_OUT, OUT2_OUT, PC_INCREMENT4_OUT, SIGN_EXTENDED_OUT, RD1_OUT, RD2_OUT,OUT1ADDRESS_OUT,OUT2ADDRESS_OUT);
	input CLK, RESET, BRANCH,REG_DEST, REG_WRITE, BUSY_WAIT,PC_SEL,RESET2;
	input [1:0] MEM_TO_REG,ALU_SOURCE;
	input [2:0] MEM_READ,MEM_WRITE,IMMI_SEL;
	input [4:0] ALU_OP,RD1, RD2, OUT1ADDRESS, OUT2ADDRESS;
	input [31:0] OUT1, OUT2, PC_INCREMENT4, SIGN_EXTENDED; 
	
	output reg BRANCH_OUT,REG_DEST_OUT, REG_WRITE_OUT,PC_SEL_OUT;
	output reg [1:0] MEM_TO_REG_OUT,ALU_SOURCE_OUT;
	output reg [2:0] MEM_READ_OUT,MEM_WRITE_OUT,IMMI_SEL_OUT;
	output reg [4:0] ALU_OP_OUT,RD1_OUT,RD2_OUT, OUT1ADDRESS_OUT, OUT2ADDRESS_OUT;
	output reg [31:0] OUT1_OUT, OUT2_OUT, PC_INCREMENT4_OUT, SIGN_EXTENDED_OUT;
	
	always @(posedge CLK) begin
		//one time unit dealay
		#1
		if (!RESET & !RESET2 & !BUSY_WAIT) begin
			BRANCH_OUT <= #1 BRANCH;
			REG_DEST_OUT <= REG_DEST;
			MEM_TO_REG_OUT <= #2 MEM_TO_REG;
			ALU_SOURCE_OUT <= ALU_SOURCE;
			MEM_READ_OUT <= #1 MEM_READ;
			MEM_WRITE_OUT <= #1 MEM_WRITE;
			IMMI_SEL_OUT <= IMMI_SEL;
			ALU_OP_OUT <= ALU_OP;
			OUT1_OUT <= OUT1;
			OUT2_OUT <= #1 OUT2;
			PC_INCREMENT4_OUT <= PC_INCREMENT4;
			SIGN_EXTENDED_OUT <= SIGN_EXTENDED;
			REG_WRITE_OUT <= #2 REG_WRITE;
			RD1_OUT <= RD1;
			RD2_OUT = RD2;
			PC_SEL_OUT <= #1 PC_SEL;
			OUT1ADDRESS_OUT <= OUT1ADDRESS;
			OUT2ADDRESS_OUT <= OUT2ADDRESS;
		
		end
	end
	always @(*) begin
		//one time unit dealay
		#1
		if(RESET == 1'b1 || RESET2 == 1'b1) begin
			BRANCH_OUT = 0;
			REG_DEST_OUT = 0;
			MEM_TO_REG_OUT = 0;
			ALU_SOURCE_OUT = 0;
			MEM_READ_OUT = 0;
			MEM_WRITE_OUT = 0;
			IMMI_SEL_OUT = 0;
			ALU_OP_OUT = 0;
			OUT1_OUT = 0;
			OUT2_OUT = 0;
			PC_INCREMENT4_OUT = -4;
			SIGN_EXTENDED_OUT = 0;
			REG_WRITE_OUT = 0;
			RD1_OUT=0;
			RD2_OUT = 0;
			OUT1ADDRESS_OUT = 0;
			OUT2ADDRESS_OUT = 0;
		end
	end
endmodule