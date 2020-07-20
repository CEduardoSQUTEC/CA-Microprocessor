`timescale 1ns/1ns
module testbench;
    reg clk;
    reg reset;

    wire [31:0] writedata, dataadr;
    wire        memwrite;

    top dut(clk, reset, writedata, dataadr, memwrite);

    initial
        begin
            reset <= 1; #1; reset <= 0;
        end

    always
        begin
            clk <= 1; #2; clk <= 0; #5;
        end

    always @ (negedge clk)
    begin
        if (dataadr === 32'h4C) begin
            $display("Simulation finished");
            $stop;
        end
    end

    initial begin
      $dumpfile("mips.vcd");
      $dumpvars;
    end
endmodule
