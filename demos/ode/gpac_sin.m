close all;

%% System definition

% Equations
A = [0,1; -1,0];
ydot = @(y,t)(A*y);

% Initial condition
Y0 = [0; 1];
t0 = 0;

%% Time discretization
t1 = 10*pi;         % Be carefull here, the problem is quite stiff...
n = 100;
t = linspace(t0, t1, n);

%% Solve
YRK4 = rk4(ydot, Y0, t, 2);
YRK45 = rk45_fstep(ydot, Y0, t0, t1, 2, 1e-12);

%% Plot
figure(1)
plot(YRK4(1,:), YRK4(2,:));

figure(2)
plot(YRK45(1,:), YRK45(2,:));