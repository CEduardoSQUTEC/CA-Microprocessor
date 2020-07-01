module full_adder(a,b,cin,cout,sum);
    input a,b,cin;
    output cout, sum;

    assign cout = ((a^b) & cin) | (a & b);
    assign sum = a^b^cin;

endmodule

module adder_(a,b,f_cin,result);
    input [31:0] a, b;
    input f_cin; //0 if the op is an addition, 1 in case of substraction (2´complement)
    output[31:0] result;
    wire [31:0] carry;

    full_adder add0(a[0], b[0], f_cin, carry[0], result[0]);
    full_adder add1(a[1], b[1], carry[0], carry[1], result[1]);
    full_adder add2(a[2], b[2], carry[1], carry[2], result[2]);
    full_adder add3(a[3], b[3], carry[2], carry[3], result[3]);
    full_adder add4(a[4], b[4], carry[3], carry[4], result[4]);
    full_adder add5(a[5], b[5], carry[4], carry[5], result[5]);
    full_adder add6(a[6], b[6], carry[5], carry[6], result[6]);
    full_adder add8(a[8], b[8], carry[7], carry[8], result[8]);
    full_adder add7(a[7], b[7], carry[6], carry[7], result[7]);
    full_adder add9(a[9], b[9], carry[8], carry[9], result[9]);
    full_adder add10(a[10], b[10], carry[9],  carry[10], result[10]);
    full_adder add11(a[11], b[11], carry[10], carry[11], result[11]);
    full_adder add12(a[12], b[12], carry[11], carry[12], result[12]);
    full_adder add13(a[13], b[13], carry[12], carry[13], result[13]);
    full_adder add14(a[14], b[14], carry[13], carry[14], result[14]);
    full_adder add15(a[15], b[15], carry[14], carry[15], result[15]);
    full_adder add16(a[16], b[16], carry[15], carry[16], result[16]);
    full_adder add17(a[17], b[17], carry[16], carry[17], result[17]);
    full_adder add18(a[18], b[18], carry[17], carry[18], result[18]);
    full_adder add19(a[19], b[19], carry[18], carry[19], result[19]);
    full_adder add20(a[20], b[20], carry[19], carry[20], result[20]);
    full_adder add21(a[21], b[21], carry[20], carry[21], result[21]);
    full_adder add22(a[22], b[22], carry[21], carry[22], result[22]);
    full_adder add23(a[23], b[23], carry[22], carry[23], result[23]);
    full_adder add24(a[24], b[24], carry[23], carry[24], result[24]);
    full_adder add25(a[25], b[25], carry[24], carry[25], result[25]);
    full_adder add26(a[26], b[26], carry[25], carry[26], result[26]);
    full_adder add27(a[27], b[27], carry[26], carry[27], result[27]);
    full_adder add28(a[28], b[28], carry[27], carry[28], result[28]);
    full_adder add29(a[29], b[29], carry[28], carry[29], result[29]);
    full_adder add30(a[30], b[30], carry[29], carry[30], result[30]);
    full_adder add31(a[31], b[31], carry[30], carry[31], result[31]);
endmodule

module msbext #(parameter INITIAL = 16, parameter FINAL = 32)
               (input [INITIAL-1:0] src,
                output [FINAL-1:0] out);

  wire [FINAL-1-INITIAL:0] ext;
  assign ext = src[INITIAL-1]? 1 : 0;
  assign out = {ext,src};

endmodule
