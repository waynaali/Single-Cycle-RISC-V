## 🧩 Module Overview

The processor is implemented in a **modular and hierarchical** manner. Each SystemVerilog file corresponds to a well-defined functional block in the **single-cycle RISC-V datapath**, improving readability, testability, and future extensibility.

---

## 🔹 Core Datapath Modules

- **`riscv_single.sv`**  
  Top-level module that instantiates and interconnects all datapath and control components.

- **`pc.sv`**  
  Program Counter register that holds the current instruction address and updates every clock cycle.

- **`adder.sv`**  
  Used for PC increment (**PC + 4**) and branch target address calculation.

- **`instr_mem.sv`**  
  Instruction memory module that fetches instructions using the PC address.

- **`register_file.sv`**  
  Implements **32 general-purpose registers (x0–x31)** with two read ports and one write port.

- **`data_mem.sv`**  
  Data memory module used by **load (`lw`)** and **store (`sw`)** instructions.

---

## 🔹 Control Path Modules

- **`control_unit.sv`**  
  Generates high-level control signals based on the instruction opcode.

- **`main_decoder.sv`**  
  Decodes instruction opcodes and determines overall datapath behavior.

- **`Alu_decoder.sv`**  
  Decodes **`funct3`** and **`funct7`** fields to select the appropriate ALU operation.

---

## 🔹 Execution & Utility Modules

- **`ALU.sv`**  
  Performs arithmetic and logical operations such as **add, sub, and, or, xor, slt**.

- **`ALUResult.sv`**  
  Holds and forwards the ALU output to later stages of the datapath.

- **`ExtendUnit.sv`**  
  Generates sign-extended immediates for **I, S, B, and J** instruction formats.

- **`mux2to1.sv`**  
  2-to-1 multiplexer used throughout the datapath.

- **`result_mux.sv` (`mux_3to1`)**  
  Selects the final write-back data (**ALU result, memory output, or PC + 4**).

---

## 🔹 Verification Files

- **`testbench.sv`**  
  SystemVerilog testbench used for functional verification.

- **`tb_riscv_single_behav.wcfg`**  
  Waveform configuration file for simulation visualization.

- **`inst.mem`**  
  Memory initialization file containing test instructions.

---

## 📊 Documentation & Results

### 🧠 Single-Cycle RISC-V Architecture Block Diagram

<img src="rsc.jfif" width="700">

---

### ✅ Control Signal Verification

<img src="verified.png" width="750">

<img src="verified3.png" width="750">

---

### 📈 Simulation Waveform

<img src="mysinglecycle.jfif" width="800">

---

## ▶️ How to Run Simulation

1. Open the project in **ModelSim / QuestaSim**
2. Compile all **`.sv`** files
3. Set **`testbench.sv`** as the top module
4. Run the simulation
5. Load **`tb_riscv_single_behav.wcfg`** to view waveforms

---

⭐ *If you find this project useful, feel free to star the repository or share it with others who are learning RISC-V.*
