`timescale 1ns/1ns
module Logic_tb;
  reg [31:0] a,b;
  reg [3:0] ALUop;
  wire [31:0] result;

  Logic_part logic_(a,b,ALUop,result);

  initial begin
    #0 a=32'b0; b=32'b11111111111; ALUop = 4'b0100;
    #5 ALUop = 4'b0101;
    #0 a=32'b11111;
    #5 ALUop = 4'b0110;
    #5 ALUop = 4'b0111;
    #5 $finish;
  end

  initial begin
    $monitor ("a = %b, b = %b, ALUo = %b, result  = %b", a, b, ALUop, result);
    #20 $finish;
  end

  initial begin
    $dumpfile("Logic.vcd");
    $dumpvars;
  end
endmodule
