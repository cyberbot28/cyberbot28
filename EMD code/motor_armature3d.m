% Parameters
N_slots = 36;           % Number of slots
r_rotor = 0.1;          % Rotor radius in meters
slot_depth = 0.02;      % Depth of each slot in meters
slot_width = 0.01;      % Width of each slot in meters
l_core = 0.15;          % Core length in meters

% Rotor core (cylinder)
[theta, z] = meshgrid(linspace(0, 2*pi, 100), linspace(-l_core/2, l_core/2, 100));
X_core = r_rotor * cos(theta);
Y_core = r_rotor * sin(theta);
Z_core = z;

% Plot rotor core
figure;
surf(X_core, Y_core, Z_core, 'FaceColor', 'blue', 'EdgeColor', 'none');
hold on;

% Define slot positions
theta_slots = linspace(0, 2*pi, N_slots + 1);  % Angles for slot positions
theta_slots = theta_slots(1:end-1);            % Remove the last point to avoid overlap

% Plot slots
for i = 1:N_slots
    % Slot edges
    X_slot = [(r_rotor-slot_depth) * cos(theta_slots(i)), r_rotor * cos(theta_slots(i))];
    Y_slot = [(r_rotor-slot_depth) * sin(theta_slots(i)), r_rotor * sin(theta_slots(i))];
    
    % Plot the slot as a rectangle extruded along z-axis
    for j = 1:length(z)
        fill3([X_slot(1), X_slot(2), X_slot(2), X_slot(1)], ...
              [Y_slot(1), Y_slot(2), Y_slot(2), Y_slot(1)], ...
              z(j) + [0 0 1 1]*(l_core/length(z)), ...
              'r', 'EdgeColor', 'none');
    end
end

% Enhance the plot
axis equal;
grid on;
title('3D View of DC Machine Armature');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
view(3);

% Optional: Add lighting and shading for better visualization
camlight;
lighting phong;
hold off;