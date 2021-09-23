`timescale 1ns/100ps
 module pipeline1(CLK, RESET, RESET2, INSTRUCTION, PC_INCREMENT4, BUSY_WAIT, INSTRUCTION_OUT, PC_INCREMENT4_OUT);
	//inputs for clock, busy wait
	input CLK, RESET, BUSY_WAIT,RESET2;
	input [31:0] INSTRUCTION, PC_INCREMENT4;
	output reg [31:0] INSTRUCTION_OUT, PC_INCREMENT4_OUT;
	
	always @(posedge CLK) begin
		//one time unit delay for assigning setting out vale
		#1
		if (!RESET & !RESET2 & !BUSY_WAIT) begin
			PC_INCREMENT4_OUT = #1 PC_INCREMENT4;
			INSTRUCTION_OUT = INSTRUCTION;
		end
	end
	
	always @(*) begin
		#1
		if(RESET == 1'b1 | RESET2 == 1'b1) begin
			INSTRUCTION_OUT <= 32'd0;
			PC_INCREMENT4_OUT <= #1  -32'd4;
		end
	end
endmodule
	