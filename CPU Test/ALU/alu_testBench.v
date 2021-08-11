/*Test bench for alu testing
compile : iverilog -o alu_testBench alu_TestBench.v
run: vvp alu_testBench
gtkwave : gtkwave alu_wave.vcd
*/
`include "../assert.v" 
`include "alu.v"
`timescale 1ns/100ps
module alu_tb;

    reg CLK, RESET;
    wire [31:0] RESULT;
	wire BRANCH;
    reg [31:0] DATA1, DATA2;
    reg [4:0] SELECT;

    alu myalu(DATA1, DATA2, RESULT, BRANCH, SELECT);
    
    initial begin
        CLK = 1'b0;
	$dumpfile("alu_wave.vcd");
	$dumpvars(0, alu_tb);
        #1
        RESET = 1'b1;

        #3
        RESET = 1'b0;

        //Test 1: addition
		SELECT = 5'b0;
		DATA1 = 32'd5;
		DATA2 = 32'd10;

    	// wait for add to happen
    	#3
    	`assert(RESULT, 32'd15);
    
    	$display("TEST 0 : ADD Passed!");
		
		//Test 2: shift lest logical
		#1
		SELECT = 5'b00001;
		DATA1 = 32'd5;
		DATA2 = 32'd2;
		
		#3
    	`assert(RESULT, 32'd20);
    
    	$display("TEST 1 : Shift Left Logical Passed!");
		
		//Test 3: set less than
		#1
		SELECT = 5'b00010;
		DATA1 = 32'd6;
		DATA2 = 32'b11111111111111111111111111111110; //-2
		
		#3
    	`assert(RESULT, 32'd0);
    
    	$display("TEST 2 : Set Less Than Passed!");
		
		//Test 4: set less than unsingned
		#1
		SELECT = 5'b00011;
		DATA1 = 32'd6;
		DATA2 = 32'b11111111111111111111111111111110;
		
		#3
    	`assert(RESULT, 32'd1);
    
    	$display("TEST 4 : Set Less Than Unsigned Passed!");
		
		//Test 5: Bitwise XOR
		#1
		SELECT = 5'b00100;
		DATA1 = 32'd13;
		DATA2 = 32'd56;
		
		#3
    	`assert(RESULT, 32'd53);
    
    	$display("TEST 5: XOR Passed!");
		
		
		//Test 7: Bitwise OR
		#1
		SELECT = 5'b00110;
		DATA1 = 32'd13;
		DATA2 = 32'd56;
		
		#3
    	`assert(RESULT, 32'd61);
    
    	$display("TEST 7: OR Passed!");
		
		//Test 8: Bitwise AND
		#1
		SELECT = 5'b00111;
		DATA1 = 32'd13;
		DATA2 = 32'd56;
		
		#3
    	`assert(RESULT, 32'd8);
    
    	$display("TEST 7: AND Passed!");
		
		//Test subtraction
		#1
		SELECT = 5'b10000;
		DATA1 = 32'd15;
		DATA2 = 32'd10;
		
		#3
    	`assert(RESULT, 32'd5);
    
    	$display("TEST 7 : SUB Passed!");
		
		//Test BEQ
		#1
		SELECT = 5'b01000;
		DATA1 = 32'd10;
		DATA2 = 32'd10;
		
		#3
    	`assert(BRANCH, 1);
    
    	$display("TEST 8 : BEQ Passed!");
		
		//Test BNE
		#1
		SELECT = 5'b01001;
		DATA1 = 32'd10;
		DATA2 = 32'd11;
		
		#3
    	`assert(BRANCH, 1);
    
    	$display("TEST 9 : BNE Passed!");
		
		//Test BLT
		#1
		SELECT = 5'b01100;
		DATA1 = 32'd10;
		DATA2 = 32'd11;
		
		#3
    	`assert(BRANCH, 1);
    
    	$display("TEST 12 : BLT Passed!");
		
		//Test Multplication
		#1
		SELECT = 5'b11000;
		DATA1 = 32'd50000000000;
		DATA2 = 32'd200;
		
		#3
    	`assert(RESULT, 32'd10000000000000);
    
    	$display(RESULT);
		
		//Test Divition
		#1
		SELECT = 5'b11100;
		DATA1 = 32'd10;
		DATA2 = 32'd2;
		
		#3
    	`assert(RESULT, 32'd5);
    
    	$display("TEST 28 : Divition Passed!");
		
		//Test Remainder
		#1
		SELECT = 5'b11101;
		DATA1 = 32'd27;
		DATA2 = 32'd5;
		
		#3
    	`assert(RESULT, 32'd2);
    
    	$display("TEST 29 : Remainder Passed!");
		

        #500
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule
