module and_(a,b,result);
  input [31:0] a,b;
  output [31:0] result;
  assign result = a && b;
endmodule

module nor_(a,b,result);
  input[31:0] a,b;
  output[31:0] result;
  assign result = ~(a|b);
endmodule

module or_(a,b,result);
  input [31:0] a,b;
  output [31:0] result;
  assign result = a | b;
endmodule

module xor_(a,b,result);
  input[31:0] a,b;
  output[31:0] result;
  assign result = a ^ b;
endmodule

module ori_(a,b,result);
  input[31:0] a;
  input[15:0] b;
  output[31:0] result;
  wire[31:0] extb;
  msbext ext(b,extb);
  or_ ext_or(a,extb,result);
endmodule
