`timescale 1ns / 1ps

module DataMemory (

output reg [31:0] read_data,      // Output of Memory Address Contents
input  [31:0] addr,          // Memory Address
input  [31:0] write_data,    // Memory Address Contents
input   memread,
input   memwrite,
input   clk                  // All synchronous elements, including memories, should have a clock signal

);

reg [7:0] MEMO[128:0];  // changed 

// Using @(addr) will lead to unexpected behavior as memories are synchronous elements like registers
always @(negedge clk) begin
  if (memwrite == 1'b1) begin
    {MEMO[addr],MEMO[addr+1],MEMO[addr+2],MEMO[addr+3]} = write_data;
  end
end 

always @(posedge clk) begin
  // Use memread to indicate a valid address is on the line and read the memory into a register at that address when memread is asserted
  if (memread == 1'b1) begin
    read_data[31:0] =  {MEMO[addr],MEMO[addr+1],MEMO[addr+2],MEMO[addr+3]};
  end

end

endmodule