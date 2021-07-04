`include "../assert.v" 
`include "alu.v"
`timescale 1ns/100ps
module reg_file_tb;

    reg CLK, RESET;
    wire [31:0] RESULT;
    reg [31:0] DATA1, DATA2;
    reg [4:0] SELECT;

    alu myalu(DATA1, DATA2, RESULT, SELECT);
    
    initial begin
        CLK = 1'b0;
	$dumpfile("reg_file_wavedata.vcd");
	$dumpvars(0, reg_file_tb);
        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        //Test 1: addition
	SELECT = 5'b0;
	DATA1 = 32'd5;
	DATA2 = 32'd10;

    	// wait for add to happen
    	#3
    	`assert(RESULT, 32'd15);
    
    	$display("TEST 1 : ADD Passed!");
	#1
	SELECT = 5'b00001;
	DATA1 = 32'd15;
	DATA2 = 32'd10;
	

        #500
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule
