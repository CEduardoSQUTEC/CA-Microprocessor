module mips(input         clk, reset,
            output [31:0] adr, writedata,
            output        memwrite,
            input  [31:0] readdata);

  wire        zero, pcen, irwrite, regwrite;
  wire        alusrca, iord, memtoreg, regdst;
  wire [1:0]  alusrcb, pcsrc;
  wire [2:0]  alucontrol;
  wire [5:0]  op, funct;

  controller c(clk, reset, op, funct, zero,
               pcen, memwrite, irwrite, regwrite,
               alusrca, iord, memtoreg, regdst,
               alusrcb, pcsrc, alucontrol);


  datapath dp(clk, reset,
              pcen, irwrite, regwrite,
              alusrca, iord, memtoreg, regdst,
              alusrcb, pcsrc, alucontrol,
              op, funct, zero,
              adr, writedata, readdata);


endmodule

module controller(input        clk, reset,
                  input  [5:0] op, funct,
                  input        zero,
                  output       pcen, memwrite, irwrite, regwrite,
                  output       alusrca, iord, memtoreg, regdst,
                  output [1:0] alusrcb, pcsrc,
                  output [2:0] alucontrol);

  wire [1:0] aluop;
  wire       branch, pcwrite;

  // Main Decoder and ALU Decoder subunits.
  maindec md(clk, reset, op,
             pcwrite, memwrite, irwrite, regwrite,
             alusrca, branch, iord, memtoreg, regdst,
             alusrcb, pcsrc, aluop);
  aludec  ad(funct, aluop, alucontrol);

  assign pcen = (branch & zero) | pcwrite;
endmodule

module maindec(input        clk, reset,
               input  [5:0] op,
               output reg       pcwrite, memwrite, irwrite, regwrite,
               output reg     alusrca, branch, iord, memtoreg, regdst,
               output reg [1:0] alusrcb, pcsrc,
               output reg [1:0] aluop);

  // This is a moore machine.
  parameter   FETCH   = 4'b0000;  // State 0
  parameter   DECODE  = 4'b0001;  // State 1
  parameter   MEMADR  = 4'b0010;	// State 2
  parameter   MEMRD   = 4'b0011;	// State 3
  parameter   MEMWB   = 4'b0100;	// State 4
  parameter   MEMWR   = 4'b0101;	// State 5
  parameter   RTYPEEX = 4'b0110;	// State 6
  parameter   RTYPEWB = 4'b0111;	// State 7
  parameter   BEQEX   = 4'b1000;	// State 8
  parameter   ADDIEX  = 4'b1001;	// State 9
  parameter   ADDIWB  = 4'b1010;	// state 10
  parameter   JEX     = 4'b1011;	// State 11

  parameter   LW      = 6'b100011;	// Opcode for lw
  parameter   SW      = 6'b101011;	// Opcode for sw
  parameter   RTYPE   = 6'b000000;	// Opcode for R-type
  parameter   BEQ     = 6'b000100;	// Opcode for beq
  parameter   ADDI    = 6'b001000;	// Opcode for addi
  parameter   J       = 6'b000010;	// Opcode for j

  reg [3:0]  state, nextstate;
  reg [14:0] controls;

  // state register
  always @(posedge clk or posedge reset) begin
    if(reset) state <= FETCH;
    else state <= nextstate;
  end

  // next state logic
  always @ (*)
    case(state)
      FETCH:   nextstate <= DECODE;
      DECODE:  case(op)
                 LW:      nextstate <= MEMADR;
                 SW:      nextstate <= MEMADR;
                 RTYPE:   nextstate <= RTYPEEX;
                 BEQ:     nextstate <= BEQEX;
                 ADDI:    nextstate <= ADDIEX;
                 J:       nextstate <= JEX;
                 default: nextstate <= 4'bx; // should never happen
               endcase
      MEMADR: case(op)
                LW: nextstate <= MEMRD;
                SW: nextstate <= MEMWR;
                default: nextstate <= 4'bx; // should never happen
              endcase
      MEMRD: nextstate <= MEMWB;
      MEMWB: nextstate <= FETCH;
      MEMWR: nextstate <= FETCH;
      RTYPEEX: nextstate <= RTYPEWB;
      RTYPEWB: nextstate <= FETCH;
      BEQEX: nextstate <= FETCH;
      ADDIEX: nextstate <= ADDIWB;
      ADDIWB: nextstate <= FETCH;
      JEX: nextstate <= FETCH;
      default: nextstate <= 4'bx; // should never happen
    endcase

  // output logic

  always @ (*) begin
    case(state)
      FETCH:    controls <= 15'h5010;
      DECODE:   controls <= 15'h0030;
      MEMADR:   controls <= 15'h0420;
      MEMRD:    controls <= 15'h0100;
      MEMWB:    controls <= 15'h0880;
      MEMWR:    controls <= 15'h2100;
      RTYPEEX:  controls <= 15'h0402;
      RTYPEWB:  controls <= 15'h0840;
      BEQEX:    controls <= 15'h0605;
      ADDIEX:   controls <= 15'h0420;
      ADDIWB:   controls <= 15'h0800;
      JEX:      controls <= 15'h4008;
      default: controls <= 15'hxxxx; // should never happen
    endcase
    pcwrite <= controls[14];
    memwrite <= controls[13];
    irwrite <= controls[12];
    regwrite <= controls[11];
    alusrca <= controls[10];
    branch <= controls[9];
    iord <= controls[8];
    memtoreg <= controls[7];
    regdst <= controls[6];
    alusrcb <= controls[5:4];
    pcsrc <= controls[3:2];
    aluop <= controls[1:0];
  end


