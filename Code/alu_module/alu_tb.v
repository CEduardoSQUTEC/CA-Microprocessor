`timescale 1ns/1ns
module alu_tb;
  reg[31:0] a,b;
  reg[3:0] aluop;
  wire[31:0] result;
  wire flag;

  alu DUT_alu(a,b,aluop,result,flag);

  initial begin
    #0 a=32'b10000000000000; b=32'b1011111111011; aluop=4'b0000;
    #1 aluop = 4'b0010;
    #1 aluop = 4'b0100;
    #1 aluop = 4'b0101;
    #1 aluop = 4'b0110;
    #1 aluop = 4'b0111;
    #1 aluop = 4'b1010;
    #0 a=32'b10; b=32'b10; aluop=4'b0010;
    #1 $finish;
  end

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars;
  end
endmodule
