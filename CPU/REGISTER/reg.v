module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITEENABLE, CLK, RESET);
	//port declaration 
	//create a  8 bit input port
	input [31:0] IN;
	//create 3 3bit input ports (address of the registers)
	input [4:0] INADDRESS , OUT1ADDRESS , OUT2ADDRESS;
	//create 3  1bit input ports 
	input WRITEENABLE, CLK, RESET;

	
	//create 2 8 bit output reg for hold the result
	output reg [31:0] OUT1 ,OUT2;
	reg [31:0] register[31:0];
	integer i,wflag;   //flag for write  regiter and counting variable i
	
	//***********************************************
	//when the rising edge at clock
	always @(posedge CLK)
	begin
		if(WRITEENABLE == 1'b1 & RESET == 1'b0 ) //if writtble is high,when reset is high does not write)
		begin
			wflag = 1;
			#2 register[INADDRESS] = IN;     //write data into inaddress aftert 2s delay
			
		end
		
	end

	always begin 
		
	@(posedge RESET) begin//when reset is high
			i =1; //i using as a flag to avoid reading the adress at this time
			#2  //time dealy for resetting registers
			for (i =0; i < 32 ;i = i + 1) begin
				register[i] = 32'd0;
			end
			  //i also used to read regiters after the reset
	end
	
		if(i==32)begin //after updating registers are reading
		#1 //time delay for reading (registers
		OUT1 = register[OUT1ADDRESS];	
		OUT2 = register[OUT2ADDRESS];
		
		end
	end
	
	always @(OUT1ADDRESS,OUT2ADDRESS) begin//when register address are updated registers are reading
	
		if(i != 1) begin  //if the reset happen at the same time does not run this
		#5 //time delay for reading (registers
		OUT1 = register[OUT1ADDRESS];	
		OUT2 = register[OUT2ADDRESS];
		end
	end			
endmodule