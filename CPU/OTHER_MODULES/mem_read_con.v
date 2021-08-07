module MEM_READ_con(
   IN,
   OUT,
   CON,
   MEM_READ
   
);

input[31:0] IN;    
input[2:0] CON;
output reg [31:0]	OUT;
output reg MEM_READ;


//controlling the signals
always @(IN,CON)
begin
//controlling memory writing
	if(CON == 0)
	begin
		MEM_READ = 1'b0;
	end
	
	else if(CON ==1)
	begin
		MEM_READ = 1'b1;
		OUT = {24'b00000000_00000000_00000000,IN[7:0]};
	end
	
	
	else if(CON ==2)
	begin
		MEM_READ = 1'b1;
		OUT = {16'b00000000_00000000,IN[15:0]};
	end
	
	else if(CON ==3)
	begin
		MEM_READ = 1'b1;
		OUT = IN[31:0];
	end
	
	else if(CON ==4)
	begin
		MEM_READ = 1'b1;
		OUT = {24'b00000000_00000000_00000000,IN[7:0]};
	end
	
	
	else if(CON ==5)
	begin
		MEM_READ = 1'b1;
		OUT = {16'b00000000_00000000,IN[15:0]};
	end
	
	
end


endmodule