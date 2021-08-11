//Test Bench for pipeline2
`include "../assert.v" 
`include "pipeline2.v"
`timescale 1ns/100ps

module pipeline2_tb;
	reg CLK, RESET, BRANCH,REG_DEST, REG_WRITE, BUSY_WAIT;
	reg [1:0] MEM_TO_REG,ALU_SOURCE;
	reg [2:0] MEM_READ,MEM_WRITE,IMMI_SEL;
	reg [4:0] ALU_OP,RD1, RD2;
	reg [31:0] OUT1, OUT2, PC_INCREMENT4, SIGN_EXTENDED;
	
	wire BRANCH_OUT,REG_DEST_OUT, REG_WRITE_OUT;
	wire [1:0] MEM_TO_REG_OUT,ALU_SOURCE_OUT;
	wire [2:0] MEM_READ_OUT,MEM_WRITE_OUT,IMMI_SEL_OUT;
	wire [4:0] ALU_OP_OUT,RD1_OUT,RD2_OUT;
	wire [31:0] OUT1_OUT, OUT2_OUT, PC_INCREMENT4_OUT, SIGN_EXTENDED_OUT;
	
	pipeline2 my_pipeline2(CLK, RESET, BRANCH, REG_DEST, REG_WRITE, MEM_TO_REG,ALU_SOURCE,MEM_READ,MEM_WRITE,IMMI_SEL, ALU_OP, OUT1, OUT2, PC_INCREMENT4,SIGN_EXTENDED, RD1, RD2, BUSY_WAIT,
	BRANCH_OUT,REG_DEST_OUT, REG_WRITE_OUT, MEM_TO_REG_OUT,ALU_SOURCE_OUT,MEM_READ_OUT,MEM_WRITE_OUT,IMMI_SEL_OUT,ALU_OP_OUT,OUT1_OUT, OUT2_OUT, PC_INCREMENT4_OUT, SIGN_EXTENDED_OUT, RD1_OUT, RD2_OUT);
	
	initial begin
		CLK = 1'b0;
        RESET = 1'b0;
        BUSY_WAIT = 1'b0;
		
		BRANCH = 1;
		REG_DEST = 1;
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		ALU_SOURCE = 2'd2;
		MEM_READ = 3'd3;
		MEM_WRITE = 3'd4;
		IMMI_SEL = 3'd2;
		ALU_OP = 5'd4;
		OUT1 = 32'd10;
		OUT2 = 32'd12;
		PC_INCREMENT4 = 32'd10;
		SIGN_EXTENDED = 32'd15;
		RD1 = 5'd5;
		RD2 = 5'd6;
		
		$dumpfile("pipeline2_tb.vcd");
        $dumpvars(0, pipeline2_tb);
		
		#1
        RESET = 1'b1;

        #5
        RESET = 1'b0;
		
		//test 1 : reset
		
		`assert(BRANCH_OUT,0);
		`assert(REG_DEST_OUT, 0);
		`assert(REG_WRITE_OUT, 0);
		`assert(MEM_TO_REG_OUT, 0);
		`assert(ALU_SOURCE_OUT,0);
		`assert(MEM_READ_OUT,0);
		`assert(MEM_WRITE_OUT, 0);
		`assert(IMMI_SEL_OUT, 0);
		`assert(ALU_OP_OUT,0);
		`assert(OUT1_OUT, 0);
		`assert(OUT2_OUT, 0);
        `assert(PC_INCREMENT4_OUT, -32'd4);
		`assert(SIGN_EXTENDED_OUT,0);
		`assert(RD1_OUT,0);
		`assert(RD2_OUT,0);
		
        $display("TEST 01 : RESET  Passed!");
		
		//test 1 finished
		
		 //test for write on pipeline regidter
        #1
        BUSY_WAIT = 1'b0;

        BRANCH = 1;
		REG_DEST = 0;
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		ALU_SOURCE = 2'd2;
		MEM_READ = 3'd3;
		MEM_WRITE = 3'd4;
		IMMI_SEL = 3'd2;
		ALU_OP = 5'd4;
		OUT1 = 32'd10;
		OUT2 = 32'd12;
		PC_INCREMENT4 = 32'd10;
		SIGN_EXTENDED = 32'd15;
		RD1 = 5'd5;
		RD2 = 5'd8;
 
        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(BRANCH_OUT,1);
			`assert(REG_DEST_OUT, 0);
			`assert(REG_WRITE_OUT, 1);
			`assert(MEM_TO_REG_OUT, 1);
			`assert(ALU_SOURCE_OUT,2);
			`assert(MEM_READ_OUT,3);
			`assert(MEM_WRITE_OUT, 4);
			`assert(IMMI_SEL_OUT, 2);
			`assert(ALU_OP_OUT,4);
			`assert(OUT1_OUT, 10);
			`assert(OUT2_OUT, 12);
			`assert(PC_INCREMENT4_OUT, 32'd10);
			`assert(SIGN_EXTENDED_OUT,15);
			`assert(RD1_OUT,5);
			`assert(RD2_OUT,8);

            $display("TEST 02 : BUSYWAIT 0 TEST Passed!");

        end

        //end of test 2
		
		//test for bussywait
        
        // set BUSYWAIT to 1
        #1
        BUSY_WAIT = 1'b1;

        BRANCH = 1;
		REG_DEST = 0;
		REG_WRITE = 1;
		MEM_TO_REG = 2'd1;
		ALU_SOURCE = 2'd3;
		MEM_READ = 3'd3;
		MEM_WRITE = 3'd4;
		IMMI_SEL = 3'd2;
		ALU_OP = 5'd4;
		OUT1 = 32'd14;
		OUT2 = 32'd17;
		PC_INCREMENT4 = 32'd10;
		SIGN_EXTENDED = 32'd15;
		RD1 = 5'd5;
		RD2 = 5'd8;

        @(posedge CLK) begin
            
            // wait for write to happen.
            #2

            `assert(BRANCH_OUT,1);
			`assert(REG_DEST_OUT, 0);
			`assert(REG_WRITE_OUT, 1);
			`assert(MEM_TO_REG_OUT, 1);
			`assert(ALU_SOURCE_OUT,2);
			`assert(MEM_READ_OUT,3);
			`assert(MEM_WRITE_OUT, 4);
			`assert(IMMI_SEL_OUT, 2);
			`assert(ALU_OP_OUT,4);
			`assert(OUT1_OUT, 10);
			`assert(OUT2_OUT, 12);
			`assert(PC_INCREMENT4_OUT, 32'd10);
			`assert(SIGN_EXTENDED_OUT,15);
			`assert(RD1_OUT,5);
			`assert(RD2_OUT,8);

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