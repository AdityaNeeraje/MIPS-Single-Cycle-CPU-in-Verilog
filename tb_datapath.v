module datapath_tb();

  reg clk;
  reg rst;
  reg [31:0] instruction;
  reg [31:0] read_data;

  wire branch;
  wire jump;
  wire mem_to_reg;
  wire mem_write;
  wire reg_dst;
  wire reg_write;
  wire [2:0] alucontrol;
  wire alu_src;

  wire [31:0] alu_result;
  wire [31:0] write_data;

  datapath uut (
    .clk(clk),
    .alucontrol(alucontrol),
    .alu_src(alu_src),
    .branch(branch),
    .jump(jump),
    .mem_to_reg(mem_to_reg),
    .mem_write(mem_write),
    .reg_dst(reg_dst),
    .reg_write(reg_write),
    .instruction(instruction),
    .alu_result(alu_result),
    .write_data(write_data)
  );

  controller uut_controller (
    .instruction(instruction),
    .branch(branch),
    .jump(jump),
    .mem_to_reg(mem_to_reg),
    .mem_write(mem_write),
    .reg_dst(reg_dst),
    .reg_write(reg_write),
    .alu_control(alucontrol),
    .alu_src(alu_src)
  );

  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    instruction = 32'b0; // Default no-op instruction
    read_data = 32'b0;

    #10;

    // Test 1: Add two registers (Reg[rs] + Reg[rt])
    instruction = 32'b000000_00001_00010_00011_00000_100000;  // R-type (add $1 + $2 -> $3)
    #10;  
    
    // Test 2: Branching (BEQ)
    instruction = 32'b000100_00011_00100_0000000010000100;
    #10;  

    // Test 3: Jump
    instruction = 32'b000010_00000000000000000000000100; 
    #10;  
    
    // Test 4: Load from memory (mem_to_reg)
    instruction = 32'b100011_00001_00100_0000000000000010; 
    #10; 

    // Test 5: Write to memory
    instruction = 32'b101011_00001_00010_0000000000000010; 
    #10; 
    $finish;
  end

  always @(posedge clk) begin
    $monitor("Time=%0t | ALU Result=%b | Write Data=%b | Instruction=%b | Control Signals: ALUControl=%b | ALUSrc=%b | Branch=%b | Jump=%b | MemToReg=%b | MemWrite=%b | RegDst=%b | RegWrite=%b", 
    $time, alu_result, write_data, instruction, alucontrol, alu_src, branch, jump, mem_to_reg, mem_write, reg_dst, reg_write);
  end

endmodule