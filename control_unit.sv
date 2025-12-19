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
// Tool Versions: 
// Description: 
// Top-level Control Unit for RISC-V processor.
// Combines the Main Decoder and ALU Decoder to generate all control signals
// required by the datapath.
//
// Dependencies:
//  - main_decoder
//  - Alu_decoder
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// This module separates high-level instruction decoding (opcode-based)
// from ALU-specific decoding (funct3/funct7-based).
//
//////////////////////////////////////////////////////////////////////////////////

module control_unit(
    input  logic [6:0] op,           // Opcode field from instruction
    input  logic [2:0] funct3,        // funct3 field from instruction
    input  logic       funct7b5,      // funct7 bit [5] (used for ADD/SUB)
    output logic       Jump,           // Jump control signal (JAL/JALR)
    output logic [1:0] ResultSrc,      // Selects source for write-back stage
    output logic       MemWrite,       // Data memory write enable
    output logic       Branch,         // Branch enable signal
    output logic [1:0] ImmSrc,         // Immediate type selector
    output logic       RegWrite,       // Register file write enable
    output logic       ALUSrc,          // Selects ALU operand source
    output logic [2:0] ALUControl      // Final ALU control signal
);

    // Intermediate ALU operation signal from main decoder
    logic [1:0] ALUOp;

    // ALU Decoder:
    // Generates ALUControl based on funct fields and ALUOp
    Alu_decoder ad (
        .opb5(op[5]),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    // Main Decoder:
    // Decodes opcode to generate high-level control signals
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
