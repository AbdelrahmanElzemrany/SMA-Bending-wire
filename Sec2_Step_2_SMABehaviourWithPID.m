% Clear previous figures
figure('Color', [1 1 1]);

% 1. Use the master simulation time vector
t = out.tout;

% 2. AUTOMATICALLY UNPACK STRUCT (Bypasses all field names completely)
% This converts the structure fields to a cell array and grabs the raw numbers
temp_cell = struct2cell(out.ref_signal);
d_ref = temp_cell{1};

% If it unpacked a timeseries object inside the cell, extract its data
if isa(d_ref, 'timeseries')
    d_ref = d_ref.Data;
end

% 3. Extract your standalone timeseries data vectors
d_act = out.actual_curvature.Data;
d_pi  = out.pi_output.Data;

% --- FORCE COLUMN ALIGNMENT ---
t     = t(:);
d_ref = d_ref(:);
d_act = d_act(:);
d_pi  = d_pi(:);


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

% Bottom Plot: PI Controller Effort (The Confusion)
subplot(2,1,2);
plot(t, d_pi, 'g-', 'LineWidth', 2);
grid on;
xlabel('Time (seconds)');
ylabel('Commanded Temperature (T)');
title('PI Controller Output (The Internal "Confusion")');
legend('Control Effort (T)', 'Location', 'best');
set(gca, 'FontSize', 11);