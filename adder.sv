`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Simple 32-bit Adder
// Used for PC increment (PC + 4) or branch address calculation
//////////////////////////////////////////////////////////////////////////////////

module Adder(
    input  logic [31:0] A,    // First 32-bit operand
    input  logic [31:0] B,    // Second 32-bit operand
    output logic [31:0] Sum   // Output sum
);

    // Combinational addition
    assign Sum = A + B;

endmodule
