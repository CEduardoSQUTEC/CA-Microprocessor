module Arithmetic_part(sel,a,b,ALUop,result,flag);
    input [31:0] a,b;
    input sel;
    input ALUop;
    output flag;
    output [31:0] result;

    // ADD = 4'b0000;
    // SUB = 4'b0010;
    // SLT = 4'b1010;

    //Colocar result and sel en cada operacion para filtrar el tipo de operacion

    always @ (*)
      //

    if(result = 32'b0) flag = 1;
endmodule
