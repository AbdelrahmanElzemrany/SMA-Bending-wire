1.To observe the hysteresis of the shape memory alloy and test it you should run the HysteresisLoopGenerating.slx first then you run the MATLAB file named hysteresisloop.m or in SIMULINK by x_y graph you can plot it by connecting the input temperature of the model to first port and the output curvature to the second port but it will take longer time than exporting the data to MATLAB to plot the hysteresis.

2. For the PID controller step if you want faster response you can change or tune the PID controller but make sure that's negative gain PID controller cause of the nature of the system more heat means less curvature .

3.The last step of the project is containing three steps a. FORC generating to capture the wire physics you should open FORCMODEL.slx(don't run it in Simulink) and run generate_forc.m  b. Making 2 lookup tables associated with heating and cooling curves of the system respectively 
by running tablesextractingscript.m .


WARNINGS
1.If you are to take the main block(pure_bending_sma_wire) to make your own experiment on it make sure to adjust your solver to be fixed_step solver and maximum step size assign it to .0001(ctrl+E and change the default variable step size solver to ode 4 and remember to change the size of fixed step).
 
2.The wire is modeled by Lagoudas procedure then applying a bending load on the tip of it you can easily animate it you can also change the critical temperatures and Young's modulus of each phase and other parameters in the main block(make sure that Mf<Ms<As<Af and Ea >Em) but take care if you change the temperature you should the range of any plot drawing file for example the temperature by default in the model is Ms =275 K Mf = 256 K As =280 K Af 300 K  the forc generating file is running   in range 255 and 320 make sure you change the range in the file as you are changing the critical temperatures ,you can also change the bending load but don't be surprised because the system running in stress -dependent critical temperature the critical temperature would change a bit due to the change of the stress . 

3.The goal of my model is to validate a faster way than PID controller to act to track a desired trajectory 

4. If you have time you can also read the PDF associated with my modeling project and my experiment 





