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
// Tool Versions: Vivado / ModelSim
// Description:
//   Immediate Generator for RISC-V Instructions
//   Extracts and sign-extends immediate fields from
//   different instruction formats based on ImmSrc.
//
//   Supported Immediate Types:
//   ImmSrc = 00 → I-type (ADDI, LW, etc.)
//   ImmSrc = 01 → S-type (SW)
//   ImmSrc = 10 → B-type (BEQ, BNE)
//   ImmSrc = 11 → J-type (JAL)
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Sign extension is used for all immediate formats
//
//////////////////////////////////////////////////////////////////////////////////

module ExtendUnit(
    input  logic [31:0] Instr,      // Full 32-bit instruction
    input  logic [1:0]  ImmSrc,     // Immediate select from control unit
    output logic [31:0] ImmExtend   // Sign-extended immediate output
);

    // Immediate generation logic
    always_comb begin
        case (ImmSrc)

            // I-type immediate: Instr[31:20]
            // Used in ADDI, LW, JALR
            2'b00: ImmExtend = {{20{Instr[31]}}, Instr[31:20]};

            // S-type immediate: Instr[31:25] & Instr[11:7]
            // Used in SW
            2'b01: ImmExtend = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

            // B-type immediate (branch offset)
            // Used in BEQ, BNE
            // LSB is always 0 (word aligned)
            2'b10: ImmExtend = {{20{Instr[31]}},
                                 Instr[7],
                                 Instr[30:25],
                                 Instr[11:8],
                                 1'b0};

            // J-type immediate (jump offset)
            // Used in JAL
            // LSB is always 0 (word aligned)
            2'b11: ImmExtend = {{12{Instr[31]}},
                                 Instr[19:12],
                                 Instr[20],
                                 Instr[30:21],
                                 1'b0};

            // Default safe value
            default: ImmExtend = 32'b0;

        endcase
    end

endmodule
