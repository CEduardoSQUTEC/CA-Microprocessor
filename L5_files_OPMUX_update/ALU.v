module ALU(a,b,ALUop,result,flag);
    input [31:0] a,b;
    input [3:0] ALUop;
    output [31:0] result;
    output flag;
    wire[31:0] result_arithmetic_logic, result_arithmetic, result_logic, result_comparison;

    arithmethic_op Arithmetic_part(a,b,ALUop,result_arithmetic);
    logic_op Logic_part(a,b,ALUop,result_logic);
    comparison_op Comparison_part(a,b,ALUop,result_comparison);

    //ALUop Mux
    assign result_arithmetic_logic = ALUop[2]? result_logic: result_arithmetic;
    assign result = ALUop[3]? result_comparison : result_arithmetic_logic;

    //Flag
    always @(*) begin
      if(result_arithmetic_logic == 32'b0) flag = 1;
      else flag = 0;
    end

endmodule
