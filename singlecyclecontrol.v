`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:34 03/10/2009 
// Design Name: 
// Module Name:    SingleCycleControl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define RTYPEOPCODE 6'b000000
`define LWOPCODE        6'b100011
`define SWOPCODE        6'b101011
`define BEQOPCODE       6'b000100
`define JOPCODE     6'b000010
`define ORIOPCODE       6'b001101
`define ADDIOPCODE  6'b001000
`define ADDIUOPCODE 6'b001001
`define ANDIOPCODE  6'b001100
`define LUIOPCODE       6'b001111
`define SLTIOPCODE  6'b001010
`define SLTIUOPCODE 6'b001011
`define XORIOPCODE  6'b001110

`define AND     4'b0000
`define OR      4'b0001
`define ADD     4'b0010
`define SLL     4'b0011
`define SRL     4'b0100
`define SUB     4'b0110
`define SLT     4'b0111
`define ADDU    4'b1000
`define SUBU    4'b1001
`define XOR     4'b1010
`define SLTU    4'b1011
`define NOR     4'b1100
`define SRA     4'b1101
`define LUI     4'b1110
`define FUNC    4'b1111

module SingleCycleControl(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, Opcode);
   input [5:0] Opcode;
   output RegDst;
   output ALUSrc;
   output MemToReg;
   output RegWrite;
   output MemRead;
   output MemWrite;
   output Branch;
   output Jump;
    output SignExtend;
   output [3:0] ALUOp;
     
    reg RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
    reg  [3:0] ALUOp;
    always @ (Opcode) begin
        case(Opcode)
            `RTYPEOPCODE: begin
                RegDst <= 1'b1;
                ALUSrc <=  1'b0;
                MemToReg <= 1'b0;
                RegWrite <=  1'b1;
                MemRead <=  1'b0;
                MemWrite <=  1'b0;
                Branch <=  1'b0;
                
                Jump <=  1'b0;
                SignExtend <=  1'b0;
                ALUOp <=  `FUNC;
            end
            
            `LWOPCODE: begin
                            RegDst <= 1'b0;
                            ALUSrc <= 1'b1;
                            MemToReg <=  1'b1;
                            RegWrite <= 1'b1;
                            MemRead <=  1'b1;
                            MemWrite <=  1'b0;
                            Branch <=  1'b0;
                            Jump <= 1'b0;
                            ALUOp <= `ADD;
                            
                            SignExtend <= 1'b1;
                            
             end
             
             `SWOPCODE: begin
                             RegDst <= 1'b0;
                             ALUSrc <= 1'b1;
                             MemToReg <= 1'b1;
                             RegWrite <= 1'b0;
                             MemRead <= 1'b0;
                             MemWrite <= 1'b1;
                             Branch <= 1'b0; 
                             Jump <=  1'b0;
                             ALUOp <=  `ADD;
                             
                             SignExtend <=  1'b1;
                            
               end
            
             `BEQOPCODE: begin
                               RegDst <=  1'b0;
                               ALUSrc <=  1'b0;
                               MemToReg <=  1'b0;
                               RegWrite <=  1'b0;
                               MemRead <=  1'b0;
                               MemWrite <=  1'b0;
                               Branch <=  1'b1;  
                               Jump <=  1'b0;
                               ALUOp <=  `SUB;
                               
                               SignExtend <=  1'b1; //changed later
                               
                 end    
                        
             `JOPCODE: begin
                                   RegDst <=  1'b0;
                                   ALUSrc <=  1'b0;
                                   MemToReg <=  1'b0;
                                   RegWrite <=  1'b0;
                                   MemRead <=  1'b0;
                                   MemWrite <=  1'b0;
                                   Branch <=  1'b0;
                                   Jump <=  1'b1;
                                   SignExtend <=  1'b1;
                                   ALUOp <=  `AND;
                     end 
                        
             `ORIOPCODE: begin
                                   RegDst <=  1'b0;
                                   ALUSrc <=  1'b1;
                                   MemToReg <=  1'b0;
                                   RegWrite <=  1'b1;
                                   MemRead <=  1'b0;
                                   MemWrite <=  1'b0;
                                   Branch <=  1'b0;
                                   Jump <=  1'b0;
                                   SignExtend <=  1'b0;
                                   ALUOp <= `OR;
                         end
                              
             `ADDIOPCODE: begin
                                   RegDst <=  1'b0;
                                   ALUSrc <=  1'b1;
                                   MemToReg <=  1'b0;
                                   RegWrite <=  1'b1;
                                   MemRead <=  1'b0;
                                   MemWrite <=  1'b0;
                                   Branch <=  1'b0;
                                   Jump <=  1'b0;
                                   SignExtend <=  1'b1;
                                   ALUOp <=  `ADD;
                         end             
                                     
             `ADDIUOPCODE: begin
                                   RegDst <=  1'b0;
                                   ALUSrc <=  1'b1;
                                   MemToReg <=  1'b0;
                                   RegWrite <=  1'b1;
                                   MemRead <=  1'b0;
                                   MemWrite <=  1'b0;
                                   Branch <=  1'b0;
                                   Jump <=  1'b0;
                                   SignExtend <=  1'b0; //changed later
                                   ALUOp <= `ADDU;
                           end   
                           
             `ANDIOPCODE: begin
                                     RegDst <=  1'b0;
                                     ALUSrc <=  1'b1;
                                     MemToReg <=  1'b0;
                                     RegWrite <=  1'b1;
                                     MemRead <=  1'b0;
                                     MemWrite <=  1'b0;
                                     Branch <=  1'b0;
                                     Jump <=  1'b0;
                                     SignExtend <=  1'b0;
                                     ALUOp <=  `AND;
                             end  
                                         
             `LUIOPCODE: begin
                                   RegDst <=  1'b0;//changed
                                   ALUSrc <=  1'b1;
                                   MemToReg <=  1'b0;
                                   RegWrite <=  1'b1;
                                   MemRead <=  1'b0;
                                   MemWrite <=  1'b0;
                                   Branch <=  1'b0;
                                   Jump <=  1'b0;
                                   SignExtend <= 1'b0;//changed
                                   ALUOp <=  `LUI;
                           end  
                                                       
             `SLTIOPCODE: begin
                                 RegDst <=  1'b0;
                                 ALUSrc <=  1'b1;
                                 MemToReg <=  1'b0;
                                 RegWrite <=  1'b1;
                                 MemRead <=  1'b0;
                                 MemWrite <=  1'b0;
                                 Branch <=  1'b0;
                                 Jump <=  1'b0;
                                 SignExtend <= 1'b1;
                                 ALUOp <= `SLT;
                         end  
             `SLTIUOPCODE: begin
                                   RegDst <= 1'b0;
                                   ALUSrc <=  1'b1;
                                   MemToReg <=  1'b0;
                                   RegWrite <=  1'b1;
                                   MemRead <=  1'b0;
                                   MemWrite <=  1'b0;
                                   Branch <=  1'b0;
                                   Jump <=  1'b0;
                                   SignExtend <=  1'b1;
                                   ALUOp <=  `SLTU;
                           end

             `XORIOPCODE: begin
                                     RegDst <=  1'b0;
                                     ALUSrc <=  1'b1;
                                     MemToReg <=  1'b0;
                                     RegWrite <=  1'b1;
                                     MemRead <=  1'b0;
                                     MemWrite <=  1'b0;
                                     Branch <=  1'b0;
                                     Jump <=  1'b0;
                                     SignExtend <=  1'b0; //changed 
                                     ALUOp <= `XOR;
                             end                                                                                                                                                                                                                                                                                                                                                                                       
    

            default: begin
                RegDst <=  1'bx;
                ALUSrc <=  1'bx;
                MemToReg <=  1'bx;
                RegWrite <=  1'bx;
                MemRead <=  1'bx;
                MemWrite <=  1'bx;
                Branch <=  1'bx;
                Jump <=  1'bx;
                SignExtend <= 1'bx;
                ALUOp <=  4'bxxxx;
            end
        endcase
    end
endmodule