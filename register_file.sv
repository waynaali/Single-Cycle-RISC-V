`timescale 1ns / 1ps
module register_file ( input logic clk, 
input logic [4:0] A1,
input logic [4:0] A2,
input logic [4:0] A3,
input logic [31:0] wd3,
input logic we,
output logic [31:0] rd1,
output logic [31:0] rd2); 
logic [31:0] rf [0:31]; 
initial begin
    for (int i = 0; i < 32; i++) begin
        rf[i] = 32'd4;
    end
end

always_ff @(posedge clk) begin
   if (we && A3 != 0) begin
        rf[A3] <= wd3;
   end
   end
 assign rd1 = (A1 != 0) ? rf[A1] : 32'b0; 
 assign rd2 = (A2 != 0) ? rf[A2] : 32'b0; 
 endmodule 

   