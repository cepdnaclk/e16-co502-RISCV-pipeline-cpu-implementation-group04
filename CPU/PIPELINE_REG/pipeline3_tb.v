//Test Bench for pipeline3
`include "../assert.v" 
`include "pipeline3.v"
`timescale 1ns/100ps

module pipeline3_tb;
	reg CLK, RESET, BUSY_WAIT, BRANCH_RES,REG_DEST, REG_WRITE;
	reg [2:0] MEM_READ,MEM_WRITE;
	reg [1:0] MEM_TO_REG;
	reg [4:0] IN_ADDRESS;
	reg [31:0] ALU_RESULT, OUT2, PC_NEXT;
	
	wire BRANCH_RES_OUT,REG_DEST_OUT, REG_WRITE_OUT;
	wire [2:0] MEM_READ_OUT,MEM_WRITE_OUT;
	wire [1:0] MEM_TO_REG_OUT;
	wire [4:0] IN_ADDRESS_OUT;
	wire [31:0] ALU_RESULT_OUT, OUT2_OUT, PC_NEXT_OUT;
	
	pipeline3 my_pipeline3(CLK, RESET, BUSY_WAIT,REG_DEST,REG_WRITE, MEM_READ, MEM_TO_REG, MEM_WRITE, BRANCH_RES, ALU_RESULT, OUT2, IN_ADDRESS, PC_NEXT,
				BRANCH_RES_OUT, REG_DEST_OUT, REG_WRITE_OUT, MEM_READ_OUT,MEM_WRITE_OUT, MEM_TO_REG_OUT, IN_ADDRESS_OUT, ALU_RESULT_OUT, OUT2_OUT, PC_NEXT_OUT);
				
	initial begin
		CLK = 1'b0;
        RESET = 1'b0;
        BUSY_WAIT = 1'b0;
		
		BRANCH_RES = 1;
		REG_DEST = 1;
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		MEM_READ = 3'd3;
		MEM_WRITE = 3'd4;
		ALU_RESULT = 32'd10;
		OUT2 = 32'd12;
		PC_NEXT = 32'd10;
		IN_ADDRESS = 5'd4;
		
		$dumpfile("pipeline3_tb.vcd");
        $dumpvars(0, pipeline3_tb);
		
		#1
        RESET = 1'b1;

        #5
        RESET = 1'b0;
		
		//test 1 : reset
		
		`assert(BRANCH_RES_OUT,0);
		`assert(REG_DEST_OUT, 0);
		`assert(REG_WRITE_OUT, 0);
		`assert(MEM_TO_REG_OUT, 0);
		`assert(MEM_READ_OUT,0);
		`assert(MEM_WRITE_OUT, 0);
		`assert(ALU_RESULT_OUT, 0);
		`assert(OUT2_OUT, 0);
        `assert(PC_NEXT_OUT, 0);
		`assert(IN_ADDRESS_OUT,0);
		
        $display("TEST 01 : RESET  Passed!");
		
		//test 1 finished
		
		 //test for write on pipeline regidter
        #1
        BUSY_WAIT = 1'b0;

        BRANCH_RES = 1;
		REG_DEST = 1;
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		MEM_READ = 3'd3;
		MEM_WRITE = 3'd4;
		ALU_RESULT = 32'd56;
		OUT2 = 32'd42;
		PC_NEXT = 32'd10;
		IN_ADDRESS = 5'd4;
 
        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(BRANCH_RES_OUT,1);
			`assert(REG_DEST_OUT, 1);
			`assert(REG_WRITE_OUT, 1);
			`assert(MEM_TO_REG_OUT, 1);
			`assert(MEM_READ_OUT,3);
			`assert(MEM_WRITE_OUT, 4);
			`assert(ALU_RESULT_OUT, 56);
			`assert(OUT2_OUT, 42);
			`assert(PC_NEXT_OUT, 10);
			`assert(IN_ADDRESS_OUT,4);

            $display("TEST 02 : BUSYWAIT 0 TEST Passed!");

        end

        //end of test 2
		
		//test for bussywait
        
        // set BUSYWAIT to 1
        #1
        BUSY_WAIT = 1'b1;

        BRANCH_RES = 1;
		REG_DEST = 1;
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		MEM_READ = 3'd2;
		MEM_WRITE = 3'd4;
		ALU_RESULT = 32'd6;
		OUT2 = 32'd42;
		PC_NEXT = 32'd8;
		IN_ADDRESS = 5'd4;
        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(BRANCH_RES_OUT,1);
			`assert(REG_DEST_OUT, 1);
			`assert(REG_WRITE_OUT, 1);
			`assert(MEM_TO_REG_OUT, 1);
			`assert(MEM_READ_OUT,3);
			`assert(MEM_WRITE_OUT, 4);
			`assert(ALU_RESULT_OUT, 56);
			`assert(OUT2_OUT, 42);
			`assert(PC_NEXT_OUT, 10);
			`assert(IN_ADDRESS_OUT,4);

            $display("Test 03 : BUSYWAIT 1 TEST Passed!");

        end
		
		#100
        $finish;
		
	end
	 // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end
endmodule