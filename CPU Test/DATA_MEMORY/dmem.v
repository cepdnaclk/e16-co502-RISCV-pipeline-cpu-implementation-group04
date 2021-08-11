`timescale 1ns/100ps
module data_memory(
	clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
	busywait
);
input				clock;
input           	reset;
input           	read;
input           	write;
input[31:0]      	address;
input[127:0]     	writedata;
output reg [127:0]	readdata;
output reg      	busywait;

//Declare memory array 256x8-bits 
reg [7:0] memory_array [255:0];

//Detecting an incoming memory access
reg readaccess, writeaccess;
always @(read, write)
begin
	busywait = (read || write)? 1 : 0;
	readaccess = (read && !write)? 1 : 0;
	writeaccess = (!read && write)? 1 : 0;
end

//Reading & writing
always @(posedge clock)
begin
	if(readaccess)
	begin
		readdata[31:0]   = #40 memory_array[{address,2'b00}];
		readdata[63:32]  = #40 memory_array[{address,2'b01}];
		readdata[95:64] = #40 memory_array[{address,2'b10}];
		readdata[127:96] = #40 memory_array[{address,2'b11}];
		busywait = 0;
		readaccess = 0;
	end
	if(writeaccess)
	begin
		memory_array[{address,2'b00}] = #40 writedata[31:0];
		memory_array[{address,2'b01}] = #40 writedata[63:32];
		memory_array[{address,2'b10}] = #40 writedata[95:64];
		memory_array[{address,2'b11}] = #40 writedata[127:96];
		busywait = 0;
		writeaccess = 0;
	end
end

integer i;
//Reset memory
always @(posedge reset)
begin
    if (reset)
    begin
        for (i=0;i<256; i=i+1)
            memory_array[i] = 0;
        
        busywait = 0;
		readaccess = 0;
		writeaccess = 0;
    end
end

endmodule