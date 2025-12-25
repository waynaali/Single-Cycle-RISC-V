`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:01:58 AM
// Design Name: Main Control Decoder
// Module Name: main_decoder
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   Main Control Unit for RISC-V Processor
//   Decodes the opcode field of the instruction and
//   generates high-level control signals for the datapath.
//
//   The generated signals control:
//   - Register file write
//   - ALU operand selection
//   - Memory access
//   - Immediate format
//   - Branch and jump decisions
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Works together with ALU Decoder to fully control ALU
//
//////////////////////////////////////////////////////////////////////////////////

module main_decoder(
    input  logic [6:0] op,          // Opcode field from instruction
    output logic       RegWrite,     // Register file write enable
    output logic [1:0] ResultSrc,    // Write-back source select
    output logic [1:0] ALUOp,        // ALU operation type
    output logic [1:0] ImmSrc,       // Immediate format select
    output logic       ALUSrc,        // ALU source select (reg/immediate)
    output logic       MemWrite,      // Data memory write enable
    output logic       Jump,          // Jump instruction indicator
    output logic       Branch         // Branch instruction indicator
);

    // Packed control signals vector
    // {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump}
    logic [10:0] controls;

    // Unpack control signals
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
            ResultSrc, Branch, ALUOp, Jump} = controls;

    // Main decoding logic based on opcode
    always_comb begin
        case (op)

            // Load word (LW)
            // RegWrite=1, ALUSrc=1, ResultSrc=01, ALUOp=00
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0;

            // Store word (SW)
            // MemWrite=1, ALUSrc=1, ImmSrc=S-type
            7'b0100011: controls = 11'b0_01_1_1_xx_0_00_0;

            // R-type instructions (ADD, SUB, AND, OR)
            // RegWrite=1, ALUSrc=0, ALUOp=10
            7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0;

            // Branch instructions (BEQ)
            // Branch=1, ALUOp=01, ImmSrc=B-type
            7'b1100011: controls = 11'b0_10_0_0_xx_1_01_0;

            // I-type arithmetic (ADDI, ANDI, ORI)
            // RegWrite=1, ALUSrc=1, ALUOp=10
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0;

            // Jump and Link (JAL)
            // Jump=1, RegWrite=1, ResultSrc=10
            7'b1101111: controls = 11'b1_11_x_0_10_0_xx_1;

            // Default (NOP / unsupported instruction)
            default:    controls = 11'b0_00_0_0_00_0_00_0;

        endcase
    end

endmodule
