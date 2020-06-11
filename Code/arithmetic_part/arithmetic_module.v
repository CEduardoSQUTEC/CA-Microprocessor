module arithmetic_module(a, b, aluop, arithmetic_result);
    input [31:0] a, b;
    input [31:0] aloup;
    output [31:0] arithmetic_result;
    wire [31:0] add_result, sub_result;

    add addition(a, b, add_result);
    sub subtraction(a, b, sub_result);

    assign arithmetic_result = aluop[1]? sub_result : add_result;
endmodule