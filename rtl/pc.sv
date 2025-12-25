`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2025 01:47:18 PM
// Design Name: Program Counter
// Module Name: program_counter
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   32-bit Program Counter (PC)
//   Holds the address of the current instruction.
//   On each clock edge, updates PC with PCNext.
//   Supports synchronous reset to 0.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Used in IF stage of the processor
//
//////////////////////////////////////////////////////////////////////////////////

module program_counter(
    input  logic        clk,       // Clock signal
    input  logic        reset,     // Synchronous reset signal
    input  logic [31:0] PCNext,    // Next PC value
    output logic [31:0] PC         // Current PC value
);

    // PC update logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'h00000000;  // Reset PC to 0
        else
            PC <= PCNext;        // Update PC with next value
    end

endmodule
