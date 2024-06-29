module Procecssor_tb;
    `timescale 1ns/1ns
    reg clk;
    reg rst;
    reg[12:0] instruction;
    wire [511:0] A1;
    wire [511:0] A2;
    wire [511:0] A3;
    wire [511:0] A4;
    wire [511:0] Dout;
    Procecssor DUT(rst, clk, instruction, A1, A2, A3, A4, Dout);

    initial begin
        rst = 1;
        clk = 1;
        #7;
        rst = 0;
        #3;
        instruction = 13'b0100000000000; // load address 0 to register A1
        #10;
        instruction = 13'b0101000000000; // load address 0 to register A2
        #10;
        instruction = 13'b1011111111111; // adding A1 and A2
        #10;
        instruction = 13'b0010001000000; // storing A3 to address 9'b001000000
        #10;
        instruction = 13'b0100001000000; // loading address 9'b001000000 to A1
        #10;
        instruction = 13'b1100000000000; // multiplying A1 and A2
        #10;
        instruction = 13'b0010001000000; // storing A3 to address 9'b001000000
        #10;
        instruction = 13'b0111001000000; // loading address 9'b001000000 to A4
        #10;
    end

    always clk = #5 !clk;
endmodule