module new_aluinstr;
  wire [31:0] srca, srcb;
  // (in case of ORI) wire [16:0] srcb;
  wire [31:0] out;

  //ORI
  wire [31:0] extsrcb;
  msbext ext(srcb,extsrcb);
  or_ (src,extsrcb,result);

  //BNE
  wire flag;
  //flag == ~zero (llamar a sub), luego, se extiende flag para result (extend hasta 32 bits)
endmodule
