module and_tb();
    reg [31:0] a,b;
    wire [31:0] result;

    and_ a1(a, b, result);
    
    initial begin
        a = 32'b101; b = 32'b11;
        $monitor ("a = %b, b = %b, result  = %b", a, b, result);
        #2 $finish;
    end
    initial begin 
        $dumpfile("and_tb.vcd"); 
        $dumpvars;
    end
endmodule