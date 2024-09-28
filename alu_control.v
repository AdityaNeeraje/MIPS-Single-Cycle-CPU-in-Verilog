module alu_control (
	input  [31:0] instruction     ,
	output reg [ 2:0] alu_control
);


	always @(instruction) begin
		casex ({instruction[31:26], instruction[5:0]})
			12'b000100xxxxxx : alu_control = 3'b110;
			12'b001010xxxxxx : alu_control = 3'b111;
			12'b001000xxxxxx : alu_control = 3'b010;
			12'bxxxxxx100000 : alu_control = 3'b010;
			12'bxxxxxx100010 : alu_control = 3'b110;
			12'bxxxxxx100100 : alu_control = 3'b000;
			12'bxxxxxx100101 : alu_control = 3'b001;
			12'bxxxxxx101010 : alu_control = 3'b111;
			default          : alu_control = 3'b010;
		endcase
	end

endmodule