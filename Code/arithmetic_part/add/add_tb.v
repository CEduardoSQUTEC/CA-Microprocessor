module add_tb();
    reg   [31:0] a,b;
    wire  [31:0] add_result;

    add add_(a, b, add_result);

    initial begin
        a = 32'b0; b = 32'b0;
        $monitor ("a = %h, b = %h, add_result  = %h", a, b, add_result);
        #64 $finish;
    end
    always #1 a = a + 67108864;
    always #2 b = b + 67108864;
    initial begin 
        $dumpfile("add_tb.vcd"); 
        $dumpvars;
    end
endmodule