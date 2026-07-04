%% 1. Extract and Clean Data from Locked Object
try
    ts_T = out.get('HYS_T');
    ts_C = out.get('HYS_C');
catch
    ts_T = out.HYS_T;
    ts_C = out.HYS_C;
end

% Interpolate to ensure identical vector lengths
t_start = max(ts_T.Time(1), ts_C.Time(1));
t_end   = min(ts_T.Time(end), ts_C.Time(end));
uniform_time = linspace(t_start, t_end, 3000);

temperature = interp1(ts_T.Time, ts_T.Data, uniform_time, 'linear', 'extrap');
curvature   = interp1(ts_C.Time, ts_C.Data, uniform_time, 'linear', 'extrap');

%% 2. Identify Heating and Cooling Paths
% Calculate the difference between consecutive temperature points
dT = diff(temperature); 

% Add a trailing zero to maintain matching array lengths
dT = [dT, dT(end)]; 

% Separate indices based on temperature direction
heating_idx = dT > 0.0001;   % Temperature is rising
cooling_idx = dT < -0.0001;  % Temperature is falling

%% 3. Create the Color-Coded Hysteresis Plot
figure('Color', 'w', 'Position', [200, 200, 750, 500]);
hold on;

% Plot Heating Path (Red)
if any(heating_idx)
    % Use 'NaN' buffering to prevent disjointed lines from blending incorrectly
    t_heat = temperature; t_heat(~heating_idx) = NaN;
    c_heat = curvature;   c_heat(~heating_idx) = NaN;
    p1 = plot(t_heat, c_heat, 'r-', 'LineWidth', 2.5, 'DisplayName', 'Heating Path (M \rightarrow A)');
end

% Plot Cooling Path (Blue)
if any(cooling_idx)
    t_cool = temperature; t_cool(~cooling_idx) = NaN;
    c_cool = curvature;   c_cool(~cooling_idx) = NaN;
    p2 = plot(t_cool, c_cool, 'b-', 'LineWidth', 2.5, 'DisplayName', 'Cooling Path (A \rightarrow M)');
end

%% 4. Add Directional Arrows
% Find midpoint of heating path to place an arrow
heat_mid = round(find(heating_idx, 1) + sum(heating_idx)/2);
if ~isempty(heat_mid) && heat_mid < length(temperature)
    text(temperature(heat_mid), curvature(heat_mid), ' \rightarrow', ...
        'FontSize', 20, 'Color', 'r', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end

% Find midpoint of cooling path to place an arrow
cool_mid = round(find(cooling_idx, 1) + sum(cooling_idx)/2);
if ~isempty(cool_mid) && cool_mid < length(temperature)
    text(temperature(cool_mid), curvature(cool_mid), ' \leftarrow', ...
        'FontSize', 20, 'Color', 'b', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end

%% 5. Formatting & Display
grid on;
box on;
xlabel('Temperature, T', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Curvature', 'FontSize', 12, 'FontWeight', 'bold');
title('SMA Wire Hysteresis: Heating vs. Cooling Paths', 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 11);
hold off;
