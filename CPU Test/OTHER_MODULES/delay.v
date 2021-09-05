`timescale 1ns/100ps

module delay(INPUT, OUTPUT);
input [4:0] INPUT;
output reg [4:0]  OUTPUT; 
	always @(*)
    begin
		#1
		OUTPUT = INPUT;
      
    end
endmodule