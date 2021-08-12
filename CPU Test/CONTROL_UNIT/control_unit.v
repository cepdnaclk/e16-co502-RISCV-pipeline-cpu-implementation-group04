//control unit***************************************************
module ctrl_unit(OP,FUN3,FUN7,CLK,RESET,MEM_READ,MEM_WRITE,REG_WRITE,MEM_TO_REG,BRANCH,REG_DEST,ALU_SOURCE,ALU_OP,IMMI_SEL,PC_SEL);

	//declareing input 
	input [6:0] OP,FUN7;
	input [2:0] FUN3;
	input CLK,RESET;
	//declaring output
	output reg [4:0] ALU_OP;
	output reg [2:0]  MEM_READ,MEM_WRITE,IMMI_SEL;
	output reg [1:0] MEM_TO_REG,ALU_SOURCE;
	output reg REG_WRITE,BRANCH,REG_DEST,PC_SEL;

	
//r type instructions*************************************************************************************
	always @ (OP,FUN3,FUN7) begin
		#1
		if(OP[6:0] == 7'b0110011)  begin  //rtype
			MEM_READ = 3'b000;
			MEM_WRITE = 3'b000;
			REG_WRITE = 1'b1;
			MEM_TO_REG = 2'b00;
			BRANCH = 1'b0;
			ALU_SOURCE = 2'b00;
			REG_DEST = 1'b1;
			
			
			if(FUN7[6:0] == 7'b0000000)  begin  
				case (FUN3)
					8'b000: begin   
						ALU_OP = 5'b00000; //add
					end
					8'b001: begin                            
						ALU_OP = 5'b00001; // sll
					end
					8'b010: begin                            
						ALU_OP = 5'b00010; // slt
					end
					8'b011: begin                            
						ALU_OP = 5'b00011; // sltu
					end
					8'b100: begin                            
						ALU_OP = 5'b00100; // XOR
					end
					8'b101: begin                            
						ALU_OP = 5'b00101; // SRL
					end
					8'b110: begin                            
						ALU_OP = 5'b00110; // OR
					end
					8'b111: begin                            
						ALU_OP = 5'b00111; // AND
					end
					
				endcase
			
			end 
			else if(FUN7[6:0] == 7'b0100000) begin
				case (FUN3)
					8'b000: begin   
						ALU_OP = 5'b10000; //SUB
					end
					8'b101: begin                            
						ALU_OP = 5'b10101; // SRA
					end

				endcase
			
			
			end 
			else if(FUN7[6:0] == 7'b0111011) begin
				case (FUN3)
					8'b000: begin   
						ALU_OP = 5'b11000; //MUL
					end
					8'b001: begin                            
						ALU_OP = 5'b11001; // MULH
					end
					8'b010: begin                            
						ALU_OP = 5'b11010 ;// MULHSU
					end
					8'b011: begin                            
						ALU_OP = 5'b11011;// MULHU
					end
					8'b100: begin                            
						ALU_OP = 5'b11100 ;// DIV
					end
					8'b101: begin                            
						ALU_OP = 5'b11101; // REM
					end
					8'b111: begin                            
						ALU_OP = 5'b11111; // REMU
					end
					
				endcase
			end
			
		

		
		end	//end of op code	
		// S type ****************************************************************************************************************************
			if(OP[6:0] == 7'b0100011)  begin  //Itype
				MEM_READ = 3'b000;
				REG_WRITE = 1'b0;
				BRANCH = 1'b0;
				ALU_SOURCE = 2'b01;
				IMMI_SEL = 3'b010;
				ALU_OP = 5'b00000; //add
				
					case (FUN3)
						8'b000: begin   
							MEM_WRITE = 3'b001;
						end
						8'b001: begin                            
							MEM_WRITE = 3'b010;
						end
						8'b010: begin                            
							MEM_WRITE = 3'b011;
						end
						
						8'b100: begin                            
							MEM_WRITE = 3'b100;
						end
						8'b101: begin                            
							MEM_WRITE = 3'b101;
						end
						
					endcase
		
		end	//end of op code	
		
		if(OP[6:0] == 7'b0000011) begin		//i type load instructions
			//only MEM_READ changing wiith the function 3 value
			ALU_OP = 5'b00000; //all the i type load instruction uses add operation in ALU_OP
			MEM_WRITE = 3'b000;
			MEM_TO_REG = 2'b01;
			REG_WRITE = 1'b1;
			ALU_SOURCE = 2'b01;
			BRANCH = 1'b0;
			REG_DEST = 1'b1;
			IMMI_SEL = 3'b000;
			
			case(FUN3)
			3'b000 : MEM_READ = 3'b001;
			3'b001 : MEM_READ = 3'b010;
			3'b010 : MEM_READ = 3'b011;
			3'b100 : MEM_READ = 3'b100;
			3'b101 : MEM_READ = 3'b101;
			endcase	
		end //end of opcode
		
		//I type operations
		if(OP[6:0] == 7'b0010011) begin
			MEM_READ = 3'b000;
			MEM_WRITE = 3'b000;
			MEM_TO_REG = 2'b00;
			REG_WRITE = 1'b1;
			ALU_SOURCE = 2'b01;
			BRANCH = 1'b0;
			REG_DEST = 1'b1;
			
			case (FUN3)
				8'b000: begin   
					ALU_OP = 5'b00000; //add
					IMMI_SEL = 3'b000;
				end
				8'b001: begin                            
					ALU_OP = 5'b00001; // sll
					IMMI_SEL = 3'b001;
				end
				8'b010: begin                            
					ALU_OP = 5'b00010; // slt
					IMMI_SEL = 3'b000;
				end
				8'b011: begin                            
					ALU_OP = 5'b00011; // sltu
					IMMI_SEL = 3'b000;
				end
				8'b100: begin                            
					ALU_OP = 5'b00100; // XOR
					IMMI_SEL = 3'b000;
				end
				8'b101: begin                            
					ALU_OP = 5'b00101; // SRL
					IMMI_SEL = 3'b001;
				end
				8'b110: begin                            
					ALU_OP = 5'b00110; // OR
					IMMI_SEL = 3'b000;
				end
				8'b111: begin                            
					ALU_OP = 5'b00111; // AND
					IMMI_SEL = 3'b000;
				end
				
			endcase
		end //end of opecode
		
		//special opcod for SRAI
		if(OP[6:0] == 7'b1000000) begin
			MEM_READ = 3'b000;
			MEM_WRITE = 3'b000;
			MEM_TO_REG = 2'b00;
			REG_WRITE = 1'b1;
			ALU_SOURCE = 2'b01;
			BRANCH = 1'b0;
			REG_DEST = 1'b1;
			ALU_OP = 5'b10101; // SRA
			IMMI_SEL = 3'b001;
		end
		
		//JALR
		if(OP[6:0] == 7'b1100111) begin
			MEM_READ = 3'b000;
			MEM_WRITE = 3'b000;
			MEM_TO_REG = 2'b00;
			REG_WRITE = 1'b1;
			ALU_SOURCE = 2'b10;
			BRANCH = 1'b1;
			REG_DEST = 1'b1;
			ALU_OP = 5'b10001; // Foraward with Branch
			IMMI_SEL = 3'b011;
			PC_SEL = 0;
		end
		
		
		// BRANCH type ****************************************************************************************************************************
			if(OP[6:0] == 7'b1100011)  begin  //Itype
				MEM_READ = 3'b000;
				MEM_WRITE =  3'b000;
				MEM_TO_REG = 2'b10;
				REG_WRITE = 1'b0;
				ALU_SOURCE = 2'b00;
				BRANCH = 1'b1;
				IMMI_SEL = 3'b010;
				PC_SEL = 1'b0;
			
				case (FUN3)
					8'b000: begin   
						ALU_OP = 5'b01000; 
					end
					8'b001: begin                            
						ALU_OP = 5'b01001; 
					end
					8'b100: begin                            
						ALU_OP = 5'b01100 ;
					end
					8'b101: begin                            
						ALU_OP = 5'b01101;
					end
					8'b110: begin                            
						ALU_OP = 5'b01110 ;
					end
					8'b111: begin                            
						ALU_OP = 5'b01111; 
					end
					
				endcase
		
		end	//end of op code	
					
					
					
		// U type ****************************************************************************************************************************
		//LUI
			if(OP[6:0] == 7'b0110111)  begin  //Itype
				MEM_READ = 3'b000;
				MEM_WRITE =  3'b000;
				REG_WRITE = 1'b1;
				ALU_SOURCE = 2'b01;
				BRANCH = 1'b0;
				REG_DEST = 1'b1;
				IMMI_SEL = 3'b011;
				ALU_OP = 5'b11110; //forward
				MEM_TO_REG = 2'b00;
		end	//end of op code	
								
		
		//AUIPC
			if(OP[6:0] == 7'b0011111)  begin  //Itype
				MEM_READ = 3'b000;
				MEM_WRITE =  3'b000;
				REG_WRITE = 1'b1;
				//ALU_SOURCE = 2'b01;
				BRANCH = 1'b0;
				REG_DEST = 1'b1;
				IMMI_SEL = 3'b011;
				//ALU_OP = 5'b11110; //forward
				MEM_TO_REG = 2'b10;
		end	//end of op code	
		
	end
		
		
endmodule