module add(a, b, add_result);
    input   [31:0] a,b;
    output  [31:0] add_result;

    assign add_result = a + b;
endmodule