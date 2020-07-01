module slt_(input [31:0] slt_a, slt_b,
            output [31:0] result_slt);
  wire [31:0] slt_comp;
  adder_ slt(slt_a,~slt_b,1'b1,slt_comp);
  assign result_slt[0] = slt_comp[31];
  msbext #(1) ext(result[0], result_slt);
endmodule

module bne_(input [31:0] bne_a, bne_b,
            output [31:0] result_bne);
  wire [31:0] bne_comp;
  adder_ sub(bne_a,~bne_b,1'b1,bne_comp);
  assign result_bne = bne_comp==0? 32'b0:32'b1;
endmodule
