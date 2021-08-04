`timescale 1ns/100ps
 module pipeline1(CLK, RESET, INSTRUCTION, PC_INCREMENT4, BUSY_WAIT, INSTRUCTION_OUT, PC_INCREMENT4_OUT);
	//inputs for clock, busy wait
	input CLK, RESET, BUSY_WAIT;
	input [31:0] INSTRUCTION, PC_INCREMENT4;
	output reg [31:0] INSTRUCTION_OUT, PC_INCREMENT4_OUT;
	
	always @(posedge CLK) begin
		if (!BUSY_WAIT) begin
			PC_INCREMENT4_OUT = PC_INCREMENT4;
			INSTRUCTION_OUT = INSTRUCTION;
		end
	end
	
	always @(RESET) begin
		if(RESET == 1'b1) begin
			INSTRUCTION_OUT=0;
		end
	end
endmodule
	