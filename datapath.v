module datapath(
    input clk,
    input [2:0] alucontrol,
    input alu_src,
    input branch,
    input jump,
    input mem_to_reg,
    input mem_write,
    input reg_dst,
    input reg_write,
    input [31:0] instruction,
    output [31:0] alu_result,
    output [31:0] write_data
);
    reg [31:0] pc;
    wire [31:0] read_data;
    wire [31:0] pc_plus_4;
    Nbit_adder #(32) adder(pc, 32'b00000000000000000000000000000100, 1'b0, pc_plus_4);

    wire [31:0] branch_target;
    Nbit_adder #(32) br_target(pc_plus_4, {{14{instruction[15]}}, instruction[15:0], 2'b0}, 1'b0, branch_target);

    wire [31:0] pc_after_beq;
    wire zero;
    assign pc_after_beq = (branch && zero) ? branch_target : pc_plus_4;

    wire [31:0] jump_target;
    assign jump_target = {pc[31:28], instruction[25:0], 2'b0};
    wire [31:0] pc_after_jump;
    assign pc_after_jump = (jump) ? jump_target : pc_after_beq;

    initial begin
        pc = 32'b000;
    end

    always @(posedge clk) begin
        pc <= pc_after_jump;
    end

    wire [4:0] rs;
    assign rs = instruction[25:21];

    wire [4:0] rt;
    assign rt = instruction[20:16];

    wire [4:0] rd;
    assign rd = instruction[15:11];

    wire [4:0] write_reg;
    assign write_reg = reg_dst ? rt : rd;

    wire [31:0] result;
    assign result = mem_to_reg ? read_data : alu_result;

    wire [31:0] reg_data1;
    wire [31:0] reg_data2;

    regfile registers(
        .clk(clk),
        .rw(reg_write),
        .addr1(rs),
        .addr2(rt),
        .data1(reg_data1),
        .data2(reg_data2),
        .addr3(write_reg),
        .wr_data(result)
    );

    wire [31:0] src;
    assign src = alu_src ? {{16{instruction[15]}}, instruction[15:0]} : reg_data2;

    alu primary_alu(
        .a(reg_data1),
        .b(src),
        .ALUop(alucontrol),
        .zero(zero),
        .y(alu_result)
    );

    // initial begin
    //     $monitor("%b, reg_data2=%b %b %b %b", read_data, reg_data2, rt, instruction, mem_write);
    // end
    assign write_data = reg_data2;
    dmem memory(clk, mem_write, alu_result, reg_data2, read_data);
endmodule
