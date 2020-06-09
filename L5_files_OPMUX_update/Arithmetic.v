module Arithmetic_part(a,b,opcode,result,flag);
    input [31:0] a,b;
    input opcode;
    output flag;
    output [31:0] result;

    // ADD = 4'b0000;
    // SUB = 4'b0010;
    // SLT = 4'b1010;

    //Colocar result and sel en cada operacion para filtrar el tipo de operacion

    always @ (*)
      //Opmux controller para arithmetic
      case(opcode[3])
        0: if(~opcode[1]) //AND
           else //SUB;
        1: //SLT
          // integer i;
          // for(i=0;i<32;i=i+1) begin
          //   if(a[i]>b[i]) out = 1;
          //   else if (a[i]<b[i]) out = 0;
          // end

        // DEFAULT: considerar cuando operation no coincide con ninguna operacion
      endcase

    if(result = 32'b0) flag = 1;
endmodule
