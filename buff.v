`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 03:31:48 PM
// Design Name: 
// Module Name: buff
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


module pc_buff(
   input clk,
   input [7:0] pc_in,
   output reg [7:0] pc_out
);

always @ (posedge clk) begin
   pc_out <= pc_in;
end
endmodule

module buff_if(

//declaring inputs and outputs
  input clk,
  input [31:0] inst_in,
  input [7:0] addr_in,
  output reg [31:0] inst_out,
  output reg [7:0] addr_out
);

//sample on positive clockedge 
always @ (posedge clk) begin

//outputs match inputs 
  addr_out <= addr_in;
  inst_out <= inst_in;

end

endmodule

module buff_id(
  input clk,
  input reg_wr_in,
  input mem_to_reg_in,
  input pc_to_reg_in,
  input [3:0] alu_op_in,
  input mem_read_in,
  input mem_wr_in,
  input branch_neg_in,
  input branch_zero_in,
  input jump_mem_in,
  input jump_in,
  input compute_max_in,
  input [31:0] dout_rs_in,
  input [31:0] dout_rt_in,
  input [5:0] rd_in,
  input [31:0] offset_in, 
  output reg reg_wr_out,
  output reg mem_to_reg_out,
  output reg pc_to_reg_out,
  output reg [3:0] alu_op_out,
  output reg mem_read_out,
  output reg mem_wr_out,
  output reg branch_neg_out,
  output reg branch_zero_out,
  output reg jump_mem_out,
  output reg jump_out,
  output reg compute_max_out,
  output reg [31:0] dout_rs_out,
  output reg [31:0] dout_rt_out,
  output reg [5:0] rd_out,
  output reg [31:0] offset_out
);

always @ (posedge clk) begin
  reg_wr_out <= reg_wr_in;
  mem_to_reg_out <= mem_to_reg_in;
  pc_to_reg_out <= pc_to_reg_in;
  alu_op_out <= alu_op_in;
  mem_read_out <= mem_read_in;
  mem_wr_out <= mem_wr_in;
  dout_rs_out <= dout_rs_in;
  dout_rt_out <= dout_rt_in;
  rd_out <= rd_in;
  offset_out <= offset_in;
  branch_neg_out <= branch_neg_in;
  branch_zero_out <= branch_zero_in;
  jump_mem_out <= jump_mem_in;
  compute_max_out <= compute_max_in; 
  jump_out <= jump_in; 


end

endmodule

module buff_ex(
  input clk,
  input z_in,
  input n_in,
  input reg_wr_in,
  input pc_to_reg_in,
  input branch_neg_in,
  input branch_zero_in,
  input jump_in,
  input jump_mem_in,
  input [31:0] alu_result_in,
  input [31:0] offset_in,
  input [31:0] dmem_dout_in,
  input [31:0] rs_dout_in,
  input [5:0] rd_in,
  input mem_to_reg_in,
  output reg z_out,
  output reg n_out,
  output reg reg_wr_out,
  output reg pc_to_reg_out,
  output reg branch_neg_out,
  output reg branch_zero_out,
  output reg jump_out,
  output reg jump_mem_out,
  output reg [31:0] dmem_dout_out,
  output reg [5:0] rd_out,
  output reg [5:0] rs_dout_out,
  output reg [31:0] alu_result_out,
  output reg [31:0] offset_out
  output reg mem_to_reg_out
 
);

always @ (posedge clk) begin

  z_out <= z_in;
  n_out <= n_in;
  reg_wr_out <= reg_wr_in;
  pc_to_reg_out <= pc_to_reg_in;
  branch_neg_out <= branch_neg_in;
  branch_zero_out <= branch_zero_in;
  jump_out <= jump_in;
  rs_dout_out <= rs_dout_in;
  jump_mem_out <= jump_mem_in;
  alu_result_out <= alu_result_in;
  offset_out <= offset_in;
  dmem_dout_out <= dmem_dout_in;
  mem_to_reg_out <= mem_to_reg_in;
  rd_out <= rd_in; 

end

endmodule
