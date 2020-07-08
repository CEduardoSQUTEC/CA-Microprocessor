module controller_tb;
    reg        clk, reset;
    reg  [5:0] op, funct;
    reg        zero;
    wire       pcen, memwrite, irwrite, regwrite;
    wire       alusrca, iord, memtoreg, regdst;
    wire [1:0] alusrcb, pcsrc;
    wire [2:0] alucontrol;

    controller dut(clk, reset,
                    op, funct,
                    zero, pcen,
                    memwrite, irwrite, regwrite, regwrite,
                    alusrca, iord, memtoreg, regdst,
                    alusrcb, pcsrc,
                    alucontrol);

    

endmodule