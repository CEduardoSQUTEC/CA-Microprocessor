module alu(a,b,ALUop,result,flag);
    input [31:0] a,b;
    input [3:0] ALUop;
    output [31:0] result;
    output flag;
    wire [31:0] result_arithmetic_logic, result_arithmetic, result_logic, result_comparison;

    Arithmetic_part arithmethic_op(a,b,ALUop,result_arithmetic,flag);
    Logic_part logic_op (a,b,ALUop,result_logic);
    Comparison_part comparison_op (a,b,result_comparison);

    // ALUop Mux
    assign result_arithmetic_logic = ALUop[2]? result_logic: result_arithmetic;
    assign result = ALUop[3]? result_comparison : result_arithmetic_logic;

endmodule
