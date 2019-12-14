`timescale 1ns / 1ps



`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SLL 4'b0011
`define SRL 4'b0100
`define SUB 4'b0110
`define SLT 4'b0111
`define ADDU 4'b1000
`define SUBU 4'b1001
`define XOR 4'b1010
`define SLTU 4'b1011
`define NOR 4'b1100
`define SRA 4'b1101
`define LUI 4'b1110

module ALU(BusW, Zero, BusA, BusB, ALUCtrl);

input wire [31:0] BusA, BusB;
output reg [31:0] BusW;
input wire [3:0] ALUCtrl ;
output wire Zero ;

wire less;
wire [63:0] Bus64;
assign less = ({1'b0,BusA} < {1'b0,BusB}  ? 1'b1 : 1'b0); //checks which value is greater.

assign Zero = ((BusW==0)  ? 1'b1 : 1'b0); //checks which value is greater. 
//assign Bus64 = 


always@(*)begin	
	
	case (ALUCtrl)
	`AND: BusW <= (BusA & BusB); //logic as per operation 
	 
	`OR:  BusW <= (BusA | BusB);
	      	       
	`ADD: BusW <= BusA + BusB;
	      
	`ADDU:BusW <= BusA + BusB;
                 
	`SLL: BusW <= BusA<<BusB;
	        
	`SRL: BusW <= BusA>>BusB;
	        
	`SUB: BusW <= BusA-BusB;
	`SUBU:BusW <= BusA-BusB;   
	
	`XOR:BusW <= BusA^BusB;
	`NOR:BusW <= ~(BusA|BusB);
            
	`SLT:   begin
                if (BusA[31] != BusB[31]) begin
                          if (BusA[31] > BusB[31]) begin
                                        BusW <= 32'd1;
                                    end 
                          else begin
                                        BusW <= 0;
                                    end
                     end 
               else begin
                       if (BusA < BusB)
                            begin
                                BusW <= 32'd1;
                            end
                        else
                            begin
                                BusW <= 0;
                            end
                end
                /*BusW = ((BusA && 32'h7fffffff) < (BusB && 32'h7fffffff)) ? 32'd1 :32'd0;*/
            end
            
	`SLTU:  begin
               if (less==1)
               BusW <= 32'd1;
               else
               BusW <= 32'd0;
              
            end
             
	`SRA: BusW <=   $signed(BusA)>>>(BusB);//in built operator 
          
            
	`LUI: BusW <= {BusB[15:0],16'd0};
	 
	default:BusW <= 32'd0;
	endcase
end





endmodule