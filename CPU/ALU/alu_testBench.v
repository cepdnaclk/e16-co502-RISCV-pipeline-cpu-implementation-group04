`include "../utils/macros.v" 
`include "alu.v"

module alu_testbench;

    reg CLK, RESET;
    wire [31:0] RESULT;
    reg [31:0] DATA1, DATA2;
    reg [5:0] SELECT;

    alu myalu(DATA1, DATA2, RESULT, SELECT);
    
    initial begin
        CLK = 1'b0;
        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

         
		//TEST 1 : ADD operation test
	
		SELECT = 5'b0; //for add operation
		DATA1 = 32'd5;
		DATA2 = 32'd10;
		
		#3
		`assert(RESULT, 32'd15);
		
		$display("TEST 1 Passed!");
		
		//Test 2 : SUB operation
		
		SELECT = 5'b0; //for sub operation
		DATA1 = 32'd30;
		DATA2 = 32'd10;
		
		#3
		`assert(RESULT, 32'd20);
		
		$display("TEST 2 Passed!")
		
		
        #500
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule