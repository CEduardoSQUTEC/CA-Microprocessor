module slt(a,b,result);
  input [31:0] a,b;
  output [31:0] result;
  wire [31:0] comp;
  ripple_carry_adder slt(a,~b,1'b1,comp);
  sign_extend sign(comp[31],result);
endmodule

module bne(a,b,result);
  input [31:0] a,b;
  output [31:0] result;
  wire [31:0] comp;
  adder_ sub(a,~b,1'b1,comp);
  assign result = comp==0? 32'b0:32'b1;
endmodule
