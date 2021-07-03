
`timescale 1ns/100ps
//alu module for RISCV procr
//
module alu(DATA1, DATA2, RESULT,SELECT);			
	input [31:0]DATA1;						//input of Data 1 value
	input [31:0]DATA2;						//input of data 2 value
	input [4:0]SELECT;						//alu opecode
	output reg [31:0]RESULT;					//output for result fot the operation
	//output RESULT1;
	//output BEQ;
	
	//alu results
	wire[31:0] 	RES_AND,	// 1. and
				RES_OR,		// 2. or
				RES_XOR,	// 3, xor
				RES_ADD,
				RES_SUB,
				RES_SLL,	//shift left logical
				RES_SRL,	//shift right logical
				RES_SRA,  	//shift right arithmatic
				RES_FWD,	//forward
				RES_MUL,	//multiplication
				RES_DIV,	//Divition
				RES_REM,	//Remainder
				RES_SLT,	//Less than
				RES_SLTU,	//less thank unsigned
				;
	
	//AND,OR,XOR operations with 1 time unit delay
	//these are bitwise operations
	assign #1 RES_AND = DATA1 & DATA2;
	assign #1 RES_OR  = DATA1 | DATA2;
	assign #1 RES_XOR = DATA1 ^ DATA2;
	
	//forwad operation
	assign #1 RES_FWD = DATA@;
	
	//ADD, SUB operations with 2 time unit delay
	assign #2 RES_ADD = DATA1+DATA2;
	assign #2 RES_SUB = DATA1-DATA2;
	
	//shift operations with 1 time unit delay
	assign #1 RES_SLL = DATA1 << DATA2;
	assign #1 RES_SRL = DATA1 >> DATA2;
	assign #1 RES_SRA = DATA >>> DATA2;
	
	//multiplication and divition operations
	assign #1 RES_MUL = DATA1 * DATA2;
	assign #1 RES_DIV = DATA1 / DATA2;
	
	//Remainder operaion
	assign #1 RES_REM = DATA1 % DATA2;
	
	//less than operation
	assign #1 RES_SLT = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;
	assign #1 RES_SLTU = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;
	
	
	//reg BEQ;
	always @ (DATA1,DATA2)	#1	//done it whe there is a change in values and do the operation with 1 time interval delay
	begin
    case(ALU_cntrl)

    //0. ADD operation 
    5'b00000: 
        RESULT = RES_ADD; 
    //1. SUB operation
    5'b00001: 
        RESULT = RES_SUB;
    //2
    5'b00010: 
        RESULT = DATA1 + DATA2;
    //3
    5'b00011: 
        RESULT = DATA1 ^ DATA2;
    //4 
    5'b00100: 
        RESULT = DATA1 << DATA2; 
    //5
    5'b00101: 
        RESULT = DATA1 >> DATA2;
    //6
    5'b00110: 
        RESULT = DATA1 - DATA2; 
    //7
    5'b00111:
        RESULT = DATA1 <<< DATA2;
    //8
    5'b01000:
        RESULT = DATA1 * DATA2;
		//9
		5'b01001:
			RESULT = DATA1/DATA2;
		//10
		5'b01010:
			RESULT=($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;
		//11
		5'b01011:
			RESULT = 0;
		//12
		5'b01100:
			RESULT = 0;
		//13
		5'b01101:
			RESULT = 0;
		//14
		5'b01110:
			RESULT = 0;
		//15
		5'b01111:
			RESULT = 0;
		//16
		5'b11111:
			RESULT = 0;
        default: 
            RESULT = 0; 
        
        endcase
    end
endmodule
