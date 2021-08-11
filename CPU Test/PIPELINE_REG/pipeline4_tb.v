//Test Bench for pipeline2
`include "../assert.v" 
`include "pipeline4.v"
`timescale 1ns/100ps

module pipeline4_tb;
	reg CLK, RESET, BUSY_WAIT, REG_WRITE;
	reg [1:0] MEM_TO_REG;
	reg [2:0] MEM_READ;
	reg [4:0] IN_ADDRESS;
	reg [31:0] ALU_RESULT, DATA_READED, PC_NEXT;
	
	wire REG_WRITE_OUT;
	wire [1:0] MEM_TO_REG_OUT;
	wire [2:0] MEM_READ_OUT;
	wire [4:0] IN_ADDRESS_OUT;
	wire [31:0] ALU_RESULT_OUT, DATA_READED_OUT, PC_NEXT_OUT;
	
	pipeline4 my_pipeline4(CLK, RESET, BUSY_WAIT,REG_WRITE, MEM_READ, MEM_TO_REG, ALU_RESULT, DATA_READED, IN_ADDRESS, PC_NEXT, 
			REG_WRITE_OUT, MEM_READ_OUT, MEM_TO_REG_OUT, ALU_RESULT_OUT, DATA_READED_OUT, IN_ADDRESS_OUT, PC_NEXT_OUT);
				
	initial begin
		CLK = 1'b0;
        RESET = 1'b0;
        BUSY_WAIT = 1'b0;
		
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		MEM_READ = 3'd3;
		ALU_RESULT = 32'd10;
		DATA_READED = 32'd12;
		PC_NEXT = 32'd10;
		IN_ADDRESS = 5'd4;
		
		$dumpfile("pipeline4_tb.vcd");
        $dumpvars(0, pipeline4_tb);
		
		#1
        RESET = 1'b1;

        #5
        RESET = 1'b0;
		
		//test 1 : reset
		
		`assert(REG_WRITE_OUT,0);
		`assert(MEM_TO_REG_OUT, 0);
		`assert(MEM_READ_OUT,0);
		`assert(ALU_RESULT_OUT, 0);
		`assert(DATA_READED_OUT, 0);
        `assert(PC_NEXT_OUT, 0);
		`assert(IN_ADDRESS_OUT,0);
		
        $display("TEST 01 : RESET  Passed!");
		
		//test 1 finished
		
		 //test for write on pipeline regidter
        #1
        BUSY_WAIT = 1'b0;

        REG_WRITE = 1;
		MEM_TO_REG = 2'd3;
		MEM_READ = 3'd3;
		ALU_RESULT = 32'd11;
		DATA_READED = 32'd22;
		PC_NEXT = 32'd10;
		IN_ADDRESS = 5'd4;
 
        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(REG_WRITE_OUT,1);
			`assert(MEM_TO_REG_OUT, 3);
			`assert(MEM_READ_OUT,3);
			`assert(ALU_RESULT_OUT, 11);
			`assert(DATA_READED_OUT, 22);
			`assert(PC_NEXT_OUT, 10);
			`assert(IN_ADDRESS_OUT,4);

            $display("TEST 02 : BUSYWAIT 0 TEST Passed!");

        end

        //end of test 2
		
		//test for bussywait
        
        // set BUSYWAIT to 1
        #1
        BUSY_WAIT = 1'b1;

        REG_WRITE = 1;
		MEM_TO_REG = 2'd3;
		MEM_READ = 3'd3;
		ALU_RESULT = 32'd21;
		DATA_READED = 32'd32;
		PC_NEXT = 32'd10;
		IN_ADDRESS = 5'd4;
        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(REG_WRITE_OUT,1);
			`assert(MEM_TO_REG_OUT, 3);
			`assert(MEM_READ_OUT,3);
			`assert(ALU_RESULT_OUT, 11);
			`assert(DATA_READED_OUT, 22);
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