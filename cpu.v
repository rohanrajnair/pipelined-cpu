`include "mem.v"
`include "mux.v"
`include "alu.v"
`include "buff-1.v"



module cpu(
   input clk,
   input reset 
);

//initialize/update pc 
reg [7:0] pc, pc2, pc3;
reg [31:0] if_buff_id_instr;
reg [31:0] imem_if_buff_instr;
reg [31:0] rs_dout3;

//these are remembered from the last ALU operation. Whether N and Z were
//set
reg n_reg, z_reg;

wire logicout, jump_mem3;
reg jump3;
reg [31:0] dmem_dout2;
reg [31:0] write_back_mux_out;

reg [31:0] offset3;
always @ (posedge clk)
   begin
      bit[7:0] pc_tmp;
      if (reset)
         pc_tmp = 8'b0;
      else if (jump3 |logicout) begin
         pc_tmp = rs_dout3;
      end else if (jump_mem3) begin
         pc_tmp = dmem_dout2;
      end else
         pc_tmp = pc +'h1;   


     $display ("pc value is %0d", pc_tmp);
     pc <= pc_tmp;
   end 




imem imem_inst(.clk(clk),
               .wr(1'b0),
               .rd (~reset),
               .pc(pc),               
               .din(32'b0),
               .dout(imem_if_buff_instr)
);

pc_buff pc_buff_inst(.clk(clk),
                     .pc_in(pc),
                     .pc_out(pc2)
);

buff_if buff_if_inst(.clk(clk),
                   .inst_in(imem_if_buff_instr),
                   .addr_in(pc2),
                   .inst_out(if_buff_id_instr),
                   .addr_out(pc3)
);



typedef enum { NOP=4'h0, MAX, UNUSED, STORE, ADD, INC, NEG, SUB, J, BRZ, JM, BRN, UNUSED1, UNUSED2, LOAD, SAVE_PC } opcode_t;


opcode_t opcode;
reg [5:0] rd;
reg [5:0] rs;
reg [5:0] rt; 
//decoding instruction
always @ (if_buff_id_instr) begin
   if (reset) begin
     opcode <= NOP;
     rd <= 'h0;
     rs <= 'h0;
     rt <= 'h0;
   end else begin
     opcode <= if_buff_id_instr[31:28];
     rd <= if_buff_id_instr[27:22];
     rs <= if_buff_id_instr[21:16];
     rt <= if_buff_id_instr[15:10];
   end

end

always @ (opcode) begin
   print_decoded_instr();
end

function print_decoded_instr();
  string opcodes[16];
  opcodes [0] = "NOP";
  opcodes [1] = "MAX";
  opcodes [2] = "UNUSED";
  opcodes [3] = "STORE";
  opcodes [4] = "ADD";
  opcodes [5] = "INC";
  opcodes [6] = "NEG";
  opcodes [7] = "SUB";
  opcodes [8] = "J";
  opcodes [9] = "BRZ";
  opcodes [10] = "JM";
  opcodes [11] = "BRN";
  opcodes [12] = "UNUSED";
  opcodes [13] = "UNUSED";
  opcodes [14] = "LOAD";
  opcodes [15] = "SAVE_PC";

  $display("Operation: %s rs: %0d rt: %0d rd: %0d", opcodes[opcode], rs, rt, rd);
endfunction


reg [3:0] alu_op;
reg reg_wr;
reg mem_to_reg;
reg pc_to_reg;
reg mem_read;
reg mem_wr;
reg branch_neg;
reg branch_zero;
reg jump;
reg jump_mem;


reg [31:0] rs_dout;
reg [31:0] rt_dout;
reg [5:0] rf_id_buff_rd;
reg [31:0] offset;
reg [31:0] sign_xtnd_rs;
reg reg_wr2;
reg mem_to_reg2;
reg [3:0] alu_op2;
reg mem_read2;
reg mem_wr2;

reg compute_max;
reg compute_max2;

//control logic 
always @ (opcode or reset) begin
   bit tmp_reg_wr;
   bit tmp_mem_to_reg;
   bit tmp_pc_to_reg;
   bit tmp_mem_read;
   bit tmp_mem_wr;
   bit tmp_branch_neg;
   bit tmp_branch_zero;
   bit tmp_jump;
   bit tmp_jump_mem;
   bit [3:0] tmp_alu_op;


   //default  
   tmp_alu_op = opcode;
   tmp_reg_wr = 1'b0;
   tmp_mem_to_reg = 1'b0;
   tmp_pc_to_reg = 1'b0;
   tmp_mem_read = 1'b0;
   tmp_mem_wr = 1'b0;  
   tmp_branch_neg = 1'b0;
   tmp_branch_zero = 1'b0;
   tmp_jump = 1'b0;
   tmp_jump_mem = 1'b0;
   compute_max <= 1'b0;

   if (reset || (opcode == NOP)) begin
   end else if (opcode == MAX) begin
      tmp_reg_wr = 1'b1; 
      tmp_mem_to_reg = 1'b1;
      compute_max <= 1'b1;
   end else if (opcode == STORE) begin
      tmp_mem_wr = 1'b1; 
   end else if (opcode == ADD) begin
      tmp_reg_wr = 1'b1; 
   end else if (opcode == INC) begin
      tmp_reg_wr = 1'b1; 
   end else if (opcode == NEG) begin
      tmp_reg_wr = 1'b1; 
   end else if (opcode == SUB) begin
      tmp_reg_wr = 1'b1; 
   end else if (opcode == J) begin
      tmp_jump = 1'b1;
   end else if (opcode == BRZ) begin
      tmp_branch_zero = 1'b1; 
   end else if (opcode == JM) begin
      tmp_mem_read = 1'b1;
      tmp_jump_mem = 1'b1; 
   end else if (opcode == BRN) begin
      tmp_branch_neg = 1'b1;
   end else if (opcode == LOAD) begin
     tmp_reg_wr = 1'b1;
     tmp_mem_to_reg = 1'b1;
     tmp_mem_read = 1'b1;
   end else if (opcode == SAVE_PC) begin
     tmp_reg_wr = 1'b1;
     tmp_pc_to_reg = 1'b1;
   end

   reg_wr <= tmp_reg_wr;
   mem_to_reg <= tmp_mem_to_reg;
   pc_to_reg <= tmp_pc_to_reg;
   mem_read <= tmp_mem_read;
   mem_wr <= tmp_mem_wr;
   branch_neg <= tmp_branch_neg;
   branch_zero <= tmp_branch_zero;
   jump <= tmp_jump;
   jump_mem <= tmp_jump_mem;
   alu_op <= tmp_alu_op;

end


reg [5:0] rd3;

rf rf_inst(.clk(clk),
           .wr(reg_wr3),
           .rs(rs),
           .rt(rt),
           .rd(rd3),
           .din(write_back_mux_out),
           .dout_rs(rs_dout),
           .dout_rt(rt_dout)
);



reg [31:0] rs_dout2;
reg [31:0] rt_dout2; 
reg [5:0]  rd2;
reg [31:0] offset2;
reg branch_neg2;
reg branch_zero2; 
reg jump2;
reg jump_mem2;


buff_id buff_id_inst(
    .clk(clk),
    .reg_wr_in(reg_wr),
    .mem_to_reg_in(mem_to_reg),
    .pc_to_reg_in(pc_to_reg),
    .alu_op_in(alu_op),
    .mem_read_in(mem_read),
    .mem_wr_in(mem_wr),
    .branch_neg_in(branch_neg),
    .branch_zero_in(branch_zero),
    .jump_mem_in(jump_mem),
    .jump_in(jump),
    .compute_max_in(compute_max),
    .dout_rs_in(rs_dout),
    .dout_rt_in(rt_dout),
    .rd_in(rd),
    .offset_in(offset),
    .reg_wr_out(reg_wr2),
    .mem_to_reg_out(mem_to_reg2),
    .pc_to_reg_out(pc_to_reg2),
    .alu_op_out(alu_op2),
    .mem_read_out(mem_read2),
    .mem_wr_out(mem_wr2),
    .branch_neg_out(branch_neg2),
    .branch_zero_out(branch_zero2),
    .compute_max_out(compute_max2),
    .jump_mem_out(jump_mem2),
    .jump_out(jump2),
    .dout_rs_out(rs_dout2),
    .dout_rt_out(rt_dout2),
    .rd_out(rd2),
    .offset_out(offset2)
);



reg Z;
reg N;
reg [31:0] alu_result_in; 
reg [31:0] alu_result_out; 

alu alu_inst(.opcode(alu_op2),
              .A(rs_dout2),
              .B(rt_dout2),
              .Z(Z),
              .N(N),
              .OUT(alu_result_in)
);

//store away the N and Z values for future BRZ or BRN instruction to refer to
always @ (posedge clk) begin
   if (reset) begin
      n_reg <= 0;
      z_reg <= 0;
   end else if ((alu_op2 == ADD) || (alu_op2 == SUB) || (alu_op2 == NEG) || (alu_op2 == INC)) begin
      n_reg <= N;
      z_reg <= Z;
   end else begin //retain previous value if not an ALU operation
   end
end


reg [31:0] dmem_dout; 

dmem dmem_inst(
   .compute_max(compute_max2),
   .addr(rs_dout2),
   .rd (mem_read2),
   .wr(mem_wr2),
   .clk(clk),
   .din(rt_dout2),
   .dout(dmem_dout) );
   


reg branch_zero_out3;
reg branch_neg_out3;
reg mem_to_reg3;

// EX buffer
buff_ex buff_ex_inst(
    .clk(clk),
    .z_in(Z),
    .n_in(N),
    .reg_wr_in(reg_wr2),
    .pc_to_reg_in(pc_to_reg2),
    .branch_neg_in(branch_neg2),
    .branch_zero_in(branch_zero2),
    .jump_in(jump2),
    .mem_to_reg_in(mem_to_reg2),
    .jump_mem_in(jump_mem2),
    .alu_result_in(alu_result_in),
    .dmem_dout_in(dmem_dout),
    .offset_in(offset2),
    .rs_dout_in(rs_dout2),
    .rd_in(rd2),
    .z_out(z_out),
    .n_out(n_out),
    .reg_wr_out(reg_wr3),
    .pc_to_reg_out(pc_to_reg3),
    .branch_neg_out(branch_neg_out3),
    .branch_zero_out(branch_zero_out3),
    .jump_out(jump3),
    .mem_to_reg_out(mem_to_reg3),
    .jump_mem_out(jump_mem3),
    .alu_result_out(alu_result_out),
    .dmem_dout_out(dmem_dout2),
    .rs_dout_out(rs_dout3),
    .offset_out(offset3),
    .rd_out(rd3)

);


signextender signextend_inst( .unextended({rs,rt}),
                             .extended(sign_xtnd_rs));

assign offset = sign_xtnd_rs + pc3;



three_to_1_mux three_to_1_mux_inst (
   .a(alu_result_out),
   .b(dmem_dout2),
   .c(offset3),
   .sel({pc_to_reg3, mem_to_reg3}),
   .out(write_back_mux_out)
);


assign logicout = (n_reg & branch_neg_out3) | (z_reg & branch_zero_out3);
assign rf_wr = reg_wr3; //FIXME



endmodule 


//sign extension in ID stage
module signextender(
  input [11:0] unextended,
  output reg [31:0] extended 
);

always@(unextended)
  begin 
    extended <= {{20{unextended[11]}}, unextended};
  end


endmodule















