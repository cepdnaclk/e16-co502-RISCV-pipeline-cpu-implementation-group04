  
`timescale 1ns/100ps
`include "../RISCV_CPU/cpu.v"

module cpu_testBench();
	/*TODO : add the input/outputs/wires , call the modules*/
	always
        #5 CLK = ~CLK;

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpuTestbench);
		
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
		 RESET = 1'b1;
		 #2
		  RESET = 1'b0;
		  #15
		  RESET = 1'b1;
		  #4
		   RESET = 1'b0;
        
        // finish simulation after some time
        #6000
        $finish;
        
    end
endmodule