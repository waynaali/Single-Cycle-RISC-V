`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2025 04:04:23 PM
// Design Name: 
// Module Name: testbench
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
module tb_risc;
logic clk, reset;
riscv_single RV(.clk(clk), .reset(reset));
always #5 clk=~clk;
initial begin
 reset = 1; clk=0;
   #20 reset = 0;
  #200 $finish;
end
endmodule
