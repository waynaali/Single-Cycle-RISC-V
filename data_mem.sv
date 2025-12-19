`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 09:56:13 AM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
input logic clk, we,
input logic [31:0] A, WD,
output logic [31:0] ReadData
    );
  logic [31:0] dm [63:0];
  integer i;
  initial begin
      for (i = 0; i < 64; i = i + 1) dm[i] = 32'd0;
  end

  assign ReadData=dm[A[31:2]];
  always_ff @(posedge clk)
  if (we)
  dm[A[31:2]]<=WD;  
endmodule
