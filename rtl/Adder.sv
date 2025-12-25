`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: Adder
// Module Name: Adder
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   32-bit Combinational Adder
//   Performs addition of two 32-bit inputs.
//   Commonly used for PC increment (PC + 4),
//   address calculation, and arithmetic operations
//   in the processor datapath.
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   This is a purely combinational module.
//   No clock or reset is required.
//
//////////////////////////////////////////////////////////////////////////////////

module Adder(
    input  logic [31:0] A,    // First 32-bit operand
    input  logic [31:0] B,    // Second 32-bit operand
    output logic [31:0] Sum   // Sum of A and B
);

    // Continuous assignment for addition
    assign Sum = A + B;

endmodule
