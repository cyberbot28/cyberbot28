% Parameters to vary
N_slots_range = linspace(30, 60, 50);  % Number of slots (varying range)
r_rotor_range = linspace(0.08, 0.12, 50);  % Rotor radius (varying range)

% Fixed parameters
N_turns = 50;           % Turns per slot
l_core = 0.15;          % Core length in meters
g = 0.002;              % Air gap length in meters
mu = 4 * pi * 10^-7;    % Magnetic permeability (H/m)
I = 5;                  % Current per turn (A)
P = 4;                  % Number of poles
n = 1500;               % Speed in RPM

% Simulation time parameters
t_end = 0.1;            % Simulation end time in seconds (for optimization, reduce time)
dt = 0.01;              % Time step
time = 0:dt:t_end;      % Time vector

% Derived parameters
omega = 2 * pi * n / 60;         % Angular speed in rad/s
L_arm = 2 * pi * r_rotor_range;  % Armature length (circumference)

% Initialize arrays to store results
[B_max, E_max, T_max] = deal(zeros(length(N_slots_range), length(r_rotor_range)));

% Optimization loop
for i = 1:length(N_slots_range)
    for j = 1:length(r_rotor_range)
        N_slots = N_slots_range(i);
        r_rotor = r_rotor_range(j);
        N_total_turns = N_slots * N_turns;

        % Temporary arrays for current parameters
        B_temp = zeros(size(time));
        E_temp = zeros(size(time));
        T_temp = zeros(size(time));

        for t = 1:length(time)
            theta = omega * time(t);

            % Calculate magnetic flux density (simplified sinusoidal model)
            B_temp(t) = (mu * N_total_turns * I) / (2 * pi * r_rotor) * cos(theta);
            
            % Induced EMF (Faraday's Law)
            E_temp(t) = N_total_turns * B_temp(t) * L_arm(j) * omega;
            
            % Torque (Simplified model)
            T_temp(t) = (P / (2 * pi * n)) * E_temp(t) * I;
        end

        % Store maximum values for this parameter set
        B_max(i,j) = max(B_temp);
        E_max(i,j) = max(E_temp);
        T_max(i,j) = max(T_temp);
    end
end

% 3D Visualization of Maximum Flux Density
figure;
surf(N_slots_range, r_rotor_range, B_max');
colorbar;
title('Optimization of Flux Density');
xlabel('Number of Slots');
ylabel('Rotor Radius (m)');
zlabel('Max Flux Density (T)');
shading interp;
view(3);
grid on;

% 3D Visualization of Maximum Induced EMF
figure;
surf(N_slots_range, r_rotor_range, E_max');
colorbar;
title('Optimization of Induced EMF');
xlabel('Number of Slots');
ylabel('Rotor Radius (m)');
zlabel('Max Induced EMF (V)');
shading interp;
view(3);
grid on;

% 3D Visualization of Maximum Torque
figure;
surf(N_slots_range, r_rotor_range, T_max');
colorbar;
title('Optimization of Torque');
xlabel('Number of Slots');
ylabel('Rotor Radius (m)');
zlabel('Max Torque (Nm)');
shading interp;
view(3);
grid on;

% Optional: Enhance aesthetics with lighting
camlight;
lighting phong;