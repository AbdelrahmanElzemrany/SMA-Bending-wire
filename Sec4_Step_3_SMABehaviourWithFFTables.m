% Clear previous figures
figure('Color', [1 1 1]);

% 1. Use the master simulation time vector
t = out.tout;

% 2. SAFE UNPACKING (Handles Dataset, Timeseries, Struct, or Array)
ref_obj = out.ref_signal;

if isa(ref_obj, 'Simulink.SimulationData.Dataset')
    % If it is a modern Simulink Dataset format
    d_ref = ref_obj.get(1).Values.Data; 
elseif isa(ref_obj, 'struct')
    % If it actually is a structure
    temp_cell = struct2cell(ref_obj);
    d_ref = temp_cell{1};
    if isa(d_ref, 'timeseries'), d_ref = d_ref.Data; end
elseif isa(ref_obj, 'timeseries')
    % If it is a direct timeseries object
    d_ref = ref_obj.Data;
else
    % Fallback if it is already a raw data matrix/array
    d_ref = ref_obj;
end

% 3. Extract your standalone timeseries data vectors
d_act = out.actual_curvature.Data;
d_FFtables  = out.FFtables_output.Data;

% --- FORCE COLUMN ALIGNMENT ---
t          = t(:);
d_ref      = d_ref(:);
d_act      = d_act(:);
d_FFtables = d_FFtables(:);


% --- PLOTTING SECTION ---

% Top Plot: Target vs Actual Curvature
subplot(2,1,1);
plot(t, d_ref, 'r--', 'LineWidth', 2); hold on;
plot(t, d_act, 'b-', 'LineWidth', 2);
grid on;
ylabel('Curvature (m^{-1})');
title('SMA Shape Tracking Comparison');
legend('Target Curvature', 'Actual SMA Curvature', 'Location', 'best');
set(gca, 'FontSize', 11);


% Bottom Plot: Feedforward Control Command
subplot(2,1,2);
plot(t, d_FFtables, 'g-', 'LineWidth', 2);
grid on;
xlabel('Time (seconds)');
ylabel('Commanded Temperature (T)');
title('The Feedforward Hysteresis Compensation Tables');
legend('Control Effort (T)', 'Location', 'best');
set(gca, 'FontSize', 11);
