module ALU(a,b,opcode,result);
    input [31:0] a,b;
    input [3:0] opcode;

    wire sel;

    assign sel = ~opcode[2];

    output [31:0] result;
    output flag;

    //Idk como llamar a los modulos, porque necesitamos estructuras de control
    arithmethic_op Arithmetic_part(sel,a,b,opcode,result,flag);
    logic_op Logic_part(~sel,a,b,opcode);

endmodule
