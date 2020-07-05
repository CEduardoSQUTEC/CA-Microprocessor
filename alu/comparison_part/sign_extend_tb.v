`timescale 1ns/1ns
module sign_extend_tb;
    reg a;
    output [31:0] result;

    always #1 a = ~a;
    sign_extend sign(a,result);

    initial begin
    #0 a = 0;
    #16 $finish;
    end

    initial begin
    $dumpfile("sign_extend.vcd");
    $dumpvars;
    end
endmodule
