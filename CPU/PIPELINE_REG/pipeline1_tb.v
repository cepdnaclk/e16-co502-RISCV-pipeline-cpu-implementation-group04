//Test Bench for pipeline1
`include "../assert.v" 
`include "pipeline1.v"
`timescale 1ns/100ps

module pipeline1_tb;
    
    reg [31:0] INSTRUCTION, PC_INCREMENT4;

    reg CLK, RESET, BUSY_WAIT;

    wire [31:0] INSTRUCTION_OUT, PC_INCREMENT4_OUT;


    pipeline1 my_pipeline1( CLK, RESET, INSTRUCTION, PC_INCREMENT4, BUSY_WAIT, INSTRUCTION_OUT, PC_INCREMENT4_OUT);

    initial begin
        
        CLK = 1'b0;
        RESET = 1'b0;
        BUSY_WAIT = 1'b0;

        // set arbitrary values to inputs
        INSTRUCTION = 32'd10;
        PC_INCREMENT4 = 32'd20;

        $dumpfile("pipeline1_tb.vcd");
        $dumpvars(0, pipeline1_tb);

        //testing for RESET

        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;
		
        `assert(INSTRUCTION_OUT, 32'd0);
        `assert(PC_INCREMENT4_OUT, -32'd4);

        $display("TEST 01 : RESET  Passed!");

        //ebf of test1 1

        //test for write on pipeline regidter
        #1
        BUSY_WAIT = 1'b0;

        INSTRUCTION = 32'd16;
        PC_INCREMENT4 = 32'd25;
 
        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(INSTRUCTION_OUT, 32'd16);
            `assert(PC_INCREMENT4_OUT, 32'd25);

            $display("TEST 02 : BUSYWAIT 0 TEST Passed!");

        end

        //end of test 2
        
        //test for bussywait
        
        // set BUSYWAIT to 1
        #1
        BUSY_WAIT = 1'b1;

        INSTRUCTION = 32'd3;
        PC_INCREMENT4 = 32'd80;

        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(INSTRUCTION_OUT, 32'd16);
            `assert(PC_INCREMENT4_OUT, 32'd25);

            $display("Test 03 : BUSYWAIT 1 TEST Passed!");

        end

        //end of test 3

        #100
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule
