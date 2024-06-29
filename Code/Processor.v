module Procecssor(rst, clk, instruction);
    input wire clk;
    input wire rst;
    input wire [12:0]instruction; // 13 bit instructions
    
    // register bank
    reg[511:0] A1; 
    reg[511:0] A2; 
    reg[511:0] A3; 
    reg[511:0] A4; 

    wire [1:0]opCode;
    assign opCode = instruction[12:11]; // this wire hold the instruction code for every instruciton

    wire [1:0] regAddress;
    assign regAddress = instruction[10:9];
    
    wire [8:0] address;
    assign address = instruction[8:0]; // this wire holds the memory address for writing and reading
    wire we;
    assign we = opCode==00 ? 1 : 0; // writing to memory when the opcode is 00
    wire oe;
    assign oe = opCode==01 ? 1 : 0; // reading from memory when opcode is 01
    wire[511:0] Dout;
    wire[511:0] Din;

    mux4_512 writeMux({A4, A3, A2, A1}, regAddress,  Din);
    Memory mem(clk, address, we, oe, Dout, Din);

    wire ALUOp; // 1 for multiplication and 0 for addition
    assign ALUOp = opCode[0]; // the least significant bit in opcode specifies the operation
    wire [1023:0] ALUOut; // ALU output
    wire Z; // Z signal for when the resulting operation is 0

    ALU alu(A1, A2, ALUOp, ALUOut, Z);

    always @(posedge clk)begin
        if (rst) begin
            A1 <= 0;
            A2 <= 0;
            A3 <= 0;
            A4 <= 0;
        end
    end

    always @(negedge clk)begin
        if(opCode[1] == 1)
            {A4, A3} <= ALUOut;
        if (opCode == 2'b01)begin
            if(regAddress == 2'b00)
                A1 <= Dout;
            else if(regAddress == 2'b01)
                A2 <= Dout;
            else if(regAddress == 2'b10)
                A3 <= Dout;
            else if(regAddress == 2'b11)
                A4 <= Dout;
        end
    end
endmodule

module mux4_512(in, sel, out); // 4 inputs with 512 bits
    input wire [2047:0] in;
    input wire [1:0] sel;
    output wire [511:0] out;
    assign out = sel[1] ? (sel[0] ? in[512*4 - 1:512*3] : in[512*3 - 1:512*2]) : (sel[0] ? in[512*2 - 1:512*1] : in[512*1 - 1 : 512*0]);
endmodule
