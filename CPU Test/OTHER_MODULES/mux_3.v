`timescale 1ns/100ps

module mux_3(INPUT1, INPUT2, INPUT3 , RESULT, SELECT);
    input [31:0] INPUT1, INPUT2, INPUT3; 
    input [1:0] SELECT;               // inputs
    output reg [31:0] RESULT;    // outputs

    always @(*)
    begin
      if (SELECT == 2'b00)  //selecting  
            RESULT = INPUT1;
      else if (SELECT == 2'b01) 
            RESULT = INPUT2;
	  else if (SELECT == 2'b10)
			RESULT = INPUT3;
    end

endmodule
