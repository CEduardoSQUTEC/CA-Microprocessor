module top(input            clk, reset,
            output  [31:0]  writedata, adr,
            output          memwrite);

    wire [31:0] readdata;
    // instantiate processor and memories
    mips mips(clk, reset, adr, writedata, memwrite, readdata);
    mem mem(clk, memwrite, adr, writedata, readdata);
endmodule

module mem(input            clk, we,
            input   [31:0]  a, wd,
            output  [31:0]  rd);

    reg [31:0] RAM[63:0];

    initial begin
    $readmemh(“memfile.dat”,RAM);
    end

    assign rd = RAM[a[31:2]]; // word aligned
    always @ (posedge clk)
    if (we) RAM[a[31:2]] <= wd;
endmodule