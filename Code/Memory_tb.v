module Memory_tb;
    `timescale 1ns/1ns
    reg [511:0] Din;
    wire [511:0] Dout;
    reg we; // 1 for write and 0 for read
    reg oe;
    reg clk;
    reg [8:0] address;
    Memory Memory_1(clk, address, we, oe, Dout, Din);
    integer i, j;
    initial begin
        clk = 0;
        oe = 1;
        address = 0;
        #10;
        for(i = 0;i<5;i=i+1)begin
            we = 1;
            oe = 0;
            address = i * 16;
            for(j = 0;j<512;j=j+32)begin
                Din[j+:32] = $urandom;
            end
            #10;
            we = 0;
            oe = 1;
            #10;
        end
        // we = 0;
        // for(i = 0;i<5;i=i+1)begin
        //     address = i * 512;
        //     #10;
        // end
    end

    always clk = #5 !clk;

endmodule

