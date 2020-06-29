module alu(a,b,f,y,zero);
    input [31:0] a,b;
    input [2:0] f;
    output [31:0] y;
    output reg zero;
    wire [31:0] result_add, result_sub, result_and, result_or, result_slt;
    
    // wire[31:0] result_arithmetic_logic, result_arithmetic, result_logic, result_comparison;

    // Arithmetic_part Arithmetic_part_(a,b,f,result_arithmetic);
    // Logic_part Logic_part_(a,b,f,result_logic);
    // Comparison_part Comparison_part_(a,b,f,result_comparison);

    //ALUop Mux
    // assign result_arithmetic_logic = ALUop[2]? result_logic: result_arithmetic;
    // assign result = ALUop[3]? result_comparison : result_arithmetic_logic;

    adder_ add(a,b,1'b0,result_add);
    adder_ sub(a,~b,1'b1,result_sub);
    and_ and(a,b,result_and);
    or_ or(a,b,result_or);
    slt_ slt(a,b,result_slt);

    case(f):
    3'b010: y <= result_add;
    3'b110: y <= result_sub;
    3'b000: y <= result_and;
    3'b001: y <= result_or;
    3'b111: y <= result_slt;
    3'bxxx: y <= 3'bxxx;

    //Flag
    always @(*) begin
      if(y == 32'b0) zero = 1;
      else zero = 0;
    end
endmodule
