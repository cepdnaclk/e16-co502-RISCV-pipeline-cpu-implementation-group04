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
			RES_MULH,	//multiplication higer signed * signed
			RES_MULHU,	//multiplication higher unsigned * unsigned
			RES_MULHSU,	//mul higher signed * unsigned
			RES_DIV,	//Divition
			RES_REM,	//Remainder
			RES_SLT,	//Less than
			RES_SLTU	//less thank unsigned
			;
	
	//AND,OR,XOR operations with 1 time unit delay
	//these are bitwise operations
	assign #1 RES_AND = DATA1 & DATA2;
	assign #1 RES_OR  = DATA1 | DATA2;
	assign #1 RES_XOR = DATA1 ^ DATA2;
	
	//forwad operation
	assign #1 RES_FWD = DATA2;
	
	//ADD, SUB operations with 2 time unit delay
	assign #2 RES_ADD = DATA1+DATA2;
	assign #2 RES_SUB = DATA1-DATA2;
	
	//shift operations with 1 time unit delay
	assign #1 RES_SLL = DATA1 << DATA2;
	assign #1 RES_SRL = DATA1 >> DATA2;
	assign #1 RES_SRA = DATA1 >>> DATA2;

	//multiplication and divition operations
	assign #1 RES_MUL = DATA1 * DATA2;
	assign #1 RES_MULH =  $signed(DATA1) * $signed(DATA2);
	assign #1 RES_MULHSU = $signed(DATA1) * $unsigned(DATA2);
	assign #1 RES_MULHU = $unsigned(DATA1) * $unsigned(DATA2);	
	assign #1 RES_DIV = DATA1 / DATA2;
	
	//Remainder operaion
	assign #1 RES_REM = DATA1 % DATA2;
	
	//less than operation
	assign #1 RES_SLT = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;
	assign #1 RES_SLTU = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;
	
	
	//reg BEQ;
	always @ (DATA1,DATA2,SELECT)		//done it whe there is a change in values and do the operation with 1 time interval delay
	begin #1
    	case(SELECT)

    	//0. ADD operation 
    	5'b00000:  #1 RESULT = RES_ADD; 
    	//1. SLL operation - Shift Left Logic
    	5'b00001:  RESULT = RES_SLL;
    	//2. set les than
    	5'b00010:  RESULT = RES_SLT;
    	//3. set less than unsigned
    	5'b00011:  RESULT = RES_SLTU;
    	//4. XOR
    	5'b00100: #1 RESULT = RES_XOR; 
    	//5. Shift Right Logic
    	5'b00101: RESULT = RES_SRL;
    	//6. OR
    	5'b00110: #1 RESULT = RES_OR; 
    	//7. AND
    	5'b00111: #1 RESULT = RES_AND;
    	//8. Forwad
    	5'b01000: RESULT = RES_FWD;
		//9
		5'b01001: RESULT = 0;
		//10
		5'b01010: RESULT = 0;
		//11
		5'b01011: RESULT = 0;
		//12
		5'b01100: RESULT = 0;
		//13. 
		5'b01101: RESULT = 0;
		//14
		5'b01110: RESULT = 0;
		//15
		5'b01111: RESULT = 0;
		//16. Subtract
		5'b10000: #1 RESULT = RES_SUB;
		//17. 
		5'b10001: RESULT = 0;
		//18. 
		5'b10010: RESULT = 0;
		//19. 
		5'b10011: RESULT = 0;
		//20. 
		5'b10100: RESULT = 0;
		//21. SRA = Shift right arithmaic
		5'b10101: RESULT = RES_SRA;
		//22. 
		5'b10110: RESULT = 0;
		//23. 
		5'b10111: RESULT = 0;
		//24. Multiplication
		5'b11000: RESULT = RES_MUL;
		//25. Multiplication high signed
		5'b11001: RESULT = RES_MULH;
		//26. Multiplication high signed * unsigned
		5'b11010: RESULT = RES_MULHSU;
		//27. Multiplication high unsigned
		5'b11011: RESULT = RES_MULHU;
		//28. DIV DIvition
		5'b11100: RESULT = RES_DIV;
		//29. REM Remainder
		5'b11101: RESULT = RES_REM;
		//30. 
		5'b11110: RESULT = 0;
		//31. 
		5'b11111: RESULT = 0;
        default: 
            RESULT = 0; 
        endcase
    end
endmodule
