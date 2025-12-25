`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:26:20 AM
// Design Name: Control Unit
// Module Name: control_unit
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   Top-Level Control Unit for RISC-V Processor
//   This module combines:
//     1) Main Decoder  → Generates high-level control signals
//     2) ALU Decoder   → Generates ALUControl signal
//
//   Based on opcode, funct3, and funct7 fields, it
//   controls datapath elements such as:
//   - Register File
//   - ALU
//   - Data Memory
//   - PC update logic
//
// Dependencies:
//   - main_decoder
//   - Alu_decoder
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Designed for Single-Cycle / Pipelined RISC-V
//
//////////////////////////////////////////////////////////////////////////////////

module control_unit(
    input  logic [6:0] op,          // Opcode field from instruction
    input  logic [2:0] funct3,      // funct3 field from instruction
    input  logic       funct7b5,    // funct7 bit[5] (used for SUB)
    output logic       Jump,         // Jump control signal (JAL / JALR)
    output logic [1:0] ResultSrc,    // Selects write-back result source
    output logic       MemWrite,     // Data memory write enable
    output logic       Branch,       // Branch instruction indicator
    output logic [1:0] ImmSrc,       // Immediate format selector
    output logic       RegWrite,     // Register file write enable
    output logic       ALUSrc,       // ALU source select (reg or immediate)
    output logic [2:0] ALUControl    // Final ALU operation control
);

    // Intermediate ALUOp signal between main decoder and ALU decoder
    logic [1:0] ALUOp;

    // ALU Decoder
    // Generates ALUControl based on ALUOp, funct3, and funct7
    Alu_decoder ad (
        .opb5(op[5]),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    // Main Decoder
    // Generates high-level control signals from opcode
    main_decoder md (
        .op(op),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .ALUOp(ALUOp),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .Jump(Jump),
        .Branch(Branch)
    );

endmodule
