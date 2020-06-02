module ALU(a,b,flag,opcode,result);
    input a,b,flag;
    input [3:0] opcode;
    output [3:0] out;

    //Logica deductiva de op_mux (unused)
    // parameter _add = 4'b0000;
    // parameter _sub = 4'b0010;
    // parameter _and = 4'b0100;
    // parameter _or = 4'b0101;
    // parameter _xor = 4'b0110;
    // parameter _nor = 4'b0111;
    // parameter _slt = 4'b1010;
    // parameter trash = 4'bxxxx;
    // 4'bx00x: begin
    //   result = _add;
    // end
    // 4'bxx00: begin
    //   result = _and;
    // end
    // 4'bxx01: begin
    //   result = _or;
    // end
    // 4'bx111: begin
    //   result = _nor;
    // end
    // 4'b00xx: begin
    //   result = _sub;
    // end
    // 4'bx110: begin
    //   result = _xor;
    // end

    //Opmux (crear submodulos que separen las logic operations de las arithmetic)
    case(opcode)
      4'bx1xx :
      4'bx0xx :
    endcase
endmodule
