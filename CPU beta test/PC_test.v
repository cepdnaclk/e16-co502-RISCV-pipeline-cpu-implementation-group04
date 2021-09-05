module PC_test;
	reg [31:0] BRANCH_PC;
	reg CLK,RESET,CON_BRANCH,BUSY_WAIT;
	//declaring output
	wire reg[31:0] PC,PC_4;
	


	//cteate alumodel for testing
	PC_UNIT PC_UNIT1(PC,PC_4,BRANCH_PC,CLK,RESET,CON_BRANCH,BUSY_WAIT);
	

	
	initial
	begin
		//generate files need to plot waveform using GTKWave
		$dumpfile("wavedata_cpu.vcd");
		$dumpvars(0,PC_test);
	end
	
	initial
	begin  
		//testing the forward answer 0100 0100
		#15
		RESET = 1'b1;
		CLK = 1'b1;
		CON_BRANCH = 0;
		#10
		RESET =1'b0;
		BUSY_WAIT = 0;
		
		#50
		BUSY_WAIT = 1;
		#20
		BUSY_WAIT = 0;
		
		
		#50
		BRANCH_PC = 100;
		CON_BRANCH = 1;
		#12
		BRANCH_PC = 100;
		CON_BRANCH = 0;
		#50
		
		$finish;
		
		
		
		
		
		
		end
		
		
	always begin
	 #5 CLK = ~CLK; //clk signal
	end
	
	
	
endmodule	
