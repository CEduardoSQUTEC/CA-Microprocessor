module ALU_tb;
    reg clk;
    reg [31:0] a, b, result_expected;
    wire [31:0] result;
    reg [3:0] aluop;
    reg flag_expected;
    wire flag;

    reg[31:0] vectornum, errors;
    reg[104:0] testvector[20:0];

    alu DUT_alu(a,b,aluop,result,flag);

    always begin
      clk = 1; #10; clk = 0; #10;
    end
    
    initial begin
      $readmemh("ALU_tb.tv", testvector);
      vectornum = 0; errors = 0;
    end

    always @(posedge clk)
        begin
            aluop = testvector[vectornum][104:101];
            a = testvector[vectornum][99:68];
            b = testvector[vectornum][66:35];
            result_expected = testvector[vectornum][33:2];
            flag_expected = testvector[vectornum][0];
        end

    always @(negedge clk) begin
        if (result !== result_expected || flag !== flag_expected) begin
            $display("Error in vector %d", vectornum);
            $display(" Inputs: a = %h, b = %h, aluop = %h", a, b, aluop);
            $display(" Outputs: result = %h (%h expected), flag = %h (%h expected)", result, result_expected, flag_expected);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;
        if (vectornum === 7) begin // We need to check if this only execute at the of the tv.
            $display("%d tests completed with %d erros", vectornum, errors);
            $finish;
        end
    end

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars;
    end
endmodule