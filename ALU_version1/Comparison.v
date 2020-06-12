module Comparison_part(a,b,result);
    input [31:0] a,b;
    output [31:0] result;
    wire [31:0] comp;

    ripple_carry_adder slt(a,~b,1,comp);
    sign_extend sign(comp[31],result);

endmodule
