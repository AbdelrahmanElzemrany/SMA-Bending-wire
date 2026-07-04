# SMA Bending Wire Control System Analysis (MATLAB & Simulink)

This repository contains the complete engineering framework for modeling, simulating, and implementing trajectory tracking control for a Shape Memory Alloy (SMA) bending wire actuator based on Lagoudas thermodynamics. The objective of this project was to analyze the tracking limitations of standard linear feedback controllers under material hysteresis and successfully validate a custom path-dependent feedforward architecture.

## Execution and Simulation Steps

### 1. Characterizing Material Hysteresis
To observe the fundamental non-linear behavior of the SMA wire:
1. Open the Simulink model `Sec1_Step_1_Hysteresis_in_SMAs.slx`.
2. Execute the MATLAB script `Sec1_Step_2_HysteresisPlot.m` to run the simulation and generate the hysteresis curve.
*Note: Time-series data is explicitly exported to MATLAB for plotting because rendering via the native Simulink X-Y Graph block significantly slows down solver execution.*

### 2. Evaluating the Baseline PI Controller
To analyze how a conventional linear feedback loop performs against the reference trajectory:
1. Open and execute `Sec2_Step_1_PIDControl.slx`.
2. Execute the MATLAB script `Sec2_Step_2_SMABehaviourWithPID.m` to run the loop tracking analysis and evaluate performance.
* **Control Configuration Note:** If you adjust or tune the controller gains, ensure you maintain a **negative gain configuration**. Due to the underlying physical behavior of this bending system, an increase in thermal input results in a decrease in wire curvature, requiring an inverted control effort.

### 3. Executing the FORC Data Collection Framework
Because material hysteresis creates a multi-valued mapping problem (where a single curvature value corresponds to multiple temperatures depending on the directional path), standard linear feedback lags behind. To resolve this, I implemented an empirical First-Order Reversal Curve (FORC) methodology:
1. Open `Sec3_Step_1_FORC_Experiment.slx` (*keep the file open, but do not initiate the simulation directly within Simulink*).
2. Execute the automated MATLAB script `Sec3_Step_2_FORC_Initialization.m`.
3. This script orchestrates 50 sequential experimental trials. It systematically heats the wire past its transition point, cools it down to progressively smaller reversal temperatures, and reheats it to map the internal phase transformation paths. Utilizing a 50-sample resolution provided the precision necessary to fully characterize the hysteresis region.

### 4. Validating the Path-Dependent Feedforward Architecture
To isolate the data profiles and verify the tracking performance of the completed feedforward control loop:
1. Execute `Sec4_Step_1_tablesextractingscript.m` to isolate and export two separate 1-D lookup tables—one explicitly mapping the heating trajectory and the other mapping the cooling trajectory from the generated data file.
2. Open the model `Sec4_Step_2_FinalShape.slx`. This architecture integrates the two extracted 1-D lookup tables alongside a dynamic Simulink switch block. The switch evaluates the path direction of the tracking signal in real time, instantly dictating which temperature table to utilize.
3. Run the verification script `Sec4_Step_3_SMABehaviourWithFFTables.m` to plot the final tracking results. Upon opening the Scope block, the output position error signal demonstrates that tracking and calculation delays are completely eliminated, validating the efficacy of the feedforward loop.

---

## Technical Specifications & Model Boundary Conditions

* **Solver Configuration Requirements:** If you extract the core `pure_bending_sma_wire` subsystem to run independent test cases, you must manually adjust the configuration parameters (`Ctrl + E`). The block requires a **Fixed-Step Solver** set to **ode4 (Runge-Kutta)** with an explicit fixed step size of `0.0001` seconds to ensure numerical simulation stability.
* **Scoping and Boundary Assumptions:** For this specific simulation model stage, two key boundary conditions were established:
  1. The FORC dataset is calculated under a single, constant mechanical bending load.
  2. Temperature is driven directly as an ideal input signal, separating the core thermodynamic material behavior from external electro-thermal delays like physical Joule heating or convective environmental cooling.
*These limitations are discussed in subsequent repositories.

## Technical Documentation
For the comprehensive mathematical derivations, thermodynamic state equations, and detailed experimental analysis supporting this project, please refer to my attached technical report: **`Shape memory alloy.pdf`**.
