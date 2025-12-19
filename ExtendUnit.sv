`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 09:03:51 AM
// Design Name: Immediate Extension Unit
// Module Name: ExtendUnit
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// Immediate Generator (Sign Extension Unit) for RISC-V.
// Extracts and sign-extends immediate values from the instruction
// based on the instruction format selected by ImmSrc.
//
// Dependencies: Main Control Unit
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// ImmSrc Encoding:
// 00 → I-type  (ADDI, LW, JALR)
// 01 → S-type  (SW)
// 10 → B-type  (BEQ, BNE)
// 11 → J-type  (JAL)
//
//////////////////////////////////////////////////////////////////////////////////

module ExtendUnit(
    input  logic [31:0] Instr,       // Full 32-bit RISC-V instruction
    input  logic [1:0]  ImmSrc,       // Immediate type selector
    output logic [31:0] ImmExtend     // Sign-extended immediate output
);

    // Combinational immediate generation logic
    always_comb begin
        case (ImmSrc)

            // I-type immediate: instr[31:20]
            // Used in ADDI, LW, JALR
            2'b00: ImmExtend = {{20{Instr[31]}}, Instr[31:20]};

            // S-type immediate: instr[31:25] | instr[11:7]
            // Used in Store instructions (SW)
            2'b01: ImmExtend = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

            // B-type immediate:
            // instr[31], instr[7], instr[30:25], instr[11:8], 0
            // Used in Branch instructions (BEQ, BNE)
            2'b10: ImmExtend = {{20{Instr[31]}}, Instr[7],
                                 Instr[30:25], Instr[11:8], 1'b0};

            // J-type immediate:
            // instr[31], instr[19:12], instr[20], instr[30:21], 0
            // Used in JAL instruction
            2'b11: ImmExtend = {{12{Instr[31]}}, Instr[19:12],
                                 Instr[20], Instr[30:21], 1'b0};

            // Default case (safety)
            default: ImmExtend = 32'b0;
        endcase
    end

endmodule
