# SMA Bending Wire Control System Analysis (MATLAB & Simulink)

This repository contains my personal engineering framework for modeling, simulating, and implementing trajectory tracking control for a Shape Memory Alloy (SMA) bending wire actuator based on Lagoudas thermodynamics. The objective of this project is to analyze the tracking limitations of standard linear feedback controllers under material hysteresis and validate a custom path-dependent feedforward architecture.

## Execution and Simulation Steps

### 1. Characterizing Material Hysteresis
To observe the fundamental non-linear behavior of the SMA wire:
1. Open the Simulink model `HysteresisLoopGenerating.slx`.
2. Execute the MATLAB script `Hysteresisloop.m` to run the simulation and generate the hysteresis curve.
*Note: Time-series data is explicitly exported to MATLAB for plotting because rendering via the native Simulink X-Y Graph block significantly slows down solver execution.*

### 2. Evaluating the Baseline PI Controller
To analyze how a conventional linear feedback loop performs against the reference trajectory:
* Open and execute `PIDcontrol.slx`.
* **Control Configuration Note:** If you adjust or tune the controller gains, ensure you maintain a **negative gain configuration**. Due to the underlying physical behavior of this bending system, an increase in thermal input results in a decrease in wire curvature, requiring an inverted control effort.

### 3. Executing the FORC Data Collection Framework
Because material hysteresis creates a multi-valued mapping problem (where a single curvature value corresponds to multiple temperatures depending on the directional path), standard linear feedback lags behind. To resolve this, I implemented an empirical First-Order Reversal Curve (FORC) methodology:
1. Open `FORCMODEL.slx` (*keep the file open, but do not initiate the simulation directly within Simulink*).
2. Execute the automated MATLAB script `generate_forc.m`.
3. This script orchestrates 50 sequential experimental trials. It systematically heats the wire past its transition point, cools it down to progressively smaller reversal temperatures, and reheats it to map the internal phase transformation paths. Utilizing a 50-sample resolution provided the precision necessary to fully characterize the hysteresis region.
4. Once the data collection finishes, execute `tablesextractingscript.m` to isolate and export two separate 1-D lookup tables—one explicitly mapping the heating trajectory and the other mapping the cooling trajectory.

### 4. Validating the Path-Dependent Feedforward Architecture
To verify the tracking performance of the completed feedforward control loop:
1. Open and execute the model `FinalShape.slx`.
2. This architecture integrates the two extracted 1-D lookup tables alongside a dynamic Simulink switch block. The switch evaluates the path direction of the tracking signal in real time, instantly dictating which temperature table to utilize.
3. Upon opening the Scope block, the output position error signal demonstrates that tracking and calculation delays are completely eliminated, validating the efficacy of the feedforward loop.

---

## Technical Specifications & Model Limitations

* **Solver Configuration Requirements:** If you extract the core `pure_bending_sma_wire` subsystem to run independent test cases, you must manually adjust the configuration parameters (`Ctrl + E`). The block requires a **Fixed-Step Solver** set to **ode4 (Runge-Kutta)** with an explicit fixed step size of `0.0001` seconds to ensure numerical simulation stability.
* **Acknowledged Simplifications:** To maintain analytical clarity in this stage of development, the model contains two main engineering limitations:
  1. The FORC dataset is calculated entirely under a single, constant mechanical bending load.
  2. The simulation lacks an electro-thermal subsystem block; temperature is driven directly as an ideal input signal, bypassing physical Joule heating and convective cooling delays.
* *I am currently developing solutions for both constraints and will demonstrate the integration of the dynamic loading and electro-thermal models in my upcoming explanation videos.*

## Technical Documentation
For the comprehensive mathematical derivations, thermodynamic state equations, and detailed experimental analysis supporting this project, please refer to my attached technical report: **`Shape memory alloy.pdf`**.
