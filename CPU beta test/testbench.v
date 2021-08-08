
module cpu_tb;
    
    //declare the inputs & output
    reg CLK, RESET;
    wire [31:0] PC;
    reg [31:0] INSTRUCTION;
    
    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */
    
    // Initialize an array of registers (8x1024) to be used as instruction memory
    reg [7:0] INS_MEM[0:1023];
      // Create combinational logic to fetch an instruction from instruction memory, given the Program Counter(PC) value 
      //(make sure you include the delay for instruction fetching here)
    always @(PC) begin
      // instruction fetching and 2 sec delay 
      #2  INSTRUCTION = {INS_MEM[PC+3], INS_MEM[PC+2], INS_MEM[PC+1], INS_MEM[PC]};  
    end
    
  
    initial begin
        // Initialize instruction memory with a set of instructions
        
        {INS_MEM[10'd3],  INS_MEM[10'd2],  INS_MEM[10'd1],  INS_MEM[10'd0]} = 32'b00001000000000010000000000010000;  //loadi 1 0x10
        {INS_MEM[10'd7],  INS_MEM[10'd6],  INS_MEM[10'd5],  INS_MEM[10'd4]} = 32'b00001000000000100000000000010000;  //loadi 2 0x10
        {INS_MEM[10'd11], INS_MEM[10'd10], INS_MEM[10'd9],  INS_MEM[10'd8]} = 32'b00000110000000100000000000000000;  //j 0x02
        {INS_MEM[10'd15], INS_MEM[10'd14], INS_MEM[10'd13], INS_MEM[10'd12]}= 32'b00000000000000010000000000000011;  //mov 1 3
        {INS_MEM[10'd19], INS_MEM[10'd18], INS_MEM[10'd17], INS_MEM[10'd16]}= 32'b00001001000001000000010000000001;  //sub 4 4 1
        {INS_MEM[10'd23], INS_MEM[10'd22], INS_MEM[10'd21], INS_MEM[10'd20]}= 32'b00000001000000110000000100000010;  //add 3 1 2
        {INS_MEM[10'd27], INS_MEM[10'd26], INS_MEM[10'd25], INS_MEM[10'd24]}= 32'b00000111111111000000000100000010;  //beq 0x02 1 2

    end
    
   
    cpu mycpu(PC, INSTRUCTION, CLK, RESET);

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
        #100
        $finish;
        
    end
    
    
    // clock signal generation
    always
        #5 CLK = ~CLK;
        

endmodule