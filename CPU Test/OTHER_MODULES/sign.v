//sign extention
module sign(SIGNIN,IMMI_SEL,SIGNOUT);
//port declaration
input [31:0] SIGNIN;
input [2:0] IMMI_SEL;
output reg [31:0] SIGNOUT;
reg [31:0] SIGNHOLD;
reg [11:0] OFFSET;

always @(SIGNIN,IMMI_SEL) begin 


	if(IMMI_SEL == 3'b000) begin//i type**************************************************************
	#1
		if(SIGNIN[31]==1'b0) begin   //for positive in
			SIGNHOLD = {21'b00000000_00000000_00000,SIGNIN[31:20]};
		end
		if (SIGNIN[12]== 1'b1) begin  //for negative in
			SIGNHOLD[30:20] =~SIGNIN[30:20];
			
			SIGNHOLD = {1'b1,20'b11111111_11111111_11,SIGNHOLD[30:20]};
			SIGNHOLD = SIGNHOLD+ 1;
			
		end
		SIGNOUT   = SIGNHOLD ; //out the 2s complement
	end

	if(IMMI_SEL == 3'b001) begin//i shift type type******************************************************
	#1
		if(SIGNIN[24]==1'b0) begin   //for positive in
			SIGNHOLD = {27'b00000000_00000000_00000000_000,SIGNIN[24:20]};
		end
		if (SIGNIN[24]== 1'b1) begin  //for negative in
			SIGNHOLD[23:20] =~SIGNIN[23:20];
			
			SIGNHOLD = {1'b1,26'b11111111_11111111_11111111_11,SIGNHOLD[23:20]};
			SIGNHOLD = SIGNHOLD+ 1;
			
		end
		SIGNOUT   = SIGNHOLD;  //out the 2s complement
	end

	if(IMMI_SEL == 3'b010) begin//Branch type and store type**********************************************************************
	#1
		OFFSET = {SIGNIN[31:25],SIGNIN[11:7]};
		
		if(OFFSET[11]==1'b0) begin   //for positive in
			SIGNHOLD = {20'b00000000_00000000_0000,OFFSET[11:0]};
		end
		if (OFFSET[11]== 1'b1) begin  //for negative in
			OFFSET[10:0] =~OFFSET[10:0];
			
			SIGNHOLD = {1'b1,20'b11111111_11111111_1111,OFFSET[10:0]};
			SIGNHOLD = SIGNHOLD+ 1;
			
		end
		SIGNOUT   = SIGNHOLD; //out the 2s complement
	end
	
	
end	

endmodule

