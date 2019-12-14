`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 06:38:53 PM
// Design Name: 
// Module Name: PC
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


module PC( clk, reset,last_address,startPC ,address

    );
    
   input clk,reset;
   input [31:0] last_address;
   input [31:0] startPC;
   output reg [31:0]address;
   
   always @(negedge clk or negedge reset)begin
    
    if (reset==1'b0)
    address <= startPC;
    else 
    address <= last_address;
    end
endmodule