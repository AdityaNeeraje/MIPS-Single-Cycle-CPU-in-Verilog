module alu(input[31:0] a, b, input[2:0] ALUop, output zero, output [31:0] y);
    // 00 is for and, 01 is for sub
    wire [31:0] not_b;
    assign not_b = ~b;

    wire [31:0] b_mux_not_b;
    assign b_mux_not_b = (ALUop[2]==1'b0)? b:not_b;

    wire [31:0] f00;
    assign f00=a&b_mux_not_b;

    wire [31:0] f01;
    assign f01=a|b_mux_not_b;

    wire [31:0] f10;
    Nbit_adder #(32) adder(a, b_mux_not_b, ALUop[2], f10);

    wire [31:0] f11;
    assign f11 = {{31{1'b0}}, ((a[31] == not_b[31]) && (f10[31] != a[31])) ? ~(f10[31]) : f10[31]};

    assign zero = (y==32'b0);

    assign y = (ALUop[1]==1'b0)? ((ALUop[0]==1'b0)? f00:f01):((ALUop[0]==1'b0)? f10:f11);

endmodule

module Nbit_adder #(parameter N = 4) (input [N-1:0] a, b, input carry_in, output [N-1:0] y);
    wire [N:0] carries;
    assign carries[0] = carry_in;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: add
            assign y[i] = a[i] ^ b[i] ^ carries[i];
            assign carries[i+1] = (a[i] & b[i]) | (a[i] & carries[i]) | (b[i] & carries[i]);
        end
    endgenerate
endmodule