module Logic_part(a,b,ALUop,result);
    input [31:0] a,b;
    input [3:0] ALUop;
    output reg [31:0] result;
    wire [31:0] and_w, or_w, xor_w;

    // AND = 4'b0100;
    // OR  = 4'b0101;
    // XOR = 4'b0110;
    // NOR = 4'b0111;
    and_ and_32(a,b,and_w);
    or_ or_32(a,b,or_w);
    xor_ xor_32(a,b,xor_w);

    always @ (*)
      case(ALUop[1])
        0: if (ALUop[0]) result = or_w;
           else result = and_w;
        1: if (ALUop[0]) result = ~or_w;
           else result = xor_w;
      endcase
endmodule
