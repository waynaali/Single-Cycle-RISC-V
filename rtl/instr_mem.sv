`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2025 03:13:45 PM
// Design Name: Instruction Memory
// Module Name: instr_mem
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   32-bit Instruction Memory (Read-Only)
//   Stores program instructions and provides instruction
//   corresponding to the Program Counter (PC).
//   Read operation is asynchronous.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Memory size: 64 words (256 bytes)
//   Program is loaded using $readmemh
//   Address is word-aligned using A[31:2]
//
//////////////////////////////////////////////////////////////////////////////////

module instr_mem(
    input  logic [31:0] A,    // Address (Program Counter)
    output logic [31:0] RD    // Instruction read from memory
);

    // Instruction memory array (64 x 32-bit words)
    logic [31:0] mem [63:0];

    // Load instructions from file (simulation only)
    initial begin
        $readmemh("inst.mem", mem);
    end

    // Asynchronous instruction read
    // Word-aligned addressing (ignore lowest 2 bits)
    assign RD = mem[A[31:2]];

endmodule
