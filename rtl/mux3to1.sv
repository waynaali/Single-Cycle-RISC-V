`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 09:41:40 AM
// Design Name: 3-to-1 Multiplexer
// Module Name: mux3to1
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   32-bit 3-to-1 Multiplexer
//   Selects one of three 32-bit inputs based on 2-bit select signal.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Commonly used in datapath for:
//   - Selecting write-back data (ALU result, Memory, PC+4)
//
//////////////////////////////////////////////////////////////////////////////////

module mux3to1(
    input  logic [31:0] d0,  // Input 0
    input  logic [31:0] d1,  // Input 1
    input  logic [31:0] d2,  // Input 2
    input  logic [1:0]  s,   // 2-bit select signal
    output logic [31:0] y    // Selected output
);

    // Combinational multiplexer logic
    // Priority: s=2 → d2, s=1 → d1, else d0
    assign y = s[1] ? d2 : s[0] ? d1 : d0;

endmodule
