`timescale 1ns/100ps

module mux(INPUT1, INPUT2, RESULT, SELECT);
    input [31:0] INPUT1, INPUT2; 
    input SELECT;               // inputs
    output reg [31:0] RESULT;    // outputs

    always @(*)
    begin
      if (SELECT == 1'b0)  //selecting  
            RESULT = INPUT1;
      else 
            RESULT = INPUT2;
    end

endmodule
