`timescale 1ns/100ps

module adder(INPUT1, INPUT2, RESULT); 

	input [31:0] INPUT1, INPUT2; 
    output reg [31:0] RESULT;
    always @(*) begin
      RESULT = (INPUT1<<2) + INPUT2;
    end

endmodule