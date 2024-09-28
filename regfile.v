module regfile(input clk, input rw, input[4:0] addr1, input [4:0] addr2, output reg[31:0] data1, output reg[31:0] data2, input [4:0] addr3, input [31:0] wr_data);
    reg [31:0] regmem [31:0];

	initial begin: hello
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            regmem[i] = i+1;
        end
	end

	always @(addr1 or regmem[addr1]) begin
		data1 = regmem[addr1];
	end


	always @(addr2 or regmem[addr2]) begin
		data2 = regmem[addr2];
	end

    always@ (negedge clk) begin
		if(rw == 1'b1) begin
			regmem[addr3] = wr_data;
		end
	end

endmodule