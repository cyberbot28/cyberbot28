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

% Derived parameters
omega = 2 * pi * n / 60;         % Angular speed in rad/s
N_total_turns = N_slots * N_turns;  % Total number of turns

% Define the spatial grid
theta = linspace(0, 2*pi, 100);   % Angular position around rotor (0 to 2pi)
z = linspace(-l_core/2, l_core/2, 100);  % Position along the core length

% Create a mesh grid
[Theta, Z] = meshgrid(theta, z);

% Calculate the magnetic flux density B
B = (mu * N_total_turns * I) / (2 * pi * r_rotor) * cos(Theta);

% Convert to Cartesian coordinates for 3D plotting
X = r_rotor * cos(Theta);
Y = r_rotor * sin(Theta);

% 3D Visualization
figure;
surf(X, Y, Z, B, 'EdgeColor', 'none');
colorbar;
title('3D View of Magnetic Flux Density in the Air Gap');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
shading interp;
view(3);
grid on;

% Optional: Improve aesthetics with lighting
camlight;
lighting phong;