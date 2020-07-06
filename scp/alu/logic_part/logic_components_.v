module and_(input [31:0] and_a, and_b,
            output [31:0] result_and);
  assign result_and = and_a & and_b;
endmodule

module or_(input [31:0] or_a, or_b,
           output [31:0] result_or);
  assign result_or = or_a | or_b;
endmodule

/*UNUSED
module nor_(input [31:0] nor_a, nor_b,
            output [31:0] result_nor);
  assign result_nor = ~(nor_a|nor_b);
endmodule

module xor_(input [31:0] a,b,
            output [31:0] result);
  assign result = a ^ b;
endmodule

module ori_(input [31:0] a,b,
            output [31:0] result);
  output[31:0] result;
  wire[31:0] extb;
  msbext ext(b,extb);
  or_ ext_or(a,extb,result);
endmodule
*/
