`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2022 01:09:33
// Design Name: 
// Module Name: ALU_8_bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_8_bit(inputA, inputB, OpCode, COut, OutALU);
	input [7:0] inputA; // 8-bit A register
	input [7:0] inputB; //8-bit B register
	input [2:0] OpCode; // 3-bit Opcode register
	output reg [15:0] OutALU; // 16-bit output register
	output reg COut; // 1-bit carry out
	parameter [2:0] ADD = 3'b000, SUB = 3'b001, MUL = 3'b010, LSHFT = 3'b011,// constants fro defining various ALU operations
				 RSHFT = 3'b100, AND = 3'b101, OR = 3'b110, XOR = 3'b111;// constants in verilog are called parameters
	
	reg [15:0] combine;
	
	always @(inputA or inputB or OpCode) // variable inside always @ indicates the variable being evaluated 
	begin // switch case in verilog
		case(OpCode) // getting input from the various Opcodes 
		ADD: begin// case -1 ADD
		OutALU = inputA + inputB;
		if(OutALU[8] == 1'b1)// checking the 9 the bit for 1 to give carry 
			COut = 1;
		else
			COut = 0;
		end
		
		SUB: begin// case-2 SUB
		if(inputA > inputB)
			OutALU = inputA - inputB;
		else
			OutALU = inputB - inputA;
		end

		MUL: begin// case -3 MUlTIPLICATION for this we need 16 bit output register
		OutALU = inputA * inputB;
		end
		
		LSHFT: begin// case -4 Left shift 
		if(inputA == 0)
			OutALU = inputB << 1;
		else if(inputB == 0)
			OutALU = inputA << 1;
		else
			begin
			combine = {inputA,inputB};// case when both A and B are not zero then combine the input and apply left shift operation
			OutALU = combine << 1;
			end
		end
		
		RSHFT: begin// case -5 Right Shift
		if(inputA == 0)
			OutALU = inputB >> 1;
		else if(inputB == 0)
			OutALU = inputA >> 1;
		else
			begin
			combine = {inputA,inputB};// case when both A and B are not zero then combine the input and apply right shift operation
			OutALU = combine >> 1;
			end
		end
		
		AND: begin // case-6 AND operation
		OutALU = inputA & inputB;
		end
		
		OR: begin // case-7 OR operation
		OutALU = inputA | inputB;
		end
	
		XOR: begin // case-8 XOR operation
		OutALU = inputA ^ inputB;
		end
		endcase
	end
endmodule