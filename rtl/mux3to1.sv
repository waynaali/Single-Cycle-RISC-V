`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 09:41:40 AM
// Design Name: 
// Module Name: result_mux
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


module mux3to1(input logic [31:0] d0, d1, d2,
input logic [1:0] s,
output logic [31:0] y
    );
assign y=s[1]?d2:s[0]?d1:d0;
endmodule


