module Logic_part(a,b,ALUop,result);
    input [31:0] a,b;
    input ALUop;
    output [31:0] result;

    // AND = 4'b0100;
    // OR  = 4'b0101;
    // XOR = 4'b0110;
    // NOR = 4'b0111;

    //Colocar result and sel en cada operacion para filtrar el tipo de operacion

    always @ (*)
      //Opmux para logic
      case(ALUop[1])
        0: if(~ALUop[0]) //AND
           else //OR
        1: if(~ALUop[0]) //XOR
           else //NOR
        //DEFAULT: considerar cuando operation no coincide con ninguna operacion
      endcase
endmodule
