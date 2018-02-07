%close all
clear all

%% Constants
R = 1e3;
C = 1e-6;

t_start = 0;			% Start time
t_stop = 20*R*C;	        % Desired stop time

h = 5*R*C/100;			% Time step

% Desired time instants: enforced time step!
t = linspace(t_start, ...
	     t_start + floor((t_stop - t_start)/h)*h, ...
	     (t_stop - t_start)/h+1);

y = zeros(1,length(t));

%% ODE to solve
ydot = @(y, u, t)((-y/(R*C) + u(t)/(R*C)));

%% Input function
vin = @(p, t) (mod(t./p,2) > 1) .* 1;

%% Euler method
for i = 2:length(t)
  y(i) = y(i-1) + h*(ydot(y(i-1), @(t)(vin(3*R*C,t)), t(i)));
end
