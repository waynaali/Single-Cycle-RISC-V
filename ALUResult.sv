`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2025 04:59:58 PM
// Design Name: 
// Module Name: ALUResult
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


module ALU(input logic [31:0] SrcA, SrcB,
input logic [2:0] ALUControl,
output logic [31:0] ALUResult,
output logic Zero);
always_comb begin
case (ALUControl)
3'b000: ALUResult=SrcA+SrcB;
3'b001: ALUResult=SrcA-SrcB;
3'b101: ALUResult=SrcA>>SrcB;
3'b011: ALUResult=SrcA|SrcB;
3'b010: ALUResult=SrcA&SrcB;
default: ALUResult= 32'b0;
endcase
Zero=(ALUResult==0)?1'b1:1'b0;
end
endmodule
