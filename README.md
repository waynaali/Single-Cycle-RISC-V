# Single-Cycle RISC-V Processor (RV32I) 🚀

[![Language](https://img.shields.io/badge/Language-SystemVerilog-blue)](https://www.verilog.com/) 
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE) 
[![Simulation](https://img.shields.io/badge/Simulation-Passed-brightgreen)](https://www.modeltech.com/) 
[![Waveform](https://img.shields.io/badge/Waveform-Verified-blueviolet)](tb_riscv_single_behav.wcfg)

A **modular single-cycle RISC-V processor** implemented in SystemVerilog, supporting **RV32I instructions**.  
Ideal for **learning CPU architecture, simulation, and FPGA prototyping**.

---

## Table of Contents

- [Project Overview](#-project-overview)
- [Folder Structure](#-folder-structure)
- [Core Datapath Modules](#-core-datapath-modules)
- [Control Path Modules](#-control-path-modules)
- [Execution & Utility Modules](#-execution--utility-modules)
- [Verification Files](#-verification-files)
- [Documentation & Results](#-documentation--results)
- [Simulation Instructions](#-simulation-instructions)
- [Contribution & Learning](#-contribution--learning)

---

## 🧩 Project Overview

This processor uses a **hierarchical, modular design**, where each SystemVerilog file corresponds to a **functional block in the RISC-V datapath**, improving:

- Readability  
- Testability  
- Extensibility  

**Key Features:**
- Supports **R-type, I-type, Load, Store, Branch, and JAL instructions**  
- Executes **each instruction in a single clock cycle**  
- Modular components for **datapath, control, and utilities**  
- Compatible with **ModelSim / QuestaSim simulation**

---

## 🗂️ Folder Structure

```

Single-Cycle-RISC-V/
├── LICENSE
├── README.md
├── inst.mem                        # Instruction memory initialization
├── tb_riscv_single_behav.wcfg      # Waveform config
├── testbench.sv                    # Testbench
├── riscv_single.sv                 # Top-level CPU module
├── pc.sv
├── adder.sv
├── instr_mem.sv
├── register_file.sv
├── data_mem.sv
├── control_unit.sv
├── main_decoder.sv
├── Alu_decoder.sv
├── ALU.sv
├── ALUResult.sv
├── ExtendUnit.sv
├── mux2to1.sv
├── result_mux.sv (mux3to1)
├── rsc.jfif                        # Block diagram image
├── verified.png                     # Control signals verification
├── verified3.png                    # Control signals verification 2
├── mysinglecycle.jfif               # Simulation waveform

````

---

## 🔹 Core Datapath Modules

<details>
<summary>Click to expand</summary>

| Module | Description |
|--------|------------|
| `riscv_single.sv` | Top-level module connecting all datapath and control modules. |
| `pc.sv` | Program Counter register; updates instruction address every clock. |
| `adder.sv` | Calculates `PC + 4` and branch/jump targets. |
| `instr_mem.sv` | Instruction memory accessed by the PC. |
| `register_file.sv` | 32 general-purpose registers (x0–x31) with 2 read ports and 1 write port. |
| `data_mem.sv` | Data memory for `lw` and `sw` instructions. |

</details>

---

## 🔹 Control Path Modules

<details>
<summary>Click to expand</summary>

| Module | Description |
|--------|------------|
| `control_unit.sv` | Generates high-level control signals from opcode. |
| `main_decoder.sv` | Decodes opcode to determine datapath behavior. |
| `Alu_decoder.sv` | Generates ALU operation based on `funct3` and `funct7`. |

</details>

---

## 🔹 Execution & Utility Modules

<details>
<summary>Click to expand</summary>

| Module | Description |
|--------|------------|
| `ALU.sv` | Performs arithmetic/logical operations: add, sub, and, or, slt. |
| `ALUResult.sv` | Holds ALU output for forwarding. |
| `ExtendUnit.sv` | Sign-extends immediates for I, S, B, and J formats. |
| `mux2to1.sv` | 2-to-1 multiplexer used in datapath. |
| `result_mux.sv` (`mux3to1`) | Selects write-back data: ALU result, memory output, or PC + 4. |

</details>

---

## 🔹 Verification Files

<details>
<summary>Click to expand</summary>

| File | Description |
|------|------------|
| `testbench.sv` | SystemVerilog testbench for functional verification. |
| `tb_riscv_single_behav.wcfg` | Waveform configuration file for simulation. |
| `inst.mem` | Memory initialization file with sample instructions. |

</details>

---

## 📊 Documentation & Results

### 🧠 Single-Cycle RISC-V Architecture Block Diagram

<img src="https://raw.githubusercontent.com/waynaali/Single-Cycle-RISC-V/refs/heads/main/doc/block_diagram.jfif">

### ✅ Control Signal Verification

<img src="https://raw.githubusercontent.com/waynaali/Single-Cycle-RISC-V/refs/heads/main/doc/verification.jfif">  
<img src="https://raw.githubusercontent.com/waynaali/Single-Cycle-RISC-V/refs/heads/main/doc/verification%20(2).jfif">

### 📈 Simulation Waveform

<img src="https://github.com/waynaali/Single-Cycle-RISC-V/blob/main/doc/waveform.jfif">

---

## ▶️ Simulation Instructions

1. Open the project in **ModelSim / QuestaSim**  
2. Compile all **`.sv`** files  
3. Set **`testbench.sv`** as the top module  
4. Run the simulation  
5. Load **`tb_riscv_single_behav.wcfg`** to view waveforms  

**Optional:** Use VCD dump for waveform inspection:

```systemverilog
initial begin
    $dumpfile("tb_risc.vcd");
    $dumpvars(0, tb_risc);
end
````

---

## 🌟 Contribution & Learning

* Modular design allows **easy extension** to pipelined or multi-cycle RISC-V processors
* Perfect for **educational purposes**, CPU design practice, and simulation
* Feel free to **star this repository** or **share it with fellow learners**

⭐ *If this project is helpful, please consider starring the repo!*

```

