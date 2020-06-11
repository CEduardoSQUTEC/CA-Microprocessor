module sub(a, b, sub_result);
    input   [31:0] a,b;
    output  [31:0] sub_result;
    wire    [31:0] n_b, neg_b;

    // assign n_b = ~b;
    // assign neg_b = n_b + 1;
    assign sub_result = a + (~b + 1);
endmodule