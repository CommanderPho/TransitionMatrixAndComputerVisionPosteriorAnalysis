% Define the object's mass
mass = 1; % kg (example value)

% Define the time vector
t_total = linspace(0, 10, 1000); % Fine time vector for plotting
t_points = linspace(0, 10, 10); % Coarse time points for the trajectory
x_points = sin(t_points); % Initial trajectory values at coarse points

% Expand the trajectory to the fine time vector, creating a step function
x = interp1(t_points, x_points, t_total, 'previous');

% Create a figure for the interactive plot
fig = figure;

% Plot the initial trajectory
subplot(4, 1, 1);
h = plot(t_total, x, 'b', 'DisplayName', 'Trajectory (x)');
hold on;
scatter(t_points, x_points, 'r', 'filled', 'HandleVisibility', 'off'); % Add scatter points for interactivity
xlabel('Time (s)');
ylabel('Position');
title('Adjustable 1D Trajectory');
legend;
grid on;

% Enable dragging on the scatter points
global dcm;
dcm = datacursormode(fig);
set(dcm, 'DisplayStyle', 'datatip', 'SnapToDataVertex', 'off', 'Enable', 'on');

% Add a button to update the derivatives plot
btn = uicontrol('Style', 'pushbutton', 'String', 'Update Derivatives', ...
                'Position', [20 20 150 30], ...
                'Callback', @updateDerivatives);

% Update derivatives and plot them
% function updateDerivatives(~, ~)
%     % Declare dcm as global to access it
%     global dcm;
%     % Get the modified trajectory data
%     cursor_info = getCursorInfo(dcm);
%     for k = 1:length(cursor_info)
%         idx = find(t_points == cursor_info(k).Position(1));
%         x_points(idx) = cursor_info(k).Position(2);
%     end
    
% Expand the modified trajectory to the fine time vector
x = interp1(t_points, x_points, t_total, 'previous');
set(h, 'YData', x);

% Calculate the first-order derivative (velocity)
v = diff(x)./diff(t_total);
t_v = t_total(1:end-1); % Time vector for the velocity

% Calculate the second-order derivative (acceleration)
a = diff(v)./diff(t_v);
t_a = t_v(1:end-1); % Time vector for the acceleration

% Calculate the force required to change direction
F = mass * a;

% Calculate the energy expended (work done)
dx = diff(x);
W = sum(F .* dx(1:end-1)); % Summing the work done at each interval

% Display the total energy expended
disp(['Total Energy Expended: ', num2str(W), ' Joules']);


% Create a new figure for the subplots
figure;

% Plot the trajectory
subplot(4, 1, 1);
plot(t_total, x, 'b', 'DisplayName', 'Trajectory (x)');
xlabel('Time (s)');
ylabel('Position');
title('1D Trajectory');
legend;
grid on;

% Plot the first-order derivative (velocity)
subplot(4, 1, 2);
plot(t_v, v, 'r', 'DisplayName', 'First-order derivative (v)');
xlabel('Time (s)');
ylabel('Velocity');
title('First-order Derivative (Velocity)');
legend;
grid on;

% Plot the second-order derivative (acceleration)
subplot(4, 1, 3);
plot(t_a, a, 'g', 'DisplayName', 'Second-order derivative (a)');
xlabel('Time (s)');
ylabel('Acceleration');
title('Second-order Derivative (Acceleration)');
legend;
grid on;

% Plot the force required to change direction
subplot(4, 1, 4);
plot(t_a, F, 'm', 'DisplayName', 'Force (F)');
xlabel('Time (s)');
ylabel('Force (N)');
title('Force Required to Change Direction');
legend;
grid on;
% end
