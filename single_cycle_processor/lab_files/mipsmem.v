//------------------------------------------------
// mipsmemsingle.sv
// Updated to SystemVerilog - Harris Harris version
// External memories used by MIPS single-cycle
// processor
//------------------------------------------------

module dmem(input         clk, we,
            input  [31:0] a, wd,
            output [31:0] rd);

  wire [31:0] RAM[63:0]; //This means 64 words 32-bit; not sure if syntaxis works on verilog

  assign rd = RAM[a[31:2]];

  always @(posedge clk)
    if (we)
      RAM[a[31:2]] <= wd;
endmodule

module imem(input  [5:0]  a,
            output [31:0] rd);

  wire [31:0] RAM[63:0];

  initial
    begin
      $readmemh("memfile.dat",RAM); // initialize memory
    end

  assign rd = RAM[a]; // word aligned
endmodule
