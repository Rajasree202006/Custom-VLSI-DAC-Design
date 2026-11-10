# Custom-VLSI-DAC-Design

Design and simulation of a custom Digital-to-Analog Converter (DAC) using VLSI concepts, including DAC architecture design, quantization error analysis, and performance evaluation through simulation.

---

## Project Structure

```text
Custom-VLSI-DAC-Design/
├── Custom_4bit_DAC_Corrected_Verilog/
│   ├── custom_dac_4bit.v       # Synthesizable behavioral RTL model of 4-bit DAC
│   ├── tb_custom_dac_4bit.v    # Self-checking testbench testing all 16 input codes
│   └── README.txt              # Detailed design notes and simulation instructions
└── README.md                   # Project overview and documentation
```

---

## Design Specifications

- **Resolution:** 4 bits
- **Number of Input Codes:** 16 ($0000_2$ to $1111_2$)
- **Reference Voltage ($V_{\text{REF}}$):** 5.0 V
- **Transfer Equation:**
  $$V_{\text{OUT}} = \left(\frac{D}{16}\right) \times V_{\text{REF}}$$
- **LSB Step Size:** $5.0\text{ V} / 16 = 0.3125\text{ V}$
- **Digital Output Representation:** 12-bit digital numerical code:
  $$\text{Code} = \left\lfloor\frac{D \times 4095}{16}\right\rfloor$$

---

## Simulation & Verification

The testbench (`tb_custom_dac_4bit.v`) automatically tests all 16 input codes against expected output codes and ideal analog voltages.

### Running with ModelSim / QuestaSim

```bash
cd Custom_4bit_DAC_Corrected_Verilog
vlog custom_dac_4bit.v
vlog tb_custom_dac_4bit.v
vsim -c tb_custom_dac_4bit -do "run -all; quit"
```

### Running with Icarus Verilog (iverilog)

```bash
cd Custom_4bit_DAC_Corrected_Verilog
iverilog -o dac_sim custom_dac_4bit.v tb_custom_dac_4bit.v
vvp dac_sim
```

### Expected Output

All 16 input codes (0000 to 1111) are evaluated, and the test prints `PASS` for each code followed by:
```text
RESULT: PASS - all 16 input codes verified.
```
