`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2025
// Design Name: RISC-V Single-Cycle CPU Testbench
// Module Name: tb_risc
// Project Name: RISC-V Processor
// Target Devices: FPGA / ASIC
// Tool Versions: Vivado / ModelSim
// Description:
//   Simple testbench for the single-cycle RISC-V processor
//   Generates clock and reset signals and simulates the CPU.
//
// Dependencies:
//   - riscv_single.v
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

module tb_risc;

    // Clock and reset signals
    logic clk, reset;

    // Instantiate the single-cycle RISC-V CPU
    riscv_single RV(
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period (50 MHz)
    always #5 clk = ~clk;

    // Initial block for reset and simulation control
    initial begin
        // Apply reset
        reset = 1;
        clk   = 0;

        // Hold reset for 2 clock cycles
        #20 reset = 0;

        // Run simulation for 200 ns
        #200 $finish;
    end

endmodule
