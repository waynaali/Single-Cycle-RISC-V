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
// Tool Versions: 
// Description: 
// 32-bit word-addressable data memory.
// Supports synchronous write and asynchronous read.
// Used for load and store instructions (LW / SW).
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Memory Size: 64 words (256 bytes)
// Addressing: Word-aligned (A[31:2])
//
//////////////////////////////////////////////////////////////////////////////////

module data_mem(
    input  logic        clk,        // Clock signal
    input  logic        we,         // Write enable (MemWrite)
    input  logic [31:0] A,          // Memory address
    input  logic [31:0] WD,         // Write data
    output logic [31:0] ReadData    // Read data output
);

    // Data memory array: 64 words of 32 bits
    logic [31:0] dm [63:0];
    integer i;

    // Initialize memory contents to zero
    initial begin
        for (i = 0; i < 64; i = i + 1)
            dm[i] = 32'd0;
    end

    // Asynchronous read (combinational)
    // Word-aligned addressing using A[31:2]
    assign ReadData = dm[A[31:2]];

    // Synchronous write on rising clock edge
    always_ff @(posedge clk) begin
        if (we)
            dm[A[31:2]] <= WD;
    end

endmodule
