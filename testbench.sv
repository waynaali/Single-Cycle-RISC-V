`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2025 04:04:23 PM
// Design Name: Testbench for Single-Cycle RISC-V
// Module Name: tb_risc
// Project Name: RISC-V Processor
// Target Devices: Simulation
// Tool Versions: 
// Description: 
// Simple testbench to simulate the single-cycle RISC-V processor.
// Generates clock, reset, and runs the processor for a limited time.
//
// Dependencies: riscv_single
// 
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module tb_risc;

    // Clock and reset signals
    logic clk, reset;

    // Instantiate the RISC-V processor
    riscv_single RV(
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Release reset after 20 ns
        #20 reset = 0;

        // Run simulation for 200 ns, then finish
        #200 $finish;
    end

endmodule
