`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 01:28:57 PM
// Design Name: 
// Module Name: mem
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


module imem(
   input [7:0] pc,
   input [31:0] din,
   input clk,
   input wr,
   input rd,
   output reg [31:0] dout 
);

reg [31:0] mem[255:0]; //memory array

always @ (posedge clk) begin
   if (wr) begin
      mem[pc] <= din;
      $display ("IMEM: writing to imem location %h with data=%h", pc, din); 
   end
   if (rd) begin
      dout <= mem[pc]; 
      $display ("IMEM: read location %h with data=%h", pc, mem[pc]); 
   end else begin
      dout <= 'h0;
   end
end

endmodule

module rf(
   input clk,
   input wr, 
   input [5:0] rs, //rd addr1
   input [5:0] rt, //rd addr2
   input [5:0] rd, //wr addr
   input [31:0] din, 
   output reg [31:0] dout_rs,
   output reg [31:0] dout_rt
);

reg [31:0] mem[63:0]; 

always @ (posedge clk) begin
   if (wr) begin
      mem[rd] <= din; 
      $display ("RF: writing to RF location %d with data=%h", rd, mem[rd]); 
   end
end 

assign dout_rs = mem[rs];
assign dout_rt = mem[rt];

endmodule


module dmem (
   input [31:0] addr, //same as rs_dout2
   input compute_max,
   input wr,
   input rd,
   input clk, 
   input [31:0] din, //same as rt_dout2
   output reg [31:0] dout
);

reg [31:0] mem [2**16 - 1:0]; //mem array with 2**16 locations each with 32 bits

always @ (posedge clk) begin
   if (wr) begin
      mem[addr[15:0]] <= din;
      $display ("DMEM: writing to DMEM location %d with data=%h", addr[15:0], din); 
   end
end

   always @ (negedge clk)
   begin
     if (rd)
        dout <= mem[addr[15:0]];
     else if (compute_max)
        dout <= get_max(addr, addr+din);
     else 
        dout <= 32'h0;
   end

   function [31:0] get_max(bit[31:0] start_addr, bit [31:0] end_addr);
      bit[31:0] max;

      $display("get_max called with start_addr %d and end addr %d", start_addr, end_addr);
      max = mem[start_addr];
      for (int i = start_addr; i < end_addr; i++) begin
         $display ("get_max location %0d value %0h", i, mem[i]);
         if (mem[i] > max) begin
            max = mem[i];
         end
      end

      $display("get_max returns value 0x%0h", max);
      return(max);
   endfunction


endmodule 






