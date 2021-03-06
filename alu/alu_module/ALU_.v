module alu(a,b,ALUop,result,flag);
    input [31:0] a,b;
    input [3:0] ALUop;
    output [31:0] result;
    output reg flag;
    wire[31:0] result_arithmetic_logic, result_arithmetic, result_logic, result_comparison;

    Arithmetic_part Arithmetic_part_(a,b,ALUop,result_arithmetic);
    Logic_part Logic_part_(a,b,ALUop,result_logic);
    Comparison_part Comparison_part_(a,b,result_comparison);

    //ALUop Mux
    assign result_arithmetic_logic = ALUop[2]? result_logic: result_arithmetic;
    assign result = ALUop[3]? result_comparison : result_arithmetic_logic;

    //Flag
    always @(*) begin
      if(result == 32'b0) flag = 1;
      else flag = 0;
    end
endmodule
