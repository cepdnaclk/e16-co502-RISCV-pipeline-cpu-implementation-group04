`timescale 1ns/100ps 
module instruction_cache(clock, reset, pc, instruction, busywait, mem_busywait, mem_read, mem_readdata, mem_address);
  
  input clock, reset, mem_busywait;
  input [31:0] pc;
  input [127:0] mem_readdata;
  output reg busywait, mem_read;
  output reg [27:0] mem_address;
  output reg [31:0] instruction;
   
  //take the cache table to the 2 demensional registor
   reg [131:0] cache_memory[0:7]; //cache table
   reg hit, valid;
   reg [2:0] tag, index;
   reg [1:0] offset;
   reg [127:0] data;
   reg [2:0] cache_tag;
   reg tagout;
   reg read;
   
   //check the pc is -4.
   //if pc is not -4, enter to the reading of instruction part
   //and decode the address(pc)
   always @(pc) begin
     if (pc != -4 ) begin
      // busywait = 1; 
       read = 1;
       offset = pc[3:2];
       index = pc[6:4];
       tag =  pc[31:7];
     end 
   end
   
   //if pc is -4, down the busywait
   always @(*) begin
     if (pc == -4 ) begin
       busywait = 0; 
       read = 0;
     end 
   end


    //tag comparision and check the hit or miss
      
   always @(*) begin
     if (read) begin
       #1
      valid = cache_memory[index][131]; 
      cache_tag = cache_memory[index][130:128];
      data = cache_memory[index][127:0];
       
       //tag comparison 
      if(tag == cache_tag) begin
        tagout = #1 1'b1;  
      end
      else begin
        tagout = #1 1'b0;  
      end 
       //select the hit or not
      if(tagout && valid) begin
         hit = 1;  
      end
      else begin
         hit = 0; 
      end  
      //read the instruction
      if (read) begin
        if (hit && !mem_busywait)
		begin
       
        case (offset) 
            2'b00: instruction = cache_memory[index][31:0];
            2'b01: instruction = cache_memory[index][63:32];
            2'b10: instruction = cache_memory[index][95:64];
            2'b11: instruction = cache_memory[index][127:96];
        endcase  
       end
      end 
    
   end  
     end 
      
    
   //if it is read miss, go to the instruction memory    
   always @(*) begin
     if (read) begin
       if (!hit ) begin
        busywait = 1'b1;
        mem_address = {tag, index};
        mem_read = 1'b1;               
      end
     end
   end
  
   //update the instruction cache table 
   always @(mem_busywait) begin
     if (!mem_busywait) begin
        mem_read = 0;
        mem_address = 28'dx;       
        cache_tag = tag;
        data = mem_readdata;
        valid = 1'b1;
        cache_memory[index] = {valid, cache_tag, data};
     end
   end

   //if it is hit down the busywait of instruction cache
   always @(posedge clock) begin

      if(hit && read) begin
        busywait = 1'b0;
        read = 0;
      end 
       
   end 

    /* Cache Controller FSM End */
   integer i;
   always @(posedge reset) begin
      if(reset) begin
          valid = 0;
          for(i=0; i<8; i=i+1) begin        
              cache_memory[i] = 0;
          end 
      end
   end

endmodule