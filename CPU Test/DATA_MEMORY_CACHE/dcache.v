`timescale 1ns/100ps 
module dcache ( clock, 
	            reset, 
	            read, 
	            write, 
	            address, 
	            readdata, 
	            writedata, 
	            busywait, 
	            mem_read, 
	            mem_write, 
	            mem_address, 
	            mem_writedata, 
	            mem_readdata, 
	            mem_busywait );
    
    input clock, reset, read, write, mem_busywait;
    input [31:0] address, writedata;
    input [127:0] mem_readdata;
    output reg busywait, mem_write, mem_read;
    output reg [31:0] mem_address;
    output reg [127:0] mem_writedata;
    output reg [31:0] readdata;
    
    //take the cache table to the 2 demensional registor
    reg [156:0] cache_memory[0:7]; //cache table
    reg hit, dirty, valid;
    wire [2:0] index;
    wire [1:0] offset;
	wire [26:0] tag;
    reg [127:0] data;
    reg [26:0] cache_tag;
    reg tagout;
    
    //set the busywait of the cache memory
    always @(read, write) begin
        if(read || write) begin
            busywait = 1;
        end
        else begin
            busywait = 0;
        end
    end

    //Combinational part for indexing, tag comparison for hit deciding, etc.
    
    //decode the cpu address to tag, index and offset
    assign offset = address[1:0];
    assign index = address[4:2];
    assign tag = address[31:5];
      
    always @(*) begin
       #1
       valid = cache_memory[index][156]; 
       dirty = cache_memory[index][155];
       cache_tag = cache_memory[index][154:128];
       data = cache_memory[index][127:0];
       
       //tag comparison 
       if(tag == cache_tag) begin
         tagout =  1;  
       end
       else begin
         tagout =  0;  
       end 
       //select the hit or not
       if(tagout && valid) begin
         hit = 1;  
       end
       else begin
         hit = 0;  
       end  
     
    end
    
    //if it is reading hit, read the value from cache table 
    always @(*) begin 
        if(read && hit) begin    
         #4
         case (offset) 
            2'b00: readdata = data[31:0];
            2'b01: readdata = data[63:32];
            2'b10: readdata = data[95:64];
            2'b11: readdata = data[127:96];
         endcase         
       end
       
    end
    
    //if it is write hit, write to the cache table  
    always @(posedge clock) begin
        if (write && hit) begin
         #1
         dirty = 1'b1;  // set the dirty bit
         case (offset)
            2'b00:  data[31:0]  = writedata;
            2'b01: data[63:32] = writedata;
            2'b10: data[95:64] = writedata;
            2'b11: data[127:96] = writedata;
         endcase
         //update the cache table according to the index 
         cache_memory[index] = {valid, dirty, tag, data};
         
       end 
    end

    
    //if hit is enable, update the busywait of the cache
    //in the next clock cycle positive edge
    always @(posedge clock) begin

       if (hit) busywait = 1'b0;
       
    end 
    
    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001, MEM_WRITE=3'b010, CACHE_UPDATE = 3'b011;
    reg [2:0] state, next_state;
    
    // combinational next state logic
    // take the FSM for the specially write-miss and read-miss
    always @(*)
    begin
        case (state)
            IDLE:
                if ((read || write) && !dirty && !hit)  
                    next_state = MEM_READ;
                else if ((read || write) && dirty && !hit)
                    next_state = MEM_WRITE;
                else
                    next_state = IDLE;
            
            MEM_READ:
                if (!mem_busywait)
                    next_state = CACHE_UPDATE;
                else    
                    next_state = MEM_READ;
            
            MEM_WRITE:
               if(!mem_busywait)
               	   next_state = MEM_READ;
               else
               	   next_state = MEM_WRITE;
            
            CACHE_UPDATE:
               next_state = IDLE;

        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                mem_read = 0;
                mem_write = 0;
                mem_address = 32'dx;
                mem_writedata = 32'dx;
                busywait = 0;   
            end
           
            MEM_READ: 
            begin
                // go to the data memory and read the value 
                //according to the address
                mem_read = 1;
                mem_write = 0;
                mem_address = {tag, index};
                mem_writedata = 32'dx;
                //hold the cpu 
                busywait = 1;
                
            end
            
            MEM_WRITE:
            begin
                //write to the data memory and hold the cpu
                mem_read = 0;
                mem_write = 1;
                mem_address = {tag, index};
                mem_writedata = data;
                busywait = 1;
            end
            
            CACHE_UPDATE:
            begin
                #1
                mem_read = 0;
                mem_write = 0;
                mem_address = 6'dx;
                mem_writedata = 32'dx;
                //update the cache memory 
                valid = 1;
                dirty = 0;
                cache_tag = tag;
                data = mem_readdata;
                cache_memory[index] = {valid, dirty, cache_tag, data};
            end

        endcase
    end

    // sequential logic for state transitioning 
    always @(posedge clock, reset)
    begin
        if(reset)
            state = IDLE;
        else
            state = next_state;
    end
    
    //reset the cache memory
    integer i;
    always @(reset) begin
        if(reset) begin
           for(i=0; i<8; i=i+1) begin
              cache_memory[i] = 0;
           end  
        end
    end

    /* Cache Controller FSM End */

endmodule