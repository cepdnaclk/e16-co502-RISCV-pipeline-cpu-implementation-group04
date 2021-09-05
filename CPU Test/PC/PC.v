module PC_UNIT(PC,PC_4,BRANCH_PC,CLK,RESET,CON_BRANCH,BUSY_WAIT);
	//declaring inputs and outputs
	input [31:0] BRANCH_PC;
	input CLK,RESET,CON_BRANCH,BUSY_WAIT;
	
	output reg [31:0] PC;
	output reg [31:0] PC_4;
	//declaring wires
	
	reg [31:0] pc_hold;
	initial begin   //initial settings
		pc_hold = 32'b0;//initialy it is zero
		end
	always @(posedge CLK,posedge RESET) begin
		#1
		if(RESET == 1'b0  && BUSY_WAIT ==1'b0 )begin  //normal mood
			pc_hold = pc_hold + 4; 
		end
		
		if(RESET == 1'b0 && CON_BRANCH == 1'b1 && BUSY_WAIT ==1'b0) begin
			pc_hold = pc_hold + BRANCH_PC;
		
		end
		
		if(RESET == 1'b1) begin //if the reset happen
		pc_hold = -4; 
		end
		
		#1   //delay to update the pc 
		PC = pc_hold;
		PC_4 = pc_hold + 4;
	end
	


endmodule