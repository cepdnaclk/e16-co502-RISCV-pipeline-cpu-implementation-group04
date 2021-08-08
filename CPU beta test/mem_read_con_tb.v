module memcon_test;
	
	
	reg[31:0] IN;    
	reg[2:0] CON;
	wire reg [31:0]	OUT;
	wire reg MEM_READ;


	
	MEM_READ_con MEM_READ_con1(IN,OUT,CON,MEM_READ);
	
	initial
	begin
		//generate files need to plot waveform using GTKWave
		$dumpfile("wavedata_cpu.vcd");
		$dumpvars(0,memcon_test);
	end
	
	initial
	begin  
		//testing the forward answer 0100 0100
		#15
		CON = 0;
		#10
		CON = 1;
		IN = 32'b 00000000_00000000_11001100_01100110;
		
		#50
		CON = 2;
		IN = 32'b 00000000_00000000_11001100_01100110;
		
		#20
		CON = 3;
		IN = 32'b 00000000_00000000_11001100_01100110;
		
		
		#50
		CON = 4;
		IN = 32'b 00000000_00000000_11001100_01100110;
		#12
		CON = 5;
		IN = 32'b 00000000_00000000_11001100_01100110;
		#50
		
		$finish;
		
		
		end
		
		
	
	
	
endmodule	
