`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 02:26:06 PM
// Design Name: 
// Module Name: mux
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


module mux(d1, d2, d3, d4, d5, d6, sel, out);
//declare inputs and output
input d1, d2, d3, d4, d5, d6;
input [2:0] sel; 
output reg out; 

always@(d1, d2, d3, d4, d5, d6, sel)
begin
//check various input values for select
    if (sel == 3'b000)
        out <= d1;
    else if (sel == 3'b001)
        out <= d2;
    else if (sel == 3'b010)
        out <= d3;
    else if (sel == 3'b011)
        out <= d4;
    else if (sel == 3'b100)
        out <= d5; 
    else
        out <= d6; 
end

endmodule

module two_to_1_mux(
   input [31:0] a,
   input [31:0] b,
   input sel,
   output [31:0] out
);
  //2-to-1 mux
  assign out = sel ? a : b; 
endmodule

module three_to_1_mux(
   input [31:0] a,
   input [31:0] b,
   input [31:0] c,
   input [1:0] sel,
   output reg [31:0] out
);
  //3-to-1 mux
  always @ (a or b or c or sel) begin
     $display ("three_to_1_mux sel is %d a=%d b=%d c=%d", sel, a, b, c);
     case (sel)
       2'b00 : out <= a;
       2'b01 : out <= b;
       2'b10 : out <= c;
       2'b11 : out <= 0;//dont care
     endcase
  end

endmodule
