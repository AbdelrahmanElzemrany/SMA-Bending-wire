# Shape Memory Alloy (SMA) Bending Wire Control System

This repository contains a MATLAB and Simulink framework designed to model, analyze, and implement precise trajectory tracking control for a Shape Memory Alloy (SMA) bending wire actuator using Lagoudas thermodynamics.

## Getting Started & Execution Steps

### 1. Characterizing Hysteresis
To observe and plot the material's structural hysteresis loop:
1. Open the Simulink model `HysteresisLoopGenerating.slx`.
2. Run the MATLAB script `Hysteresisloop.m` to automatically simulate the model, export the data, and generate the clean hysteresis curve.
*Note: While you can use the built-in Simulink X-Y Graph block by connecting input temperature to the X-axis and output curvature to the Y-axis, exporting the time-series data to MATLAB runs significantly faster.*

### 2. PID Controller Implementation
To evaluate standard feedback performance:
* Open `PIDcontrol.slx` to test the system's baseline tracking capabilities.
* **Tuning Note:** When adjusting or tuning controller gains, ensure you maintain a **negative gain configuration**. Due to the underlying physical behavior of this bending system, increasing the heat inputs results in decreased curvature.

### 3. First-Order Reversal Curves (FORC) & Feedforward Control
To bypass feedback limitations and eliminate tracking delays, a path-dependent feedforward architecture is implemented:
1. **Data Collection:** Open `FORCMODEL.slx` (*do not run it directly via the Simulink interface*) and execute the script `generate_forc.m` to automatically run the 50 thermal cycling trials.
2. **Lookup Table Extraction:** Run `tablesextractingscript.m` to process the captured reversal trajectories and extract two distinct 1-D lookup tables—one for the heating path and one for the cooling path—effectively eliminating the multi-valued mathematical problem.

---

## Configuration Warnings & Technical Notes

* **Solver Settings:** If you extract the core model block (`pure_bending_sma_wire`) to run custom experiments, you must configure the configuration parameters (`Ctrl + E`). Change the default variable-step solver to a **Fixed-Step Solver**, select **ode4 (Runge-Kutta)**, and explicitly define a fixed step size of `0.0001` seconds.
* **Material Modeling:** The actuator wire is modeled using the Lagoudas thermodynamic framework subjected to a constant tip bending load. Users can modify critical transformation temperatures ($M_f, M_s, A_s, A_f$), Young's Modulus for both phases, and mechanical loading profiles directly within the block mask parameters.
* **Project Objective:** The ultimate goal of this framework is to validate a path-dependent feedforward lookup strategy that eliminates the severe multi-second tracking delays inherent to standard linear PID controllers.

---

## Documentation
For a deep dive into the complete mathematical framework, thermodynamic state equations, and experimental data analysis, please refer to the included document: **`Shape memory alloy.pdf`**.

