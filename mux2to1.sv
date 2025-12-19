`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2025 03:41:13 PM
// Design Name: 2-to-1 Multiplexer
// Module Name: mux2
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// 32-bit 2-to-1 multiplexer.
// Selects one of two 32-bit inputs based on select signal `s`.
// Commonly used throughout the datapath for control-based selection.
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// s = 0 → y = d0
// s = 1 → y = d1
//
//////////////////////////////////////////////////////////////////////////////////

module mux2 (
    input  logic [31:0] d0,   // Input 0
    input  logic [31:0] d1,   // Input 1
    input  logic        s,    // Select line
    output logic [31:0] y     // Output
);

    // Combinational selection
    assign y = s ? d1 : d0;

endmodule
