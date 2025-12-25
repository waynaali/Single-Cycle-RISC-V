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
// Tool Versions: Vivado / ModelSim
// Description:
//   32-bit 2-to-1 Multiplexer
//   Selects one of two 32-bit inputs based on select signal.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Used extensively in datapath for:
//   - ALU source selection
//   - Write-back result selection
//   - PC source selection
//
//////////////////////////////////////////////////////////////////////////////////

module mux2 (
    input  logic [31:0] d0,   // Input 0
    input  logic [31:0] d1,   // Input 1
    input  logic        s,    // Select signal
    output logic [31:0] y     // Selected output
);

    // Combinational multiplexer logic
    // s = 0 → y = d0
    // s = 1 → y = d1
    assign y = s ? d1 : d0;

endmodule
