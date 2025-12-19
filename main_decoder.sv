`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:01:58 AM
// Design Name: 
// Module Name: main_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_decoder(input logic [6:0] op,
output logic RegWrite,
output logic [1:0] ResultSrc, ALUOp,
output logic [1:0] ImmSrc,
output logic ALUSrc, MemWrite,
output logic Jump, Branch
    );
    logic [10:0] controls;
    assign {RegWrite, ImmSrc, ALUSrc,MemWrite, ResultSrc, Branch, ALUOp, Jump}= controls;
    always_comb
    case(op)
    7'b0000011: controls=11'b1_00_1_0_01_0_00_0;
    7'b0100011: controls=11'b0_01_1_1_xx_0_00_0;
    7'b0110011: controls=11'b1_xx_0_0_00_0_10_0;
    7'b1100011: controls=11'b0_10_0_0_xx_1_01_0;
    7'b0010011: controls=11'b1_00_1_0_00_0_10_0;
    7'b1101111: controls=11'b1_11_x_0_10_0_xx_1;
    default: controls=11'b0_00_0_0_00_0_00_0;
    endcase 
endmodule