endmodule

module aludec(input  [5:0] funct,
              input  [1:0] aluop,
              output reg [2:0] alucontrol);

always@(*)
    case(aluop)
    2'b00:  alucontrol <= 3'b010; // add
    2'b01:  alucontrol <= 3'b110; // sub
    default: case(funct)
        6'b100000: alucontrol <= 3'b010; // add
        6'b100010: alucontrol <= 3'b110; // sub
        6'b100100: alucontrol <= 3'b000; // and
        6'b100101: alucontrol <= 3'b001; // or
        6'b101010: alucontrol <= 3'b111; // slt
        default:   alucontrol <= 3'bxxx; // ???
      endcase
    endcase
endmodule


module datapath(input              clk, reset,
                input              pcen, irwrite, regwrite,
                input              alusrca, iord, memtoreg, regdst,
                input   [1:0]      alusrcb, pcsrc,
                input   [2:0]      alucontrol,
                output  [5:0]      op, funct,
                output             zero,
                output  [31:0]     adr,
                output  reg [31:0] writedata,
                input   [31:0]     readdata);

//----------------  Wire-Reg box -----------------------
                wire [4:0]  writereg;
                wire [31:0] pcnext;
                reg  [31:0]  pc;
                reg  [31:0] instr, data;
                wire [31:0] srca, srcb;
                reg  [31:0] a;
                wire [31:0] aluresult;
                reg  [31:0] aluout;
                wire [31:0] signimm;
                wire [31:0] signimmsh;
                wire [31:0] wd3, rd1, rd2;
//---------------------------------------------------

  // Setting codes for control unit
  assign op = instr[31:26];
  assign funct = instr[5:0];

  //"Activate" program when reset is asserted
  always @ (*) begin
   if (reset) pc <= 0;
  end

  mux2 #(5)  RegDstMux(instr[20:16], instr[15:11], regdst, writereg);

  mux2 #(32) WD3Mux(aluout, data, memtoreg, wd3);

  //Regfile logic
   regfile    regf(clk, regwrite, instr[25:21], instr[20:16], writereg, wd3, rd1, rd2);


  //Adjusting some wires
  signext    se(instr[15:0], signimm);

  sl2        inmsl2(signimm, signimmsh);


  //ALU Logic
  mux2 #(32) SrcAmux(pc,a,alusrca,srca);

  mux4 #(32) SrcBmux(writedata, 32'b100, signimm, signimmsh, alusrcb, srcb);

  alu        alu(srca,srcb,alucontrol,aluresult,zero);

  //Saving ALU output
  always @ (posedge clk) begin
    aluout <= aluresult;
  end

  //Saving operands from register
  always @ (posedge clk) begin
    a <= rd1;
    writedata <= rd2;
  end

  //Setting Instr and Data. Always on posedge
  always @ (posedge clk) begin
   if(irwrite)  instr <=  readdata;
   data <= readdata;
  end

  //NextPC Logic
  mux3 #(32) Nextmux(aluresult, aluout, {pc[31:28], {instr[25:0], 2'b00} }, pcsrc, pcnext);


  mux2 #(32) PCadrMux(pc,aluout,iord,adr);


  //Going to next instruction
   always @ (posedge clk)begin
     if(pcen) pc <= pcnext;
   end

endmodule

//-------------------------Inner modules--------------------------
module mux3 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, d2,
              input  [1:0]       s,
              output [WIDTH-1:0] y);

  assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule

module mux4 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, d2, d3,
              input  [1:0]       s,
              output reg [WIDTH-1:0] y);

   always @ (*)
      case(s)
         2'b00: y <= d0;
         2'b01: y <= d1;
         2'b10: y <= d2;
         2'b11: y <= d3;
      endcase
endmodule

module mux2 # (parameter WIDTH = 8)
              (input [WIDTH-1:0] d0, d1,
              input s,
              output [WIDTH-1:0] y);
  assign y = s? d1 : d0;
endmodule

module signext (input [15:0] a,
                output [31:0] y);
assign y = {{16{a[15]}}, a};
endmodule

module regfile(input          clk,
               input          we3,
               input   [4:0]  ra1, ra2, wa3,
               input   [31:0] wd3,
               output  [31:0] rd1, rd2);

  reg [31:0] rf[31:0];

  always @(posedge clk)
    if (we3) rf[wa3] <= wd3;
        assign rd1 = (ra1 !== 0) ? rf[ra1] : 0;
        assign rd2 = (ra2 !== 0) ? rf[ra2] : 0;

endmodule

module sl2(input    [31:0]  a,
            output  [31:0]  y);
    // shift left by 2
    assign y = {a[25:0], 2'b00};
endmodule

// -------------------------------------------------------
