module controller (
	input  [31:0] instruction     ,
	// other side
	output        branch    ,
	output        jump      ,
	output        mem_to_reg,
	output        mem_write ,
	output        reg_dst   ,
	output        reg_write ,
	// alu side
	output [ 2:0] alu_control,
	output        alu_src
);

	main_control maindec_inst (
		.instruction     (instruction     ),
		.branch    (branch    ),
		.jump      (jump      ),
		.mem_to_reg(mem_to_reg),
		.mem_write (mem_write ),
		.reg_dst   (reg_dst   ),
		.reg_write (reg_write ),
		.alu_src   (alu_src   )
	);

	alu_control aludec_inst (
		.instruction     (instruction     ),
		.alu_control(alu_control)
	);

endmodule