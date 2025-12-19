# Single-Cycle RISC-V Processor (RV32I)

## 📌 Overview

This project implements a **32-bit Single-Cycle RISC-V processor** using **SystemVerilog**, based on the **RV32I base integer instruction set**. Each instruction completes execution in **one clock cycle**, making this design ideal for learning and understanding **CPU datapath and control logic**.

The processor is built at the **RTL level** and includes all essential components of a basic RISC-V CPU, along with a testbench for functional verification.

---

## 🧠 Architecture Summary

The processor follows the classical **single-cycle datapath**, where instruction fetch, decode, execute, memory access, and write-back occur within one clock cycle.

### 🔧 Major Components

* **Program Counter (PC)** – Holds the address of the current instruction
* **Instruction Memory** – Stores RISC-V instructions
* **Register File** – 32 general-purpose registers (x0–x31)
* **Immediate Generator** – Generates immediate values for I, S, B, J formats
* **Control Unit** – Generates control signals based on opcode
* **ALU Control Unit** – Decodes ALU operations
* **Arithmetic Logic Unit (ALU)** – Executes arithmetic and logical operations
* **Data Memory** – Used for load and store instructions
* **Multiplexers** – Control data flow in the datapath

---

## 📜 Supported Instructions (RV32I Subset)

### ✅ R-Type

* `add`, `sub`, `and`, `or`, `xor`, `slt`

### ✅ I-Type

* `addi`, `andi`, `ori`, `lw`

### ✅ S-Type

* `sw`

### ✅ B-Type

* `beq`, `bne`

### ✅ J-Type

* `jal`

> ⚠️ This is a **learning-focused subset** of RV32I. Instructions like `lui`, `auipc`, and shift operations can be added as future enhancements.

---

## 🧪 Verification

* A **SystemVerilog testbench** is included to verify processor functionality.
* Instructions are executed and validated through simulation.

### Suggested Simulation Tools

* ModelSim / QuestaSim
* Vivado Simulator
* Icarus Verilog (basic support)

---

## ▶️ How to Run (Example: ModelSim)

```bash
vlog *.sv
vsim work.testbench
run -all
```

---

## 📁 Repository Structure

```
Single-Cycle-RISC-V/
│── alu.sv
│── control_unit.sv
│── datapath.sv
│── reg_file.sv
│── instruction_memory.sv
│── data_memory.sv
│── testbench.sv
│── README.md
```

---

## 🚀 Future Improvements

* Add remaining RV32I instructions (`lui`, `auipc`, shifts)
* Implement **pipeline architecture** (5-stage RISC-V)
* Add **hazard detection and forwarding**
* FPGA synthesis and implementation
* Automated test suite and instruction-level verification

---

## 🎯 Learning Outcomes

This project demonstrates understanding of:

* RISC-V instruction formats
* CPU datapath and control logic
* RTL design using SystemVerilog
* Simulation and verification techniques

---

## 👤 Author

**Wayna Ali**
GitHub: [https://github.com/waynaali](https://github.com/waynaali)

---

⭐ If you find this project helpful, feel free to star the repository!
