`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: Single-Cycle RISC-V Processor
// Module Name: riscv_single
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// Single-cycle 32-bit RISC-V processor implementing basic instructions.
// Includes PC logic, instruction fetch, register file, ALU, memory, and control logic.
//
// Dependencies: 
// - instr_mem
// - register_file
// - ALU
// - Adder
// - mux2, mux3to1
// - ExtendUnit
// - control_unit
// - data_mem
//
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module riscv_single(
    input logic clk,
    input logic reset
);

    // -----------------------------
    // Control Signals
    // -----------------------------
    logic Zero;
    logic PCSrc;
    logic RegWrite;
    logic MemWrite;
    logic [1:0] ResultSrc;
    logic Jump, Branch;
    logic ALUSrc;
    logic [1:0] ImmSrc;          
    logic [2:0] ALUControl;

    // -----------------------------
    // Data Signals
    // -----------------------------
    logic [31:0] SrcB;
    logic [31:0] ALUResult;
    logic [31:0] ReadData;  
    logic [31:0] PCTarget;
    logic [31:0] PCNext;
    logic [31:0] ResultW;
    logic [31:0] Instr, PC, PCPlus4;
    logic [31:0] rd1, rd2;
    logic [31:0] ImmExtend;

    // -----------------------------
    // PC Logic
    // -----------------------------
    assign PCSrc = (Branch & Zero) | Jump;        // Branch or jump decision
    Adder PC_Plus_4(.A(PC), .B(32'd4), .Sum(PCPlus4));        // PC + 4
    Adder PC_Target(.A(PC), .B(ImmExtend), .Sum(PCTarget));   // PC + immediate (branch/jump)
    mux2 PC_Next(.d0(PCPlus4), .d1(PCTarget), .s(PCSrc), .y(PCNext)); // Select next PC
    program_counter ProgramCounter(.clk(clk), .reset(reset), .PCNext(PCNext), .PC(PC));

    // -----------------------------
    // Instruction Fetch
    // -----------------------------
    instr_mem instruction_memory(.A(PC), .RD(Instr));  

    // -----------------------------
    // Register File
    // -----------------------------
    register_file register_file(
        .clk(clk),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .wd3(ResultW),
        .we(RegWrite),
        .rd1(rd1),
        .rd2(rd2)
    );

    // -----------------------------
    // Immediate Extension
    // -----------------------------
    ExtendUnit Extend(.Instr(Instr), .ImmSrc(ImmSrc), .ImmExtend(ImmExtend));

    // -----------------------------
    // Control Unit
    // -----------------------------
    control_unit control_unit(
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7b5(Instr[30]),
        .Branch(Branch),
        .Jump(Jump),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl)
    );

    // -----------------------------
    // ALU Operand Selection
    // -----------------------------
    mux2 Src_B(.d0(rd2), .d1(ImmExtend), .s(ALUSrc), .y(SrcB));

    // -----------------------------
    // ALU Execution
    // -----------------------------
    ALU ALU(
        .SrcA(rd1),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // -----------------------------
    // Data Memory Access
    // -----------------------------
    data_mem data_memory(
        .clk(clk),
        .we(MemWrite),
        .A(ALUResult),
        .WD(rd2),
        .ReadData(ReadData)
    );

    // -----------------------------
    // Write-back Selection
    // -----------------------------
    mux3to1 result(
        .d0(ALUResult),
        .d1(ReadData),
        .d2(PCPlus4),
        .s(ResultSrc),
        .y(ResultW)
    );

endmodule
