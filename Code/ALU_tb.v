module ALU_tb;
    `timescale 1ns/1ns
    reg[511:0] in1;
    reg[511:0] in2;
    reg op; // 1 for multiplication and 0 for addition
    reg clk;
    wire Z;
    wire[1023:0]out;
    integer i;
    ALU ALU_1(in1, in2, op, out, Z);
    initial begin
        clk = 0;
        op = 0;
    end
    
    always @(posedge clk) begin
        for(i = 0;i<512;i=i+32)begin
            in1[i+:32] = $urandom;
            in2[i+:32] = $urandom;
        end
        op = 1 - op;
    end

    always clk = #5 !clk;
endmodule
