`timescale 1ns/1ns
module arithmethic_tb;
    reg[31:0] a,b;
    reg[3:0] ALUop;
    wire flag;
    wire[31:0] result;

    Arithmetic_part DUT_Arithmetic(a,b,ALUop,result,flag);

    initial begin
      #0 a=32'b110; b=32'b10000; ALUop = 4'b0010;
      #1 a=32'b11110; b = 32'b110;
      #1 ALUop = 4'b0000;
      #1 a=32'hFFFFFFFF; b=32'hFFFFFFFF;
      #1 ALUop = 4'b0010;
      #1 $finish;
    end

    initial begin
      $dumpfile("Arithmetic.vcd");
      $dumpvars;
    end
endmodule
