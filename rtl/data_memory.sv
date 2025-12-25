`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 09:56:13 AM
// Design Name: Data Memory
// Module Name: data_mem
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   32-bit Data Memory Module
//   Supports word-aligned load and store operations.
//   Read is asynchronous (combinational).
//   Write is synchronous (on positive clock edge).
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Memory size: 64 words (256 bytes)
//   Address is word-aligned using A[31:2]
//
//////////////////////////////////////////////////////////////////////////////////

module data_mem(
    input  logic        clk,        // Clock signal
    input  logic        we,         // Write enable (MemWrite)
    input  logic [31:0] A,          // Address from ALU
    input  logic [31:0] WD,         // Write data from register file
    output logic [31:0] ReadData    // Data read from memory
);

    // Data memory array (64 x 32-bit words)
    logic [31:0] dm [63:0];
    integer i;

    // Initialize memory to zero (simulation only)
    initial begin
        for (i = 0; i < 64; i = i + 1)
            dm[i] = 32'd0;
    end

    // Asynchronous read (for LW)
    // Word-aligned addressing (ignore lowest 2 bits)
    assign ReadData = dm[A[31:2]];

    // Synchronous write (for SW)
    always_ff @(posedge clk) begin
        if (we)
            dm[A[31:2]] <= WD;
    end

endmodule
