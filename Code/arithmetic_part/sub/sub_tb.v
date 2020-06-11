module sub_tb;
    reg   [31:0] a,b;
    wire  [31:0] sub_result;

    sub sub_(a, b, sub_result);

    initial begin
        a = 32'b0; b = 32'b0;
        $monitor ("a = %b, b = %b, add_result  = %b", a, b, sub_result);
        #18 $finish;
    end
    always #1 a = a + 1;
    always #2 b = b + 1;
    initial begin 
        $dumpfile("add_tb.vcd"); 
        $dumpvars;
    end
endmodule