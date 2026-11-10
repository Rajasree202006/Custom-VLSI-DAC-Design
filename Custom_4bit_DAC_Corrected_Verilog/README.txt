CUSTOM 4-BIT DAC - CORRECTED VERILOG PROJECT
=============================================

Files
-----
1. custom_dac_4bit.v       - Synthesizable-style behavioral RTL model
2. tb_custom_dac_4bit.v    - Testbench checks all 16 input codes
3. README.txt              - This guide

Design details
--------------
- Resolution: 4 bits
- Number of input codes: 16 (0000 to 1111)
- Reference voltage used for explanation: 5 V
- Transfer equation: VOUT = (D / 16) * VREF
- LSB step: 5 / 16 = 0.3125 V
- Output code: floor(D * 4095 / 16), represented by 12 bits

Important clarification
-----------------------
The Verilog module models the ideal DAC transfer function. Its 12-bit
"analog_out" port is a DIGITAL numerical code representing the analog
voltage level; Verilog RTL simulation does not generate a physical voltage.

The report describes an R-2R ladder architecture conceptually, but this
RTL does not instantiate physical R and 2R resistors, switches, or an
analog output stage. A transistor/resistor-level implementation would
require a separate analog schematic and SPICE/mixed-signal simulation.

Quantization-error clarification
--------------------------------
The commonly quoted +/-0.5 LSB maximum error applies to rounding to the
nearest available level. The RTL mapping here uses integer division
(truncation) for the digital output code. Do not claim that this exact
truncating implementation performs nearest-level rounding.

How to simulate in ModelSim / QuestaSim
---------------------------------------
1. Extract this ZIP file.
2. Open ModelSim/QuestaSim.
3. Change directory to the extracted folder.
4. Compile:
      vlog custom_dac_4bit.v
      vlog tb_custom_dac_4bit.v
5. Run:
      vsim -c tb_custom_dac_4bit -do "run -all; quit"

Expected behavior
-----------------
The testbench applies all 16 input combinations and prints:
- binary input
- decimal input
- 12-bit output code
- ideal voltage in volts
- PASS/FAIL result

All 16 cases should display PASS.
