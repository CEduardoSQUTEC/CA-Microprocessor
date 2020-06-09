module alu(a,b,aluop,result);
    input [31:0] a,b;
    input [3:0] aluop;
    output [31:0] result;
    output flag;

    always @(aluop) begin
        casex(aluop)
            
        endcase
    end

endmodule
