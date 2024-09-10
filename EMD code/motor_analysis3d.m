% Parameters
N_slots = 36;           % Number of slots
N_turns = 50;           % Turns per slot
l_core = 0.15;          % Core length in meters
g = 0.002;              % Air gap length in meters
r_rotor = 0.1;          % Rotor radius in meters
mu = 4 * pi * 10^-7;    % Magnetic permeability (H/m)
I = 5;                  % Current per turn (A)
P = 4;                  % Number of poles
n = 1500;               % Speed in RPM

% Simulation time parameters
t_end = 1;              % Simulation end time in seconds
dt = 0.01;              % Time step
time = 0:dt:t_end;      % Time vector

% Derived parameters
omega = 2 * pi * n / 60;         % Angular speed in rad/s
N_total_turns = N_slots * N_turns;  % Total number of turns
L_arm = 2 * pi * r_rotor;        % Armature length (circumference)

% Define the spatial grid
theta = linspace(0, 2*pi, 100);   % Angular position around rotor (0 to 2pi)
[Theta, T] = meshgrid(theta, time);

% Initialize arrays to store results
B = zeros(size(T));        % Magnetic flux density
E_induced = zeros(size(T)); % Induced EMF
Torque = zeros(size(T));    % Torque

% Simulate and calculate at each time step and position
for i = 1:length(time)
    for j = 1:length(theta)
        % Calculate magnetic flux density (simplified sinusoidal model)
        B(i,j) = (mu * N_total_turns * I) / (2 * pi * r_rotor) * cos(Theta(i,j));
        
        % Induced EMF (Faraday's Law)
        E_induced(i,j) = N_total_turns * B(i,j) * L_arm * omega;
        
        % Torque (Simplified model)
        Torque(i,j) = (P / (2 * pi * n)) * E_induced(i,j) * I;
    end
end

% 3D Visualization of Magnetic Flux Density
figure;
surf(Theta, T, B, 'EdgeColor', 'none');
colorbar;
title('3D View of Magnetic Flux Density');
xlabel('Rotor Position (radians)');
ylabel('Time (s)');
zlabel('Flux Density (T)');
shading interp;
view(3);
grid on;

% 3D Visualization of Induced EMF
figure;
surf(Theta, T, E_induced, 'EdgeColor', 'none');
colorbar;
title('3D View of Induced EMF');
xlabel('Rotor Position (radians)');
ylabel('Time (s)');
zlabel('Induced EMF (V)');
shading interp;
view(3);
grid on;

% 3D Visualization of Torque
figure;
surf(Theta, T, Torque, 'EdgeColor', 'none');
colorbar;
title('3D View of Torque');
xlabel('Rotor Position (radians)');
ylabel('Time (s)');
zlabel('Torque (Nm)');
shading interp;
view(3);
grid on;

% Optional: Enhance aesthetics with lighting
camlight;
lighting phong;