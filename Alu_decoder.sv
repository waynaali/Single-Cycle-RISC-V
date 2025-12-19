`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 09:33:47 AM
// Design Name: ALU Decoder
// Module Name: Alu_decoder
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// ALU Control Decoder for RISC-V processor.
// Generates a 3-bit ALUControl signal based on ALUOp and instruction fields.
// Used for decoding R-type and I-type arithmetic instructions.
//
// Dependencies: Main Control Unit
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// ALUOp meanings:
// 00 → Load/Store instructions (ADD)
// 01 → Branch instructions (SUB)
// 10 → R-type / I-type instructions (decode funct fields)
//
// ALUControl encoding:
// 000 → ADD
// 001 → SUB
// 010 → AND
// 011 → OR
// 101 → Shift Right
//
//////////////////////////////////////////////////////////////////////////////////

module Alu_decoder(
    input  logic        opb5,        // Opcode bit [5] (used to identify R-type)
    input  logic [2:0]  funct3,      // funct3 field from instruction
    input  logic        funct7b5,     // funct7 bit [5] (distinguishes ADD/SUB)
    input  logic [1:0]  ALUOp,        // ALU operation code from main control unit
    output logic [2:0]  ALUControl    // Control signal sent to ALU
);

    // Detect SUB operation for R-type instructions
    logic RtypeSub;
    assign RtypeSub = opb5 & funct7b5;

    // Combinational ALU decoding logic
    always_comb
        case (ALUOp)

            // Load/Store instructions → ADD
            2'b00: ALUControl = 3'b000;

            // Branch instructions → SUB (for BEQ comparison)
            2'b01: ALUControl = 3'b001;

            // R-type / I-type arithmetic instructions
            default: case (funct3)

                // ADD / SUB
                3'b000:
                    if (RtypeSub)
                        ALUControl = 3'b001; // SUB
                    else
                        ALUControl = 3'b000; // ADD

                // Shift right
                3'b010: ALUControl = 3'b101;

                // OR
                3'b110: ALUControl = 3'b011;

                // AND
                3'b111: ALUControl = 3'b010;

                // Undefined operation
                default: ALUControl = 3'bxxx;
            endcase
        endcase

endmodule
