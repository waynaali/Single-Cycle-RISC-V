# Single-Cycle RISC-V Processor (RV32I)

📌 **Overview**  
This project implements a 32-bit Single-Cycle RISC-V processor using SystemVerilog (RV32I subset). Each instruction executes in a single clock cycle.

---

🧠 **Architecture Summary**  
The processor follows the classical single-cycle datapath (IF → ID → EX → MEM → WB).

**Block Diagram:**  
![Block Diagram](docs/rsc.png)

---

🧪 **Verification**  

**Control Signals Verified:**  
This image shows correct assertion of control signals for different instructions.  
![Control Signals Verified](docs/verified.png)

**Simulation Waveform:**  
This waveform shows instruction execution, PC increment, register file updates, and ALU outputs over time.  
![Simulation Waveform](docs/mysingle.jfif)

---

🔧 **Major Components**
- Program Counter (PC)  
- Instruction Memory  
- Register File  
- Immediate Generator  
- Control Unit & ALU Control  
- Arithmetic Logic Unit (ALU)  
- Data Memory  
- Multiplexers

---

📜 **Supported Instructions (RV32I Subset)**  
- **R-Type:** add, sub, and, or, xor, slt  
- **I-Type:** addi, andi, ori, lw  
- **S-Type:** sw  
- **B-Type:** beq, bne  
- **J-Type:** jal  

⚠️ Only a learning-focused subset. Other instructions like LUI, AUIPC, and shift operations can be added later.

---

📁 **Repository Structure**
Single-Cycle-RISC-V/
│── src/ # All modules (ALU, register_file, etc.)
│── tb/ # Testbenches
│── inst/ # Instruction memory files
│── docs/ # Images
│ ├── rsc.png # Block diagram
│ ├── mysingle.jfif # Waveform
│ └── verified.png # Control signals
│── README.md

---

🚀 **Future Improvements**
- Add remaining RV32I instructions  
- Implement 5-stage pipeline  
- Hazard detection & forwarding  
- FPGA synthesis & implementation  
- Automated test suite & instruction-level verification

---

👤 **Author**  
Wayna Ali – [GitHub](https://github.com/waynaali)
