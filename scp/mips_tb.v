module testbench();
    reg clk;
    reg reset;

    wire [31:0] writedata, dataadr;
    wire        memwrite;

    top dut(clk, reset, writedata, dataadr, memwrite);

    initial
        begin
            reset <= 1; #22; reset <= 0;
        end

    always
        begin
            clk <= 1; #5; clk <= 0; #5;
        end

    always @ (negedge clk)
    begin
        if (memwrite) begin
            if (dataadr === 84 & writedata === 5) begin
                $display("Simulation succeeded");
                $stop;
            end else if (dataadr !== 80) begin
                $display("Simulation failed");
                $stop;
            end
        end
    end

    initial begin
      $dumpfile("mips.vcd");
      $dumpvars;
    end
endmodule
