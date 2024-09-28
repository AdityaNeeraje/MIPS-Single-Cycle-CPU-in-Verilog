module alu_tb;
    wire [31:0] x, y;
    assign x=5;
    assign y=20;
    wire [31:0] z;
    wire zero;
    alu alu1(x, y, 3'b000, zero, z);
    initial begin
        #10;
        $display("z=%d", z);
    end
endmodule