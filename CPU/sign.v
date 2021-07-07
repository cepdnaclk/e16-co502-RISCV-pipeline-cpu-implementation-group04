//sign extention
module sign(SIGNIN,SIGNOUT);
//port declaration
input [12:0] SIGNIN;
output reg [31:0] SIGNOUT;
reg [11:0] SIGNHOLD;

always @(SIGNIN) begin 
	if(SIGNIN[12]==1'b0) begin   //for positive in
		SIGNOUT = {11'b00000000_00000000_000,SIGNIN};
	end
	if (SIGNIN[12]== 1'b1) begin  //for negative in
		SIGNHOLD[11:0] =~SIGNIN[11:0];
		
		
		SIGNOUT = {1'b1,20'b11111111_11111111_111,SIGNHOLD[11:0]};
		
	end
	SIGNOUT   = SIGNOUT + 1 ;  //out the 2s complement
end

endmodule































