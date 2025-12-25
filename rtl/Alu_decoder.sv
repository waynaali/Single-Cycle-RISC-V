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
// Tool Versions: Vivado / ModelSim
// Description:
//   ALU Control Decoder for RISC-V Processor
//   Generates 3-bit ALUControl signal based on:
//   - ALUOp (from main control unit)
//   - funct3 and funct7 fields of instruction
//   - op[5] bit (to distinguish R-type vs I-type)
//
//   This module decides which ALU operation
//   (ADD, SUB, AND, OR, SHIFT, etc.) to perform.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Used for R-type, I-type, Load/Store, and Branch instructions
//
//////////////////////////////////////////////////////////////////////////////////

module Alu_decoder(
    input  logic        opb5,       // Instruction opcode bit [5]
    input  logic [2:0]  funct3,     // funct3 field from instruction
    input  logic        funct7b5,   // funct7 bit [5] (used for SUB)
    input  logic [1:0]  ALUOp,      // ALU operation type from main control unit
    output logic [2:0]  ALUControl  // Final ALU control signal
);

    // Detect R-type subtraction instruction
    // RtypeSub = 1 when instruction is R-type AND funct7[5] = 1 (SUB)
    logic RtypeSub;
    assign RtypeSub = opb5 & funct7b5;

    // ALU control decoding logic
    always_comb begin
        case (ALUOp)

            // ALUOp = 00 → Load / Store instructions
            // Always perform ADD
            2'b00: ALUControl = 3'b000;

            // ALUOp = 01 → Branch instructions (e.g., BEQ)
            // Perform SUB to compare operands
            2'b01: ALUControl = 3'b001;

            // ALUOp = 10 → R-type / I-type instructions
            default: begin
                case (funct3)

                    // ADD / SUB
                    3'b000: begin
                        if (RtypeSub)
                            ALUControl = 3'b001; // SUB
                        else
                            ALUControl = 3'b000; // ADD
                    end

                    // Shift right
                    3'b010: ALUControl = 3'b101;

                    // OR operation
                    3'b110: ALUControl = 3'b011;

                    // AND operation
                    3'b111: ALUControl = 3'b010;

                    // Undefined funct3
                    default: ALUControl = 3'bxxx;

                endcase
            end
        endcase
    end

endmodule
