module controller_tb;
    reg        clk, reset;
    reg  [5:0] op, funct;
    reg        zero;
    wire       pcen, memwrite, irwrite, regwrite;
    wire       alusrca, iord, memtoreg, regdst;
    wire [1:0] alusrcb, pcsrc;
    wire [2:0] alucontrol;

    reg [14:0] vectornum, errors;
    reg [30:0] testvector[11:0];

    controller dut(clk, reset,
                    op, funct,
                    zero, pcen,
                    memwrite, irwrite, regwrite, regwrite,
                    alusrca, iord, memtoreg, regdst,
                    alusrcb, pcsrc,
                    alucontrol);

    always begin
      clk = 1; #10; clk = 0; #10;
    end
    
    initial begin
      $readmemh("controller.tv", testvector);
      vectornum = 0; errors = 0;
    end

    always @(posedge clk) begin
            op = testvector[vectornum][30:25];
            funct = testvector[vectornum][23:18];
            zero = testvector[vectornum][16];
            result_expected = testvector[vectornum][14:0];
    end


endmodule