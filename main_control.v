module main_control(input [31:0] instruction, output branch, output jump, output mem_to_reg, output mem_write, output reg_dst, output reg_write, output alu_src);
    wire [5:0] opcode;
    wire [5:0] funct;

    assign opcode=instruction[31:26];
    assign funct=instruction[5:0];

    wire is_add = (opcode == 6'b000000) && (funct == 6'b100000);
    wire is_sub = (opcode == 6'b000000) && (funct == 6'b100010);
    wire is_and = (opcode == 6'b000000) && (funct == 6'b100100);
    wire is_or = (opcode == 6'b000000) && (funct == 6'b100101);
    wire is_slt = (opcode == 6'b000000) && (funct == 6'b101010);

    wire is_lw = (opcode == 6'b100011);
    wire is_sw = (opcode == 6'b101011);

    wire is_addi = (opcode == 6'b001000);
    
    assign branch = (opcode == 6'b000100);
    assign jump = (opcode == 6'b000010);
    assign mem_to_reg = is_lw;
    assign mem_write = is_sw;
    assign reg_dst = is_lw;
    assign reg_write = is_add || is_sub || is_and || is_or || is_slt || is_lw || is_addi;
    assign alu_src = is_addi || is_lw || is_sw;
endmodule