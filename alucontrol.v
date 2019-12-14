`timescale 1ns / 1ps


`define AND		4'b0000
`define OR		4'b0001
`define ADD 	4'b0010
`define SLL 	4'b0011
`define SRL 	4'b0100
`define MULA	4'b0101
`define SUB 	4'b0110
`define SLT 	4'b0111
`define ADDU	4'b1000
`define SUBU	4'b1001
`define XOR		4'b1010
`define SLTU	4'b1011
`define NOR		4'b1100
`define SRA		4'b1101
`define LUI		4'b1110

`define SLLFunc  6'b000000
`define SRLFunc  6'b000010
`define SRAFunc  6'b000011
`define ADDFunc  6'b100000
`define ADDUFunc 6'b100001
`define SUBFunc  6'b100010
`define SUBUFunc 6'b100011
`define ANDFunc  6'b100100
`define ORFunc   6'b100101
`define XORFunc  6'b100110
`define NORFunc  6'b100111
`define SLTFunc  6'b101010
`define SLTUFunc 6'b101011
`define MULAFunc 6'b111000

module ALUControl (ALU_control, ALUOp, funct);
output [3:0] ALU_control;  
reg [3:0] ALU_control;
input [3:0] ALUOp;  
input [5:0] funct; 

always @(funct or ALUOp)
begin
if(ALUOp == 4'b1111)
begin 

case (funct)

`SLLFunc : ALU_control <= `SLL;//depending upon the functional bits passed, assigning the function to it. 
`SRLFunc : ALU_control <= `SRL;
`SRAFunc : ALU_control <= `SRA;
`ADDFunc : ALU_control <= `ADD;
`ADDUFunc : ALU_control <= `ADDU;
`SUBFunc : ALU_control <= `SUB;
`SUBUFunc : ALU_control <= `SUBU;
`ANDFunc : ALU_control <= `AND;
`ORFunc : ALU_control <= `OR;
`XORFunc : ALU_control <= `XOR;
`NORFunc : ALU_control <= `NOR;
`SLTFunc : ALU_control <= `SLT;
`SLTUFunc : ALU_control <=`SLTU;
`MULAFunc : ALU_control <= `MULA;

default : ALU_control=4'b0;
endcase
end             

else 
begin
ALU_control<=ALUOp;//if directly opcode is passsed, assiging it directly. 
end 
end
	

endmodule