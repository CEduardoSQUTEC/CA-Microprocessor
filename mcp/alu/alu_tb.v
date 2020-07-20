module alu_tb;
  reg [31:0] a,b;
  reg [2:0] f;
  wire [31:0] y;
  wire zero;

  alu dut(a,b,f,y,zero);

  initial begin
    a = 32'b101;
    b = 32'b111;
    f = 3'b010;
    #2 f = 3'b110;
    #2 f = 3'b000;
    #2 f = 3'b001;
    #2 f = 3'b111;
    #2 f = 3'bxxx;
    a = 32'b1111;
    b = 32'b1010;
    f = 3'b010;
    #2 f = 3'b110;
    #2 f = 3'b000;
    #2 f = 3'b001;
    #2 f = 3'b111;
    #2 f = 3'bxxx;
  end

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars;
  end
endmodule
