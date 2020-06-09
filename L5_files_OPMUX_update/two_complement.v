module two_complement(a,out);
    input [31:0] a;
    output [31:0] out;

    out = ~a + 1'b1;

endmodule
