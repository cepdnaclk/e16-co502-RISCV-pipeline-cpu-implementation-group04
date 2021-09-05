`include "cpu.v"
`include "../DATA_MEMORY_CACHE/dcache.v"
`include "../DATA_MEMORY/dmem.v"
`include "../INS_MEMORY_CACHE/icache.v"
`include "../INS_MEMORY/imem.v"


`timescale 1ns/100ps

module cpu_tb;
    
    //declare the inputs & output
    reg CLK, RESET;
    wire [31:0] PC,M_READDATAm,M_WRITEDATA,M_ADDRESS,M_READDATA;
    wire [31:0] INSTRUCTIONS;
    wire BUSYWAIT, READ, WRITE, MEM_READ, MEM_WRITE, M_BUSYWAIT, I_BUSYWAIT, IMEM_READ,ICACHE_BUSYWAIT, DCACH_BUSYWAIT,I_inter_BUSYWAIT,M_inter_BUSYWAIT;
    wire [31:0] MEM_ADDRESS;
    wire [7:0] READDATA, WRITEDATA, ADDRESS;
    wire [127:0] MEM_WRITEDATA, MEM_READDATA;
    wire [127:0] IMEM_READDATA;
    wire [27:0] IMEM_ADDRESS;
    
    
   // assign BUSYWAIT = ICACHE_BUSYWAIT | DCACHE_BUSYWAIT;
	
    //cpu mycpu(PC, READ, WRITE, READDATA, WRITEDATA, ADDRESS, BUSYWAIT, INSTRUCTION, CLK, RESET);
	cpu cpu1(CLK,RESET,INSTRUCTIONS,I_BUSYWAIT,M_READDATA,M_BUSYWAIT,PC,M_WRITEDATA,M_ADDRESS,READ,WRITE);
	
    //instruction_cache my_icache(CLK, RESET, PC[9:0], INSTRUCTION, ICACHE_BUSYWAIT, IMEM_BUSYWAIT, IMEM_READ, IMEM_READDATA, IMEM_ADDRESS);
	instruction_cache instruction_cache1(CLK, RESET, PC, INSTRUCTIONS, I_BUSYWAIT, I_inter_BUSYWAIT, IMEM_READ, IMEM_READDATA, IMEM_ADDRESS);
	
    //instruction_memory my_imem(CLK, IMEM_READ, IMEM_ADDRESS, IMEM_READDATA, IMEM_BUSYWAIT);
	instruction_memory instruction_memory1(CLK,IMEM_READ ,IMEM_ADDRESS,IMEM_READDATA,I_inter_BUSYWAIT);
	
    //dcache mydcache(CLK, RESET, READ, WRITE, ADDRESS, READDATA, WRITEDATA, DCACHE_BUSYWAIT, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READDATA, MEM_BUSYWAIT);
	dcache dcache1( CLK, RESET,  READ,  WRITE,  M_ADDRESS,   M_READDATA,  M_WRITEDATA, M_BUSYWAIT,  MEM_READ,   MEM_WRITE,  MEM_ADDRESS,  MEM_WRITEDATA, MEM_READDATA,  M_inter_BUSYWAIT );
    
	
    //data_memory mydm(CLK, RESET, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READDATA, M_inter_BUSYWAIT);
	data_memory data_memory1(CLK, RESET,  MEM_READ, MEM_WRITE, MEM_ADDRESS,MEM_WRITEDATA,MEM_READDATA,M_inter_BUSYWAIT);
    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
        $dumpvars(0, cpu_tb);
        
        CLK = 1'b1;
        RESET = 1'b0;
        //Reset the CPU (by giving a pulse to RESET signal) to start the program execution
        #2 RESET = 1'b1;
        #4 RESET = 1'b0;
            
        // finish simulation after some time
        #2200
        $finish;
        
    end
    
    
    // clock signal generation
    always
        #4 CLK = ~CLK;
        

endmodule    







//cpu cpu1(PC,INSTRUCTION,CLK,RESET,cpu_readdata,busywait,cpu_writedata,cpu_address,cpu_read,cpu_write);