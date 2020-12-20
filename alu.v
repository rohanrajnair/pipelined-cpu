`include "mux.v"



module twos_complement (
   input [31:0] a, 
   output reg [31:0] out 
);
   always @ (a) begin
      out <= ~a + 1; 
      $display ("twos complement a <= %d out <= %d", a, ~a+1);
   end 
endmodule 

module full_adder (
    input a,
    input b,
    input cin,
    output s,
    output cout );

    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module ripple_adder (
    input [31:0] a,
    input [31:0] b,
    input cin,
    output reg z,
    output reg n,
    output [31:0] out );

    wire [31:0] tmp_out;

    initial begin
    $monitor ("ripple_adder a=%d b=%d cin=%d", a, b, cin);
    end

    assign out = tmp_out;

    always @ (a or b or tmp_out) begin
        if (tmp_out == 32'b0) begin
            z <= 1'b1; 
        end 
        else begin 
            z <= 1'b0; 
        end 
        if (tmp_out[31] == 1) begin
            n <= 1'b1; 
        end 
        else begin
            n <= 1'b0; 
        end
    end

wire [31:0] tmp_cout; 

    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

full_adder  full_addr_0 (
    .a(a[0]),
    .b(b[0]),
    .cin(1'b0),
    .s(tmp_out[0]),
    .cout(tmp_cout[0]) );


full_adder  full_addr_1 (
		.a(a[1]),  
		.b(b[1]),  
		.cin(tmp_cout[0]),  
		.s(tmp_out[1]),  
		.cout(tmp_cout[1])  
);
full_adder  full_addr_2 (
		.a(a[2]),  
		.b(b[2]),  
		.cin(tmp_cout[1]),  
		.s(tmp_out[2]),  
		.cout(tmp_cout[2])  
);
full_adder  full_addr_3 (
		.a(a[3]),  
		.b(b[3]),  
		.cin(tmp_cout[2]),  
		.s(tmp_out[3]),  
		.cout(tmp_cout[3])  
);
full_adder  full_addr_4 (
		.a(a[4]),  
		.b(b[4]),  
		.cin(tmp_cout[3]),  
		.s(tmp_out[4]),  
		.cout(tmp_cout[4])  
);
full_adder  full_addr_5 (
		.a(a[5]),  
		.b(b[5]),  
		.cin(tmp_cout[4]),  
		.s(tmp_out[5]),  
		.cout(tmp_cout[5])  
);
full_adder  full_addr_6 (
		.a(a[6]),  
		.b(b[6]),  
		.cin(tmp_cout[5]),  
		.s(tmp_out[6]),  
		.cout(tmp_cout[6])  
);
full_adder  full_addr_7 (
		.a(a[7]),  
		.b(b[7]),  
		.cin(tmp_cout[6]),  
		.s(tmp_out[7]),  
		.cout(tmp_cout[7])  
);
full_adder  full_addr_8 (
		.a(a[8]),  
		.b(b[8]),  
		.cin(tmp_cout[7]),  
		.s(tmp_out[8]),  
		.cout(tmp_cout[8])  
);
full_adder  full_addr_9 (
		.a(a[9]),  
		.b(b[9]),  
		.cin(tmp_cout[8]),  
		.s(tmp_out[9]),  
		.cout(tmp_cout[9])  
);
full_adder  full_addr_10 (
		.a(a[10]),  
		.b(b[10]),  
		.cin(tmp_cout[9]),  
		.s(tmp_out[10]),  
		.cout(tmp_cout[10])  
);
full_adder  full_addr_11 (
		.a(a[11]),  
		.b(b[11]),  
		.cin(tmp_cout[10]),  
		.s(tmp_out[11]),  
		.cout(tmp_cout[11])  
);
full_adder  full_addr_12 (
		.a(a[12]),  
		.b(b[12]),  
		.cin(tmp_cout[11]),  
		.s(tmp_out[12]),  
		.cout(tmp_cout[12])  
);
full_adder  full_addr_13 (
		.a(a[13]),  
		.b(b[13]),  
		.cin(tmp_cout[12]),  
		.s(tmp_out[13]),  
		.cout(tmp_cout[13])  
);
full_adder  full_addr_14 (
		.a(a[14]),  
		.b(b[14]),  
		.cin(tmp_cout[13]),  
		.s(tmp_out[14]),  
		.cout(tmp_cout[14])  
);
full_adder  full_addr_15 (
		.a(a[15]),  
		.b(b[15]),  
		.cin(tmp_cout[14]),  
		.s(tmp_out[15]),  
		.cout(tmp_cout[15])  
);
full_adder  full_addr_16 (
		.a(a[16]),  
		.b(b[16]),  
		.cin(tmp_cout[15]),  
		.s(tmp_out[16]),  
		.cout(tmp_cout[16])  
);
full_adder  full_addr_17 (
		.a(a[17]),  
		.b(b[17]),  
		.cin(tmp_cout[16]),  
		.s(tmp_out[17]),  
		.cout(tmp_cout[17])  
);
full_adder  full_addr_18 (
		.a(a[18]),  
		.b(b[18]),  
		.cin(tmp_cout[17]),  
		.s(tmp_out[18]),  
		.cout(tmp_cout[18])  
);
full_adder  full_addr_19 (
		.a(a[19]),  
		.b(b[19]),  
		.cin(tmp_cout[18]),  
		.s(tmp_out[19]),  
		.cout(tmp_cout[19])  
);
full_adder  full_addr_20 (
		.a(a[20]),  
		.b(b[20]),  
		.cin(tmp_cout[19]),  
		.s(tmp_out[20]),  
		.cout(tmp_cout[20])  
);
full_adder  full_addr_21 (
		.a(a[21]),  
		.b(b[21]),  
		.cin(tmp_cout[20]),  
		.s(tmp_out[21]),  
		.cout(tmp_cout[21])  
);
full_adder  full_addr_22 (
		.a(a[22]),  
		.b(b[22]),  
		.cin(tmp_cout[21]),  
		.s(tmp_out[22]),  
		.cout(tmp_cout[22])  
);
full_adder  full_addr_23 (
		.a(a[23]),  
		.b(b[23]),  
		.cin(tmp_cout[22]),  
		.s(tmp_out[23]),  
		.cout(tmp_cout[23])  
);
full_adder  full_addr_24 (
		.a(a[24]),  
		.b(b[24]),  
		.cin(tmp_cout[23]),  
		.s(tmp_out[24]),  
		.cout(tmp_cout[24])  
);
full_adder  full_addr_25 (
		.a(a[25]),  
		.b(b[25]),  
		.cin(tmp_cout[24]),  
		.s(tmp_out[25]),  
		.cout(tmp_cout[25])  
);
full_adder  full_addr_26 (
		.a(a[26]),  
		.b(b[26]),  
		.cin(tmp_cout[25]),  
		.s(tmp_out[26]),  
		.cout(tmp_cout[26])  
);
full_adder  full_addr_27 (
		.a(a[27]),  
		.b(b[27]),  
		.cin(tmp_cout[26]),  
		.s(tmp_out[27]),  
		.cout(tmp_cout[27])  
);
full_adder  full_addr_28 (
		.a(a[28]),  
		.b(b[28]),  
		.cin(tmp_cout[27]),  
		.s(tmp_out[28]),  
		.cout(tmp_cout[28])  
);
full_adder  full_addr_29 (
		.a(a[29]),  
		.b(b[29]),  
		.cin(tmp_cout[28]),  
		.s(tmp_out[29]),  
		.cout(tmp_cout[29])  
);
full_adder  full_addr_30 (
		.a(a[30]),  
		.b(b[30]),  
		.cin(tmp_cout[29]),  
		.s(tmp_out[30]),  
		.cout(tmp_cout[30])  
);
full_adder  full_addr_31 (
		.a(a[31]),  
		.b(b[31]),  
		.cin(tmp_cout[30]),  
		.s(tmp_out[31]),  
		.cout(tmp_cout[31])  
);

endmodule



module alu(
//input ADD,
//input INC,
//input NEG,
//input SUB,
input [3:0] opcode,
input [31:0] A,
input [31:0] B,
output Z,
output N,
output [31:0] OUT
);

//internal signals
reg [31:0] t1, t2;

always @ (opcode or A or B) begin
   if (opcode == 4'b0100) begin //add 
      t1 <= A;
      t2 <= B;
   end else if (opcode == 4'b0101) begin //increment
      t1 <= A;
      t2 <= 'h1;
   end else if (opcode == 4'b0110) begin //negate
      t1 <= ~A + 'h1;
      t2 <= 'h0;
   end else if (opcode == 4'b0111) begin //subtract
      t1 <= A;
      t2 <= ~B + 1;
   end else begin
      t1 <= 'h0;
      t2 <= 'h0;
   end
   
end
   
ripple_adder inst4 (
    .a(t1),
    .b(t2),
    .cin(1'b0),
    .z(Z),
    .n(N),
    .out(OUT) );

endmodule
