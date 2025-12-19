`timescale 1ns / 1ps
module riscv_single(input logic clk, reset);
logic Zero;
logic PCSrc;
 logic RegWrite;
 logic MemWrite;
 logic [1:0] ResultSrc;
logic Jump,Branch;
logic ALUSrc;
logic [1:0] ImmSrc;          
logic [2:0] ALUControl;
logic [31:0] SrcB;
logic [31:0] ALUResult;
logic [31:0] ReadData;  
logic [31:0] PCTarget;
logic [31:0] PCNext;
logic [31:0] ResultW;
logic [31:0] Instr, PC,PCPlus4;
logic [31:0] rd1, rd2;
logic [31:0] ImmExtend;
assign PCSrc = (Branch & Zero) | Jump;
Adder PC_Plus_4(.A(PC),.B(32'd4),.Sum(PCPlus4));
Adder PC_Target(.A(PC),.B(ImmExtend),.Sum(PCTarget));
mux2 PC_Next(.d0(PCPlus4), .d1(PCTarget), .s(PCSrc),.y(PCNext));
program_counter ProgramCounter(.clk(clk),.reset(reset),.PCNext(PCNext),.PC(PC));
instr_mem instruction_memory(.A(PC),.RD(Instr));  
register_file register_file(.clk(clk),.A1(Instr[19:15]),.A2(Instr[24:20]),.A3(Instr[11:7]),.wd3(ResultW),.we(RegWrite),.rd1(rd1),.rd2(rd2));
ExtendUnit Extend(.Instr(Instr),.ImmSrc(ImmSrc),.ImmExtend(ImmExtend));
control_unit control_unit(.op(Instr[6:0]),.funct3(Instr[14:12]),.funct7b5(Instr[30]),.Branch(Branch),.Jump(Jump),
.ResultSrc(ResultSrc),.MemWrite(MemWrite),.ImmSrc(ImmSrc),.RegWrite(RegWrite), .ALUSrc(ALUSrc),.ALUControl(ALUControl));
mux2 Src_B(.d0(rd2), .d1(ImmExtend), .s(ALUSrc),.y(SrcB));
ALU ALU(.SrcA(rd1),.SrcB(SrcB),.ALUControl(ALUControl),.ALUResult(ALUResult),.Zero(Zero));
data_mem data_memory(.clk(clk),.we(MemWrite),.A(ALUResult), .WD(rd2),.ReadData(ReadData));
mux3to1 result(.d0(ALUResult), .d1(ReadData), .d2(PCPlus4),.s(ResultSrc),.y(ResultW));

endmodule
