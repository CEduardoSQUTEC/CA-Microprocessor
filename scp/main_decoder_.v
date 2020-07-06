module maindec(input [5:0] op,
              output memtoreg, memwrite,
              output [1:0] branch,
              output alusrc, regdst, regwrite,
              output jump,
              output [1:0] aluop);
  reg [9:0] controls;

  assign {regwrite, regdst, alusrc,
          branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always @ (*)
    case(op)
    6'b000000: controls <= 10'b1100000010; //Rtyp
    6'b100011: controls <= 10'b1010001000; //LW
    6'b101011: controls <= 10'b0010010000; //SW
    6'b000100: controls <= 10'b0001000001; //BEQ
    6'b000101: controls <= 10'b0001100001; //BNE
    6'b001000: controls <= 10'b1010000000; //ADDI
    6'b000010: controls <= 10'b0000000100; //J
    6'b001101: controls <= 10'b1010000011; //ORI (Our implementation)
    default: controls <= 10'bxxxxxxxxxx; //???
    endcase
endmodule
