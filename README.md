# ALU UVM Verification

This repository contains a Universal Verification Methodology (UVM) testbench for verifying a simple Arithmetic Logic Unit (ALU). The design under test (DUT) supports operations such as **ADD**, **SUB**, **NOT_A**, and **REDUCTIONOR_B**, along with a reset feature. The goal is to ensure correct functionality, robust corner-case handling, and sufficient coverage of all critical scenarios.

## Table of Contents
1. [Overview](#overview)  
2. [Repository Structure](#repository-structure)  
3. [Key Features of the Verification Plan](#key-features-of-the-verification-plan)  
---

## Overview
- **DUT**: The ALU processes two signed inputs (**A**, **B**) and produces an output (**C**) based on an opcode. It also supports a reset that forces the output to zero.  
- **Verification Methodology**: UVM (Universal Verification Methodology) in SystemVerilog.  
- **Primary Goals**:  
  - Validate all functional operations (ADD, SUB, NOT_A, REDUCTIONOR).  
  - Verify reset behavior and timing.  
  - Achieve coverage across opcodes and operand ranges.  
  - Compare DUT outputs against a reference model using.

---

## Repository Structure

A high-level description of the main files used in this verification environment:

- **ALU.sv**  
  The RTL design of the ALU itself.

- **ALU_if.sv**  
  SystemVerilog interface for signals, clock, and reset handling.

- **ALU_types_pkg.sv**  
  Contains typedefs, enums, and other data type definitions used across the testbench.

- **ALU_coverage_pkg.sv**  
  Defines coverage groups and coverpoints to measure functional coverage for opcodes, operand ranges, etc.

- **ALU_seq_item.sv**  
  Defines the transaction object (sequence item) for stimuli.

- **ALU_driver.sv**  
  Drives signals onto the DUT inputs based on the sequence items.

- **ALU_monitor.sv**  
  Monitors signals on the bus/interface to collect data for coverage and scoreboard comparison.

- **ALU_scoreboard.sv**  
  Compares the DUT output against a reference model or expected results and flags any mismatches.

- **ALU_agent.sv**  
  Bundles the driver, monitor, and (optionally) coverage into a reusable UVM agent.

- **ALU_env.sv**  
  Top-level UVM environment that instantiates the agent(s), scoreboard, and coverage components.

- **ALU_test.sv**  
  The UVM test class that configures the environment, sets up sequences, and runs the simulation.

- **ALU_main_sequence.sv**  
  Main stimulus sequence that generates a variety of opcode and operand combinations.

- **ALU_reset_sequence.sv**  
  Sequence dedicated to testing reset behavior and ensuring the DUT resets properly.

- **top.sv**  
  A top-level module that instantiates the DUT and the UVM testbench, typically with clock and reset generation.

---

## Key Features of the Verification Plan

### Reset Behavior
- Ensures the ALU output is driven to zero upon reset activation.  
- Confirms reset takes precedence over normal operations.

### Opcode Functionality (ADD, SUB, NOT_A, REDUCTIONOR_B)
- Randomized and directed tests cover a wide range of signed inputs for **A** and **B**.  
- Confirms the ALU operations produce correct results for edge and typical values.

### Scoreboard & Reference Model
- A scoreboard compares DUT outputs to expected results on every clock cycle.  
- Flags mismatches and reports errors for immediate debug.

### Assertions
- Checks for correct update timing of output **C** on the rising edge of the clock.  
- Ensures reset overrides normal operation if triggered.

### Coverage
- **Opcode Coverage**: All ALU operations (ADD, SUB, NOT_A, REDUCTIONOR_B) are exercised.  
- **Operand Range Coverage**: Monitors edge cases, typical ranges, and overflow scenarios for signed inputs **A** and **B**.

### Corner Cases
- Tests with extreme values.

---

Finally, I'd like to acknowledge that the organizational approach used in this repository is largely inspired by the FIFO environment from [this repository](https://github.com/asmaaalzahry/Asynchronous-FIFO-_-using-UVM), which greatly streamlined the structure and design of this UVM verification environment.
