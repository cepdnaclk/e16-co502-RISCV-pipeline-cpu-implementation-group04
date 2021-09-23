`timescale 1ns/100ps

module adder(INPUT1, INPUT2, RESULT); 

    input [31:0] INPUT1, INPUT2; 
    output reg [31:0] RESULT;
  wire [31:0] temp;
  temp = INPUT1 <<2 ;
    always @(*) 
    begin
      RESULT = temp + INPUT2;
    end

endmodule
