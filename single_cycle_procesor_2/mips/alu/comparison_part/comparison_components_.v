module slt_(input [31:0] slt_a, slt_b,
            output [31:0] result_slt);
  wire [31:0] slt_comp;
  wire [31:0] result;
  adder_ slt(slt_a,~slt_b,1'b1,slt_comp);
  msbext #(1,32) extsl(slt_comp[31], result);
  assign result_slt = result;
endmodule

module bne_(input [31:0] bne_a, bne_b,
            output [31:0] result_bne);
  wire [31:0] bne_comp;
  adder_ sub(bne_a,~bne_b,1'b1,bne_comp);
  assign result_bne = bne_comp==0? 32'b0:32'b1;
endmodule
