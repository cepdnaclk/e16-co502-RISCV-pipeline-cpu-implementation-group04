//sign extention
module sign(SIGNIN,SIGNOUT);
//port declaration
input [11:0] SIGNIN;
output reg [31:0] SIGNOUT;
reg [10:0] SIGNHOLD;

always @(SIGNIN) begin 
	if(SIGNIN[11]==1'b0) begin   //for positive in
		SIGNOUT = {11'b00000000_00000000_0000,SIGNIN};
	end
	if (SIGNIN[20]== 1'b1) begin  //for negative in
		SIGNIN[10:0] =~SIGNIN[10:0];
		SIGNHOLD = SIGNIN[10:0] ;
		
		SIGNOUT = {1'b1,20'b11111111_11111111_1111,SIGNHOLD[10:0]};
		
	end
	SIGNOUT   = SIGNOUT + 1 ;  //out the 2s complement
end

endmodule































