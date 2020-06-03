module ALU(a,b,opcode,result);
    input [31:0] a,b;
    input [3:0] opcode;
    output [31:0] result;
    output flag;

    //Idk como llamar a los modulos, porque necesitamos estructuras de control
    arithmethic_op Arithmetic_part(a,b,opcode,result,flag);
    logic_op Logic_part(a,b,opcode);

endmodule
