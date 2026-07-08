[Click here to view the 4-minute video explaining the whole process.](https://drive.google.com/file/d/1Rn8Hdbc34DBBd66nuptR8OTe7HorPT5Z/view?usp=sharing)
# SMA Bending Wire Control System Analysis (MATLAB & Simulink)

This repository contains the complete engineering framework for modeling, simulating, and implementing trajectory tracking control for a Shape Memory Alloy (SMA) bending wire actuator based on Lagoudas thermodynamics. The objective of this project was to analyze the tracking limitations of standard linear feedback controllers under material hysteresis and successfully validate a custom path-dependent feedforward architecture.

## 📝 Project Overview

Shape Memory Alloys (SMAs) provide high power-to-weight ratios for actuation but exhibit severe **material hysteresis** during thermal phase transitions. As the material transitions between its cold martensite and hot austenite phases, the temperature-to-curvature relationship becomes highly non-linear, multi-valued, and path-dependent. 

Because of this hysteresis loop, a single target curvature value corresponds to completely different temperatures depending on whether the wire is currently heating or cooling. Standard linear feedback loops (like conventional PI controllers) are fundamentally unequipped to handle this behavior. They experience massive calculation lag, track sluggishly, and cannot settle accurately because they treat the system as a single-valued, linear plant.

This project resolves this issue by developing a **path-dependent feedforward controller**. By mapping the exact boundaries of the material's structural hysteresis using First-Order Reversal Curves (FORC), the architecture instantly predicts and switches between dedicated heating and cooling trajectory tables on the fly, completely eliminating tracking errors.
<img width="1161" height="685" alt="image" src="https://github.com/user-attachments/assets/9b9abe60-8864-4e6c-ba8a-17c27d4baec4" />

<img width="937" height="620" alt="image" src="https://github.com/user-attachments/assets/cf7520a5-59f4-4f4c-ac68-dc4183ba4a1c" />


<img width="1017" height="602" alt="image" src="https://github.com/user-attachments/assets/8cc450d2-3f14-4b4e-ab9a-628f7459f629" />



## 🛠️ Pipeline & File Architecture

The repository is structured sequentially to take the system from raw material characterization to a verified path-dependent feedforward tracking controller:

### 1. Characterizing Material Hysteresis
* **`Sec1_Step_1_Hysteresis_in_SMAs.slx`**: Simulink block diagram modeling the baseline thermomechanical behavior of the SMA wire actuator under a constant mechanical load.
* **`Sec1_Step_2_HysteresisPlot.m`**: MATLAB execution script that runs the baseline simulation and plots the resulting multi-valued heating and cooling hysteresis paths.

### 2. Evaluating the Baseline PI Controller
* **`Sec2_Step_1_PIDControl.slx`**: Closed-loop tracking architecture implementing an inverted negative-gain PI loop to fight the underlying material physics.
* **`Sec2_Step_2_SMABehaviourWithPID.m`**: Post-processing tracking evaluation script displaying the dual-axis response plots to expose pure mathematical calculation lag.

### 3. Executing the FORC Data Collection Framework
* **`Sec3_Step_1_FORC_Experiment.slx`**: Specialized experimental simulation subsystem utilized to sweep individual thermal reversal loops through the hysteresis bounds.
* **`Sec3_Step_2_FORC_Initialization.m`**: Automation script orchestrating 50 sequential trial runs to systematically gather high-resolution raw trajectory matrix paths.

### 4. Validating the Path-Dependent Feedforward Architecture
* **`Sec4_Step_1_tablesextractingscript.m`**: Matrix processing tool that isolates and exports separate 1-D directional data lookup arrays for the heating and cooling tracks.
* **`Sec4_Step_2_FinalShape.slx`**: Feedforward architecture integrating the extracted lookup tables alongside a dynamic path-direction switch block.
* **`Sec4_Step_3_SMABehaviourWithFFTables.m`**: Verification script confirming that calculation delays and tracking errors are completely eliminated across the trajectory.

---

## ⚠️ Technical Specifications & Model Boundary Conditions

* **Solver Configuration Requirements**: If running independent sub-blocks, the model parameters (`Ctrl + E`) require a **Fixed-Step Solver** set to **ode4 (Runge-Kutta)** with an explicit fixed step size of `0.0001` seconds to maintain numerical integration stability.
* **Vulnerabilities & Boundaries**: Temperature is driven directly as an ideal input signal, neglecting the real-world physical lag caused by hardware voltage limits and convective cooling rates. The FORC map is also constrained to a single constant mechanical load baseline.
* *Note: These physical hardware limitations and mechanical load variations are actively addressed in my subsequent development repositories.*

## 📄 Technical Documentation
For the comprehensive mathematical derivations, thermodynamic state equations, and detailed experimental analysis supporting this project, please refer to my attached technical report: **`Shape memory alloy.pdf`**.
