module controller_tb;
    reg        clk, reset;
    reg  [5:0] op, funct;
    reg        zero;
    wire       pcen, memwrite, irwrite, regwrite;
    wire       alusrca, iord, memtoreg, regdst;
    wire [1:0] alusrcb, pcsrc;
    wire [2:0] alucontrol;
    reg [14:0] result, result_expected;
    reg [14:0] vectornum, errors;
    reg [38:0] testvector[26:0];

    controller dut(clk, reset,
                    op, funct,
                    zero, pcen,
                    memwrite, irwrite, regwrite,
                    alusrca, iord, memtoreg, regdst,
                    alusrcb, pcsrc,
                    alucontrol);

    always begin
      clk = 1; #10; clk = 0; #10; reset = 0;
    end

    initial begin
      $readmemh("controller.tv", testvector);
      //Vectornum is setted with -1 just to match with the correct clock cycle (after reset)
      vectornum = -1; errors = 0;
      reset = 1;
    end

    always @(posedge clk) begin
            op = testvector[vectornum][33:28];
            funct = testvector[vectornum][25:20];
            zero = testvector[vectornum][16];
            result_expected = testvector[vectornum][14:0];
    end

    always @(negedge clk) begin
        result <= {pcen, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, alucontrol};
        if(vectornum) begin
          if (result !== result_expected) begin
              $display("\nErrors in vector %d", vectornum);
              $display(" Inputs: op = %b, funct = %b, zero = %b", op, funct, zero);
              $display(" Outputs: result = %h (%h expected)", result, result_expected);
              errors = errors + 1;
          end
        end
        vectornum = vectornum + 1;
        if (vectornum === 27) begin
            $display("%d tests (7 instructions) completed with %d error(s)",vectornum, errors);
            $finish;
        end
    end

    initial begin
        $dumpfile("mcp.vcd");
        $dumpvars;
    end
endmodule
