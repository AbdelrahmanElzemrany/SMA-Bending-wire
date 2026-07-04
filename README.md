[Click here to view the 8-minute simulation video explaining the whole process.](https://drive.google.com/drive/u/0/folders/1m-NyGNsKJ3eKfLIFNobjmQB3yitPuI5l)
# SMA Bending Wire Control System Analysis (MATLAB & Simulink)

This repository contains the complete engineering framework for modeling, simulating, and implementing trajectory tracking control for a Shape Memory Alloy (SMA) bending wire actuator based on Lagoudas thermodynamics. The objective of this project was to analyze the tracking limitations of standard linear feedback controllers under material hysteresis and successfully validate a custom path-dependent feedforward architecture.

## 🛠️ Pipeline & File Architecture

The repository is structured sequentially to take the system from raw material characterization to a verified path-dependent feedforward tracking controller:

### 1. Characterizing Material Hysteresis
* **Sec1_Step_1_Hysteresis_in_SMAs.slx**: Simulink block diagram modeling the baseline thermomechanical behavior of the SMA wire actuator under a constant mechanical load.
* **Sec1_Step_2_HysteresisPlot.m**: MATLAB execution script that runs the baseline simulation and plots the resulting multi-valued heating and cooling hysteresis paths.

### 2. Evaluating the Baseline PI Controller
* **Sec2_Step_1_PIDControl.slx**: Closed-loop tracking architecture implementing an inverted negative-gain PI loop to fight the underlying material physics.
* **Sec2_Step_2_SMABehaviourWithPID.m**: Post-processing tracking evaluation script displaying the dual-axis response plots to expose pure mathematical calculation lag.

### 3. Executing the FORC Data Collection Framework
* **Sec3_Step_1_FORC_Experiment.slx**: Specialized experimental simulation subsystem utilized to sweep individual thermal reversal loops through the hysteresis bounds.
* **Sec3_Step_2_FORC_Initialization.m**: Automation script orchestrating 50 sequential trial runs to systematically gather high-resolution raw trajectory matrix paths.

### 4. Validating the Path-Dependent Feedforward Architecture
* **Sec4_Step_1_tablesextractingscript.m**: Matrix processing tool that isolates and exports separate 1-D directional data lookup arrays for the heating and cooling tracks.
* **Sec4_Step_2_FinalShape.slx**: Feedforward architecture integrating the extracted lookup tables alongside a dynamic path-direction switch block.
* **Sec4_Step_3_SMABehaviourWithFFTables.m**: Verification script confirming that calculation delays and tracking errors are completely eliminated across the trajectory.

---

## ⚠️ Technical Specifications & Model Boundary Conditions

* **Solver Configuration Requirements**: If running independent sub-blocks, the model parameters (`Ctrl + E`) require a **Fixed-Step Solver** set to **ode4 (Runge-Kutta)** with an explicit fixed step size of `0.0001` seconds to maintain numerical integration stability.
* **Vulnerabilities & Boundaries**: Temperature is driven directly as an ideal input signal, neglecting the real-world physical lag caused by hardware voltage limits and convective cooling rates. The FORC map is also constrained to a single constant mechanical load baseline.
* *Note: These physical hardware limitations and mechanical load variations are actively addressed in my subsequent development repositories.*

## 📄 Technical Documentation
For the comprehensive mathematical derivations, thermodynamic state equations, and detailed experimental analysis supporting this project, please refer to my attached technical report: **`Shape memory alloy.pdf`**.
