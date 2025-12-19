`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2025 04:59:58 PM
// Design Name: ALU
// Module Name: ALU
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// 32-bit Arithmetic Logic Unit (ALU).
// Performs arithmetic and logical operations based on ALUControl.
// Generates Zero flag for branch decision logic.
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Supported Operations:
// ALUControl = 000 : Addition
// ALUControl = 001 : Subtraction
// ALUControl = 010 : Bitwise AND
// ALUControl = 011 : Bitwise OR
// ALUControl = 101 : Logical Right Shift
//
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input  logic [31:0] SrcA,      // First operand
    input  logic [31:0] SrcB,      // Second operand
    input  logic [2:0]  ALUControl,// Control signal selecting ALU operation
    output logic [31:0] ALUResult, // Result of ALU operation
    output logic        Zero       // Zero flag (1 if ALUResult == 0)
);

    // Combinational ALU logic
    always_comb begin
        case (ALUControl)

            // Addition
            3'b000: ALUResult = SrcA + SrcB;

            // Subtraction
            3'b001: ALUResult = SrcA - SrcB;

            // Logical right shift (shift amount = SrcB)
            3'b101: ALUResult = SrcA >> SrcB;

            // Bitwise OR
            3'b011: ALUResult = SrcA | SrcB;

            // Bitwise AND
            3'b010: ALUResult = SrcA & SrcB;

            // Default case (safety)
            default: ALUResult = 32'b0;
        endcase

        // Zero flag is set if ALUResult equals zero
        Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
    end

endmodule
