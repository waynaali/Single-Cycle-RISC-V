# Single-Cycle-RISC-V
This repository presents the RTL design and verification of a 32-bit single-cycle RISC-V processor implemented in SystemVerilog. The processor follows the RV32I instruction set and executes each instruction in one clock cycle, integrating core components, program counter, instruction memory, register file, ALU, control unit, and data memory.

## 📌 Supported Instructions

* R-type: `add, sub, and, or, xor, slt`
* I-type: `addi, andi, ori, lw`
* S-type: `sw`
* B-type: `beq, bne`
* J-type: `jal`
## 🧱 Processor Architecture

* 32-bit Single-Cycle RISC-V (RV32I)
* One instruction executed per clock cycle
* Modular RTL design:

  * Program Counter (PC)
  * Instruction Memory
  * Register File
  * ALU & ALU Control
  * Main Control Unit
  * Data Memory
  * Immediate Generator
  * Branch & Jump Logic
## 🧪 Verification Strategy
* Instruction-level verification using SystemVerilog testbenches
* Validation of:
  * PC update logic
  * Register write-back
  * ALU operations
  * Load/store memory access
* Simulation waveform analysis using **GTKWave / Vivado**

## 🛠 Tools & Technologies

* **SystemVerilog**
* RTL Simulation (Vivado / ModelSim)
* GTKWave
* RISC-V ISA (RV32I)
## 📂 Project Structure
Single-Cycle-RISC-V/
├── rtl/
│   ├── pc.sv
│   ├── alu.sv
│   ├── regfile.sv
│   ├── control_unit.sv
│   └── top.sv
├── tb/
│   └── processor_tb.sv
├── programs/
│   └── test_program.hex
└── README.md
```
## 🚀 How to Run

1. Compile RTL and testbench
2. Load RISC-V program into instruction memory
3. Run simulation
4. Observe waveforms for verification

## 🔮 Future Work

* 5-stage pipelined RISC-V processor
* Data hazard detection & forwarding
* Control hazard handling
* Performance comparison with single-cycle design

### 🔑 Why this matters 

This project demonstrates **strong fundamentals in computer architecture, RTL design, and verification**, and is intended as a stepping stone toward advanced RISC-V and VLSI design work.
