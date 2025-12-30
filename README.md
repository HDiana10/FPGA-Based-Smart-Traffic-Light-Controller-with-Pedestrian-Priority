# FPGA Smart Traffic Light

This project implements a digital traffic light control system designed for an FPGA. It manages the timing between car signals and pedestrian crossings, featuring a priority request system for pedestrians.

## 🚦 System Overview
The system alternates priority between vehicles and pedestrians using a Finite State Machine (FSM). It includes a configurable counter to manage different state durations and a frequency divider to bridge the gap between high-frequency FPGA oscillators and real-time signaling.

### Key Features
* [cite_start]**FSM-Driven Logic:** Four distinct states (Q0-Q3) managing Red, Yellow, and Green transitions [cite: 25, 45-60].
* [cite_start]**Pedestrian Priority:** Asynchronous request handling that triggers a shorter car-green phase (Q2) to expedite pedestrian access [cite: 3, 53-56].
* [cite_start]**Clock Management:** Frequency divider scaling a 100MHz input clock down to 1Hz for human-readable timing [cite: 22, 92-95].
* **Synchronized Reset Architecture:** Utilizes a Flip-Flop and OR-gate logic to ensure the counter resets precisely when state transitions occur.

## 🏗️ Architecture
The project follows a modular TOP-level structure:
1.  [cite_start]**CLK_DIV:** Scales the 100MHz system clock[cite: 22].
2.  [cite_start]**FSM:** The "brain" of the system, determining light patterns and timing limits[cite: 25].
3.  [cite_start]**COUNTER:** A 3-bit configurable counter that tracks elapsed time in each state [cite: 23-24].
4.  **FF & OR:** Synchronization logic to prevent timing drifts during resets.



## 🛣️ State Machine Logic
* [cite_start]**Q0:** Pedestrian Green / Car Red (Duration: 7s) [cite: 45-48].
* [cite_start]**Q1:** Car Green / Pedestrian Red (Duration: 7s) [cite: 49-52].
* [cite_start]**Q2:** Car Green Short / Pedestrian Red (Duration: 3s) - Triggered by pedestrian request [cite: 53-56].
* [cite_start]**Q3:** Car Yellow / Pedestrian Red (Duration: 3s) [cite: 57-60].

## 🛠️ Hardware Requirements
* **FPGA Board:** (e.g., Basys 3 or Nexys A7)
* [cite_start]**Inputs:** * `BTNO` for System Reset[cite: 79].
    * [cite_start]`SW0` for Pedestrian Request[cite: 80].
* [cite_start]**Outputs:** * `RGB0` for Pedestrian Lights (Red/Green)[cite: 81].
    * [cite_start]`RGB1` for Car Lights (Red/Yellow/Green)[cite: 82].

## 💻 Simulation
To simulate the timing logic without waiting for the frequency divider:
1.  Bypass the `clk_div` in the `top` module.
2.  [cite_start]Connect `clk_100MHz` directly to the FSM and Counter clock inputs [cite: 71-72].
3.  Run the provided Testbench to observe state transitions and counter resets.
