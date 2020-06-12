module Arithmetic_part(a,b,ALUop,result,flag);
  input [31:0] a,b;
  input [3:0] ALUop;
  output flag;
  output reg [31:0] result;
  wire op_sign = ALUop[1];
  wire[31:0] wire_sum, wire_sub;

  // ADD = 4'b0000;
  // SUB = 4'b0010;

  ripple_carry_adder sum(a,b,op_sign,wire_sum);
  ripple_carry_adder sub(a,~b,op_sign,wire_sub);

  always @ (*)
    case(ALUop[1])
      0: result = wire_sum;
      1: result = wire_sub;
    endcase

  assign flag = (result==32'b0);

endmodule
