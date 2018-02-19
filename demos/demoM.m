close all
clear all

%% Constants
R1 = 1e3;
C1 = 1e-6;
R2 = 1e3;
C2 = 1e-6;

t_start = 0;			% Start time
t_stop = 20*R1*C1;	        % Desired stop time

h = 5*R1*C1/20;			% Time step
href = 5*R1*C1/1000;			% Reference Time Step

% Desired time instants: enforced time step!
t = linspace(t_start, ...
	     t_start + floor((t_stop - t_start)/h)*h, ...
	     (t_stop - t_start)/h+1);

tref = linspace(t_start, ...
		t_start + floor((t_stop - t_start)/href)*href, ...
		(t_stop - t_start)/href+1);


%% Input function
vin = @(p, t) (mod(t./p,2) > 1) .* 1;
per = 3*R1*C1;


H = [1/(R1*C1) 0]';

G = [-1/(R1*C1)-1/(R2*C1),   1/(R2*C1); ...
     1/(R2*C2),              -1/(R2*C2)];

%% ODE to solve
ydot = @(Y, t)(G*Y + H.*vin(per, t));

%% Output
y_euler = eulerM(ydot, t, length(G));
y_rk2 = rk2M(ydot, t, length(G));
y_rk3 = rk3M(ydot, t, length(G));
y_rk4 = rk4M(ydot, t, length(G));

%% Plot
plot(t, y_euler, t, y_rk2, t, y_rk3, t, y_rk4);
%hold on;
%plot(t, y_rk2);
