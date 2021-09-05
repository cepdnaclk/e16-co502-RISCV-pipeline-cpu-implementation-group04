`timescale 1ns/100ps
/*
In this unit getting the two register adress of curren instruction in EX stage and destingtion address of instruction in mem and Writeback stages
Then compare them
	1.If RD1 equal PREV_INADD then FORWARD1 = 1
	2.If RD1 equal PREV_PREV_INADD then FORWARD1 = 2
	3.IF RD1 doesnt equal any then FORWARD1 = 0
	4.If RD2 equal PREV_INADD then FORWARD2 = 1
	5.If RD2 equal PREV_PREV_INADD then FORWARD2 = 2
	3.IF RD2 doesnt equal any then FORWARD2 = 0
*/
module fowarding_unit(CLK,RESET,RD1,RD2,PREV_INADD, PREV_PREV_INADD,FORWARD1, FORWARD2);
	input CLK,RESET;
	input[4:0] RD1,RD2,PREV_INADD,PREV_PREV_INADD;
	output reg [1:0] FORWARD1,FORWARD2;
	
	always @(posedge CLK) begin
		#2
		if(RD1==PREV_INADD) begin
			FORWARD1 = 1;
		end
		else if (RD1 == PREV_PREV_INADD) begin
			FORWARD1 = 2;
		end
		else begin
			FORWARD1 = 0;
		end
		
		if(RD2==PREV_INADD) begin
			FORWARD2 = 1;
		end
		else if (RD2 == PREV_PREV_INADD) begin
			FORWARD2 = 2;
		end
		else begin
			FORWARD2 = 0;
		end
	end
endmodule