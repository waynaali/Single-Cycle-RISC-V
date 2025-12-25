`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2025 01:47:18 PM
// Design Name: 
// Module Name: pc
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

module program_counter(
    input  logic        clk, reset,
    input  logic [31:0] PCNext,
    output logic [31:0] PC
);

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        PC <= 32'h00000000;
    else
        PC <= PCNext;
end

endmodule