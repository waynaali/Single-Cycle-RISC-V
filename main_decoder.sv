`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:01:58 AM
// Design Name: Main Decoder
// Module Name: main_decoder
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// Main Control Decoder for RISC-V processor.
// Decodes the opcode field to generate high-level control signals
// for the datapath.
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// This decoder handles instruction-type level control.
// ALU-specific operations are handled by the ALU decoder.
//
//////////////////////////////////////////////////////////////////////////////////

module main_decoder(
    input  logic [6:0] op,           // Opcode field from instruction
    output logic       RegWrite,      // Register file write enable
    output logic [1:0] ResultSrc,     // Write-back result source selector
    output logic [1:0] ALUOp,          // ALU operation type
    output logic [1:0] ImmSrc,         // Immediate type selector
    output logic       ALUSrc,          // ALU operand source selector
    output logic       MemWrite,       // Data memory write enable
    output logic       Jump,           // Jump control signal
    output logic       Branch          // Branch control signal
);

    // Packed control signal vector
    // {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump}
    logic [10:0] controls;

    // Assign packed control signals to individual outputs
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
            ResultSrc, Branch, ALUOp, Jump} = controls;

    // Combinational opcode decoding
    always_comb
        case (op)

            // Load (LW)
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0;

            // Store (SW)
            7'b0100011: controls = 11'b0_01_1_1_xx_0_00_0;

            // R-type arithmetic
            7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0;

            // Branch (BEQ, BNE)
            7'b1100011: controls = 11'b0_10_0_0_xx_1_01_0;

            // I-type arithmetic (ADDI, etc.)
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0;

            // Jump (JAL)
            7'b1101111: controls = 11'b1_11_x_0_10_0_xx_1;

            // Default (NOP / undefined)
            default:    controls = 11'b0_00_0_0_00_0_00_0;

        endcase

endmodule
