`timescale 1ns / 1ps


module SingleCycleProc(
CLK,
Reset_L,
startPC,
dMemOut);
    
input CLK,Reset_L;
input [31:0] startPC;
output [31:0] dMemOut;

wire [31:0] Data;
wire [31:0] Address;
wire [31:0] updated_PC_Address;

//SCC1 wires 
wire RegDst;
wire ALUSrc;
wire MemToReg;
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire Jump;
wire SignExtend;
wire [3:0]ALUOp;

//register RF1 wires 
wire [31:0] BusA, BusB;
wire [31:0] BusW;
wire [4:0] RA, RB, RW;
wire RegWr;
wire Clk;
wire[4:0] write_register_select;
wire [31:0] write_register_data;


//ALU CONTROL
wire [3:0] ALU_control;

//MUX before ALU 
wire [31:0] operandB_ALU;
wire[31:0] sign_extension_data;

//ALU 
wire [31:0] ALU_Output;
wire ALU_Zero;


//DATA MEMORY 
wire [31:0] Data_memory_out;

//shiftleft for branch;
wire [31:0] shift_left_2_branch;

//branch address
wire [31:0] branch_address;

//pc update
wire[31:0] PC_update;

//and of branch and zero 

wire [31:0] branch_and ;

//input to branch mux;

wire [31:0] branch_mux;

//shift left 2 bits 25 to 0
wire [27:0] shift_for_jump;

//final jump 
wire [31:0] final_jump;

//wire [31:0] final_output;

wire [31:0] final_bus_B;
wire [31:0] final_bus_A;



InstructionMemory IM1(.Data(Data), .Address(Address));
PC PC1( .clk(CLK) , .reset(Reset_L) ,.last_address(updated_PC_Address),.startPC(startPC) ,.address(Address));

SingleCycleControl SCC1 (.RegDst(RegDst), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .Jump(Jump), .SignExtend(SignExtend), .ALUOp(ALUOp), .Opcode(Data[31:26]));


//Register _file;
RegisterFile RF1 (.BusA(BusA), .BusB(BusB), .BusW(write_register_data), .RA(Data[25:21]), .RB(Data[20:16]), .RW(write_register_select), .RegWr(RegWrite), .Clk(CLK));

//ALU Control Unit. 
ALUControl AC1 (.ALU_control(ALU_control), .ALUOp(ALUOp), .funct(Data[5:0]));

//ALU 
ALU ALU1 (.BusW(ALU_Output), .Zero(ALU_Zero), .BusA(final_bus_A), .BusB(final_bus_B), .ALUCtrl(ALU_control));

DataMemory DM1 (.read_data(Data_memory_out), .addr(ALU_Output), .write_data(BusB), .memread(MemRead), .memwrite(MemWrite), .clk(CLK));


//sign extension
assign sign_extension_data = SignExtend ? {{16{Data[15]}},Data[15:0]} : {{16{1'b0}},Data[15:0]}  ;

//selecting write register of RF1 
assign write_register_select = RegDst ? Data[15:11] : Data[20:16];

//selecting operand B of ALU
assign operandB_ALU = ALUSrc ? sign_extension_data :BusB;

assign final_bus_B =( (ALU_control == 4'b0011) ? Data[10:6]  : (ALU_control == 4'b0100)? Data[10:6] :(ALU_control == 4'b1101)? Data[10:6]:operandB_ALU );
assign final_bus_A = ( (ALU_control == 4'b0011) ? BusB  : (ALU_control == 4'b0100)? BusB :(ALU_control == 4'b1101)? BusB :BusA );

//data_written in register
assign write_register_data = MemToReg ? Data_memory_out: ALU_Output;

//shift left for branch 
assign shift_left_2_branch = sign_extension_data<<2;
 
//pc update
assign PC_update =  Address + 32'd4 ; 
 
//branch address
assign branch_address =   shift_left_2_branch + PC_update;

assign branch_and = Branch & ALU_Zero;

assign branch_mux = branch_and ?  branch_address : PC_update;

assign shift_for_jump = Data[25:0] << 2;

assign final_jump = {PC_update[31:28],shift_for_jump};

assign updated_PC_Address = Jump ? final_jump : branch_mux;

assign dMemOut = Data_memory_out;



endmodule