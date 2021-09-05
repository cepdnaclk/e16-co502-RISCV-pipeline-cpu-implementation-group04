`timescale 1ns/100ps
module OR_2(output Y, input A, input B);
   or(Y, A, B); 
endmodule


module AND_2(output Y, input A, B);
   and(Y, A, B); 
endmodule

//muxtiflexer module 5 bit*********************************************
module mux_5bit(IN0,IN1,SEL,OUT);
	//declaring the ports
	input [4:0] IN0,IN1;
	input SEL;
	output reg [4:0] OUT;
	
	always @ (SEL,IN0,IN1) begin //set sensivity 
	#1
	if(SEL == 1'b0)begin
	OUT = IN0; 
	end
	else if(SEL == 1'b1) begin
	OUT = IN1;
	end
	end
	
endmodule

//muxtiflexer module*********************************************
module mux_32bit(IN0,IN1,SEL,OUT);

	//declaring the ports
	input [31:0] IN0,IN1;
	input SEL;
	output reg [31:0] OUT;
	
	always @ (SEL,IN0,IN1) begin #1//set sensivity 
	if(SEL == 1'b0)begin
	OUT = IN0; 
	end
	else if(SEL == 1'b1) begin
	OUT = IN1;
	end
	end
	
endmodule

//muxtiflexer module*********************************************
module mux_32bitx3(IN0,IN1,IN2,SEL,OUT);
	//declaring the ports
	input [31:0] IN0,IN1,IN2;
	input [1:0]SEL;
	output reg [31:0] OUT;
	
	always @ (SEL,IN0,IN1,IN2) begin #1//set sensivity 
	if(SEL == 2'b00)begin
	OUT = IN0; 
	end
	else if(SEL == 2'b01) begin
	OUT = IN1;
	end
	else if(SEL == 2'b10) begin
	OUT = IN2;
	end
	
	end
	
endmodule