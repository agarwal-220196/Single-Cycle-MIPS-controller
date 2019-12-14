`timescale 1ns / 1ps


// Code your design here
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
  output [31:0] BusA, BusB;
  input [31:0] BusW;
  input [4:0] RA, RB, RW;
  input RegWr;
  input Clk;

  reg [31:0] registers [31:0];

  assign  BusA = (RA==0) ? 32'd0:registers[RA];
  assign  BusB = (RB==0) ? 32'd0:registers[RB];
  

  always @ (negedge Clk) 
  begin
  
    if(RegWr) begin
      if (RW != 5'd0)
        registers[RW] = BusW;
 end 
  end
endmodule
