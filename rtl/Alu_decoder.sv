`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 09:33:47 AM
// Design Name: 
// Module Name: Alu_decoder
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


module Alu_decoder(input logic opb5,
input logic [2:0] funct3,
input logic funct7b5,
input  logic [1:0] ALUOp,
output logic [2:0] ALUControl
    );
    logic RtypeSub;
    assign RtypeSub=opb5&funct7b5;
always_comb
case(ALUOp)
2'b00: ALUControl=3'b000;
2'b01: ALUControl=3'b001;
default: case(funct3)
3'b000: if (RtypeSub)
ALUControl=3'b001;
else
ALUControl=3'b000;
3'b010: ALUControl=3'b101;
3'b110:ALUControl=3'b011;
3'b111: ALUControl=3'b010;
default: ALUControl= 3'bxx;
endcase
endcase
endmodule

