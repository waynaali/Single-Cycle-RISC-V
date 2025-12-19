`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: Register File
// Module Name: register_file
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: 
// Description: 
// 32x32-bit Register File for RISC-V.
// Two read ports and one write port.
// Register x0 is hardwired to 0.
// Initial values of registers are set to 4 for simulation.
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - A1, A2: read addresses
// - A3: write address
// - wd3: data to write
// - we: write enable
//
//////////////////////////////////////////////////////////////////////////////////

module register_file(
    input  logic        clk,   // Clock
    input  logic [4:0]  A1,    // Read register 1 address
    input  logic [4:0]  A2,    // Read register 2 address
    input  logic [4:0]  A3,    // Write register address
    input  logic [31:0] wd3,   // Data to write
    input  logic        we,    // Write enable
    output logic [31:0] rd1,   // Read data 1
    output logic [31:0] rd2    // Read data 2
);

    // Register array: 32 registers of 32 bits
    logic [31:0] rf [0:31]; 

    // Initialize registers to 4 (for simulation purposes)
    initial begin
        for (int i = 0; i < 32; i++) begin
            rf[i] = 32'd4;
        end
    end

    // Write logic: synchronous, write enabled, x0 is always 0
    always_ff @(posedge clk) begin
        if (we && A3 != 0) begin
            rf[A3] <= wd3;
        end
    end

    // Read logic: combinational, x0 always returns 0
    assign rd1 = (A1 != 0) ? rf[A1] : 32'b0; 
    assign rd2 = (A2 != 0) ? rf[A2] : 32'b0; 

endmodule
