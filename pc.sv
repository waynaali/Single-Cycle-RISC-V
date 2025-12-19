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
// Tool Versions: 
// Description: 
// 32-bit Program Counter (PC) module.
// Holds the address of the next instruction.
// Updates on rising clock edge or resets to 0 on reset signal.
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// PCNext → Next PC value from ALU/adder/mux
//
//////////////////////////////////////////////////////////////////////////////////

module program_counter(
    input  logic        clk,       // Clock signal
    input  logic        reset,     // Synchronous reset signal
    input  logic [31:0] PCNext,    // Next PC value
    output logic [31:0] PC         // Current PC value
);

    // Update PC on rising clock edge or reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'h00000000;   // Reset PC to 0
        else
            PC <= PCNext;         // Update PC to next value
    end

endmodule
