module dmem(
    input clk,
    input write_en,
    input [31:0] addr,
    input [31:0] wr_data,
    output [31:0] rd_data
);
    reg [255:0] mem [31:0];
    assign rd_data = mem[addr];

    // initial begin
    //     $monitor("%b", mem[9]);
    // end
    
    initial begin: hello
        integer i;
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = i+1;
        end
	end


    always @(posedge clk) begin
        if(write_en) begin
            mem[addr] <= wr_data;
        end
    end
endmodule