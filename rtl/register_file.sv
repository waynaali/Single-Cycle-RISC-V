`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2025
// Design Name: Register File
// Module Name: register_file
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   32x32-bit Register File for RISC-V CPU
//   - 32 registers (x0 - x31)
//   - Two asynchronous read ports (rd1, rd2)
//   - One synchronous write port (wd3, we)
//   - x0 is hardwired to 0
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//   Initialized registers to 4 for simulation purposes
//
//////////////////////////////////////////////////////////////////////////////////

module register_file(
    input  logic        clk,      // Clock signal
    input  logic [4:0]  A1,       // Read register 1 address
    input  logic [4:0]  A2,       // Read register 2 address
    input  logic [4:0]  A3,       // Write register address
    input  logic [31:0] wd3,      // Write data
    input  logic        we,       // Write enable
    output logic [31:0] rd1,      // Read data 1
    output logic [31:0] rd2       // Read data 2
);

    // Register file array
    logic [31:0] rf [0:31];

    // Initialize registers (simulation only)
    initial begin
        for (int i = 0; i < 32; i++) begin
            rf[i] = 32'd4;  // Example initial value
        end
    end

    // Synchronous write operation
    // x0 is always 0, cannot be written
    always_ff @(posedge clk) begin
        if (we && A3 != 0) begin
            rf[A3] <= wd3;
        end
    end

    // Asynchronous read operations
    // Reading x0 always returns 0
    assign rd1 = (A1 != 0) ? rf[A1] : 32'b0;
    assign rd2 = (A2 != 0) ? rf[A2] : 32'b0;

endmodule
