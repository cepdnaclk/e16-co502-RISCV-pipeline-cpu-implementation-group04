//module for alud
module alu(DATA1, DATA2, RESULT,SELECT,BEQ);			
	input [0:31]DATA1;
	input [0:31]DATA2;
	input [0:3]SELECT;						//inputs
	output [0:31]RESULT;						//out put result
	//output BEQ;

	reg [0:7]RESULT;
	//reg BEQ;
	always @ (DATA1,DATA2)	#1	//done it whe there is a change in values and do the operation with 1 time interval delay
	begin
        case(ALU_cntrl)
        
        //and 
        4'b0000: 
            RESULT = DATA1 & DATA2; 
        //or 
        4'b0001: 
            RESULT = DATA1 | DATA2;
        //DATA1dd
        4'b0010: 
            RESULT = DATA1 + DATA2;
        //xor
        4'b0011: 
            RESULT = DATA1 ^ DATA2;
        //sll 
        4'b0100: 
            RESULT = DATA1 << DATA2; 
        //srl need to implement
        4'b0101: 
            RESULT = DATA1 >> DATA2;
        //subtract
        4'b0110: 
            RESULT = DATA1 - DATA2;
        //sra need to implement
        4'b0111:
            RESULT = DATA1 <<< DATA2;
        
        //multiplication
        4'b1000:
            RESULT = DATA1 * DATA2;
	//divition
	4'b1001:
	    RESULT = DATA1/DATA2;
        default: 
            RESULT = 0; 
        
        endcase
    end
endmodule
