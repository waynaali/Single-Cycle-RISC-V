`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:26:20 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
        input logic [6:0] op,
        input logic [2:0] funct3,
        input logic funct7b5,
        output logic Jump,
        output logic [1:0] ResultSrc,
        output logic MemWrite, Branch,
        output logic [1:0] ImmSrc,
        output logic RegWrite, ALUSrc,
        output logic [2:0] ALUControl
    );
    logic [1:0] ALUOp;
    Alu_decoder ad(.opb5(op[5]),.funct3(funct3),.funct7b5(funct7b5),.ALUOp(ALUOp),.ALUControl(ALUControl));
    main_decoder md(.op(op),.RegWrite(RegWrite),.ResultSrc(ResultSrc), .ALUOp(ALUOp),.ImmSrc(ImmSrc),.ALUSrc(ALUSrc), .MemWrite(MemWrite),.Jump(Jump), .Branch(Branch));
 
endmodule
