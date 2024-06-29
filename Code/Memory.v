module Memory(clk, address, we, oe, Dout, Din);
    input wire [511:0] Din ;
    output reg [511:0] Dout ;
    input wire we; // 1 for write and 0 for read
    input wire oe; // output enable
    input wire clk;
    input wire [8:0] address;
    reg [31:0] mem [511:0]; // the main memory
    initial 
        $readmemh("data.txt", mem);
    integer i;
    always @(posedge clk) begin
        if(we) begin
            for(i = 0; i < 16; i = i + 1) begin
                mem[address + i] <= Din[i*32+:32]; 
            end      
        end
        if(oe) begin
            for(i = 0; i < 16; i = i + 1) begin
                Dout[i*32+:32] <= mem[address + i];
            end
        end
        else 
            Dout = 512'bZ;
    end
endmodule
