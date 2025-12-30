# FPGA Smart Traffic Light Controller

This project implements a digital traffic light control system designed for an FPGA. It manages the timing between car signals and pedestrian crossings, featuring a priority request system for pedestrians.

## 🚦 System Overview
The system alternates priority between vehicles and pedestrians using a Finite State Machine (FSM). It includes a configurable counter to manage different state durations and a frequency divider to bridge the gap between high-frequency FPGA oscillators and real-time signaling.

### Key Features
* **FSM-Driven Logic:** Four distinct states (Q0-Q3) managing Red, Yellow, and Green transitions.
* **Pedestrian Priority:** Asynchronous request handling that triggers a shorter car-green phase (Q2) to expedite pedestrian access.
* **Clock Management:** Frequency divider scaling a 100MHz input clock down to 1Hz for human-readable timing.
* **Synchronized Reset Architecture:** Utilizes a Flip-Flop and OR-gate logic to ensure the counter resets precisely when state transitions occur.

## 🏗️ Architecture
The project follows a modular TOP-level structure:
1. **CLK_DIV:** Scales the 100MHz system clock.
2. **FSM:** The "brain" of the system, determining light patterns and timing limits.
3. **COUNTER:** A 3-bit configurable counter that tracks elapsed time in each state.
4. **FF & OR:** Synchronization logic to prevent timing drifts during resets.

## 🛣️ State Machine Logic
* **Q0:** Pedestrian Green / Car Red (Duration: 7s).
* **Q1:** Car Green / Pedestrian Red (Duration: 7s).
* **Q2:** Car Green Short / Pedestrian Red (Duration: 3s) - Triggered by pedestrian request.
* **Q3:** Car Yellow / Pedestrian Red (Duration: 3s).

## 🛠️ Hardware Requirements
* **FPGA Board:** (e.g., Basys 3 or Nexys A7)
* **Inputs:** * `BTNO` for System Reset.
    * `SW0` for Pedestrian Request.
* **Outputs:** * `RGB0` for Pedestrian Lights (Red/Green).
    * `RGB1` for Car Lights (Red/Yellow/Green).

## 💻 Simulation
To simulate the timing logic without waiting for the frequency divider:
1. Bypass the `clk_div` in the `top` module.
2. Connect `clk_100MHz` directly to the FSM and Counter clock inputs.
3. Run the provided Testbench to observe state transitions and counter resets.
