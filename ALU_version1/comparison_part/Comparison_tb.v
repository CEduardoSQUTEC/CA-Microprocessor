`timescale 1ns/1ns
module Comparison_tb;
    reg[31:0] a,b;
    output [31:0] result;

    Comparison_part DUT_Comparison(a,b,result);

    initial begin
      #0 a = 32'b0; b = 32'b1;
      #1 a = 32'b1; b = 32'b1;
      #1 b = b + 32'b1;
      #1 $finish;
    end

    initial begin
    $dumpfile("Comparison.vcd");
    $dumpvars;
    end
endmodule
