`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2025
// Design Name: Single-Cycle RISC-V Processor
// Module Name: riscv_single
// Project Name: RISC-V CPU
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   Single-Cycle 32-bit RISC-V Processor
//   Implements RV32I subset instructions:
//     - R-type, I-type, Load, Store, Branch, JAL
//   Each instruction completes in one clock cycle.
//
// Dependencies:
//   - Adder
//   - mux2
//   - mux3to1
//   - program_counter
//   - instr_mem
//   - register_file
//   - ExtendUnit
//   - control_unit
//   - ALU
//   - data_mem
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

module riscv_single(
    input logic clk,
    input logic reset
);

    // -------------------------
    // Control Signals
    // -------------------------
    logic Zero;          // ALU Zero flag
    logic PCSrc;         // PC source select (branch/jump)
    logic RegWrite;      // Register write enable
    logic MemWrite;      // Data memory write enable
    logic [1:0] ResultSrc; // Write-back result select
    logic Jump, Branch;  // Jump and branch signals
    logic ALUSrc;        // ALU source select (register/immediate)
    logic [1:0] ImmSrc;  // Immediate type select
    logic [2:0] ALUControl; // ALU operation

    // -------------------------
    // Datapath wires
    // -------------------------
    logic [31:0] SrcB;       // ALU second operand
    logic [31:0] ALUResult;  // ALU result
    logic [31:0] ReadData;   // Data memory read
    logic [31:0] PCTarget;   // Branch/Jump target
    logic [31:0] PCNext;     // Next PC value
    logic [31:0] ResultW;    // Write-back value
    logic [31:0] Instr;      // Current instruction
    logic [31:0] PC, PCPlus4; // Current PC and PC+4
    logic [31:0] rd1, rd2;    // Register file outputs
    logic [31:0] ImmExtend;   // Sign-extended immediate

    // -------------------------
    // PC selection logic
    // -------------------------
    assign PCSrc = (Branch & Zero) | Jump; // branch if Zero=1 and Branch=1 or Jump

    // PC+4 adder
    Adder PC_Plus_4(
        .A(PC),
        .B(32'd4),
        .Sum(PCPlus4)
    );

    // Branch / jump target adder
    Adder PC_Target(
        .A(PC),
        .B(ImmExtend),
        .Sum(PCTarget)
    );

    // PC next selection (PC+4 or branch/jump target)
    mux2 PC_Next(
        .d0(PCPlus4),
        .d1(PCTarget),
        .s(PCSrc),
        .y(PCNext)
    );

    // -------------------------
    // Program Counter
    // -------------------------
    program_counter ProgramCounter(
        .clk(clk),
        .reset(reset),
        .PCNext(PCNext),
        .PC(PC)
    );

    // -------------------------
    // Instruction Fetch
    // -------------------------
    instr_mem instruction_memory(
        .A(PC),
        .RD(Instr)
    );

    // -------------------------
    // Register File
    // -------------------------
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

    // -------------------------
    // Immediate Generation
    // -------------------------
    ExtendUnit Extend(
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExtend(ImmExtend)
    );

    // -------------------------
    // Control Unit
    // -------------------------
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

    // -------------------------
    // ALU operand selection
    // -------------------------
    mux2 Src_B(
        .d0(rd2),
        .d1(ImmExtend),
        .s(ALUSrc),
        .y(SrcB)
    );

    // -------------------------
    // ALU
    // -------------------------
    ALU ALU(
        .SrcA(rd1),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // -------------------------
    // Data Memory
    // -------------------------
    data_mem data_memory(
        .clk(clk),
        .we(MemWrite),
        .A(ALUResult),
        .WD(rd2),
        .ReadData(ReadData)
    );

    // -------------------------
    // Write-back selection
    // -------------------------
    mux3to1 result(
        .d0(ALUResult),
        .d1(ReadData),
        .d2(PCPlus4),
        .s(ResultSrc),
        .y(ResultW)
    );

endmodule
