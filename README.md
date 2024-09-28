# MIPS-Single-Cycle-CPU-in-Verilog
## Requirements

- **Icarus Verilog**: Make sure you have Icarus Verilog installed. You can download it from [here](https://steveicarus.github.io/iverilog/).

## How to Run

To execute the Verilog code, follow these steps:

1. Open a terminal in the project directory.
2. Run the following command to compile the Verilog files:
   ```bash
   iverilog -o output_name *.v

This automatically tests and outputs the result of a register-register add instruction, a conditional branch (which here should evaluate to true), an unconditional jump and load and store word.