module ALU(in1, in2, op, out, Z);
    input wire signed[511:0] in1;
    input wire signed[511:0] in2;
    output wire Z;
    input wire op; // 1 for multiplication and 0 for addition
    output wire signed[1023:0]out; // least significan
    assign out = op == 0 ? in1 + in2 : in1 * in2;
    assign Z = out == 0 ? 1 : 0;
endmodule