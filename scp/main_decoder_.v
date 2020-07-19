module maindec(input [5:0] op,
              output memtoreg, memwrite,
              output [1:0] branch,
              output [1:0] alusrc, 
              output regdst, regwrite,
              output jump,
              output [1:0] aluop);
  reg [10:0] controls;

  assign {regwrite, regdst, alusrc,
          branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always @ (*)
    case(op)
    6'b000000: controls <= 11'b11000000010; //Rtyp
    6'b100011: controls <= 11'b10010001000; //LW
    6'b101011: controls <= 11'b00010010000; //SW
    6'b000100: controls <= 11'b00001000001; //BEQ
    6'b000101: controls <= 11'b00001100001; //BNE
    6'b001000: controls <= 11'b10010000000; //ADDI
    6'b000010: controls <= 11'b00000000100; //J
    6'b001101: controls <= 11'b10110000011; //ORI (Our implementation)
    default: controls <= 11'bxxxxxxxxxxx; //???
    endcase
endmodule
