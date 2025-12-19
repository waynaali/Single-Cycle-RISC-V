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
// Tool Versions: 
// Description: 
// Read-only instruction memory.
// Stores RISC-V instructions loaded from a hex file using $readmemh.
// Provides word-aligned instruction fetch based on program counter.
//
// Dependencies: Instruction memory file (inst.mem)
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Memory Size: 64 words (256 bytes)
// Addressing: Word-aligned using A[31:2]
//
//////////////////////////////////////////////////////////////////////////////////

module instr_mem(
    input  logic [31:0] A,    // Program counter (instruction address)
    output logic [31:0] RD    // Instruction read data
);

    // Instruction memory array (64 words × 32 bits)
    logic [31:0] mem [63:0];

    // Load instructions from hex file at simulation start
    initial begin
        $readmemh("inst.mem", mem);
    end

    // Asynchronous read (instruction fetch)
    // Word-aligned addressing using PC[31:2]
    assign RD = mem[A[31:2]];

endmodule
