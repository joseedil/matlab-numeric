close all
clear all

%% Constants
R = 1e3;
C = 1e-6;

t_start = 0;			% Start time
t_stop = 20*R*C;	% Desired stop time

vout0 = 0;        % Initial value

h = 5*R*C/13;			% Time step
href = 5*R*C/1000;			% Reference Time Step

% Desired time instants: enforced time step!
t = linspace(t_start, ...
	     t_start + floor((t_stop - t_start)/h)*h, ...
	     (t_stop - t_start)/h+1);

tref = linspace(t_start, ...
		t_start + floor((t_stop - t_start)/href)*href, ...
		(t_stop - t_start)/href+1);


%% Input function
vin = @(p, t) (mod(t./p,2) > 1) .* 1;

%% ODE to solve
ydot = @(y, t)((-y/(R*C) + vin(3*R*C, t)/(R*C)));

%% Output
y_euler = euler1(ydot, tref, vout0);
y_rk2 = rk21(ydot, t, vout0);
y_rk3 = rk31(ydot, t, vout0);
y_rk4 = rk41(ydot, t, vout0);

%% Plot
plot(tref, y_euler);
hold on;
plot(t, y_rk2, '-o', ...
     t, y_rk3, '-o', ...
     t, y_rk4, '-o');
legend('Euler', 'RK2', 'RK3', 'RK4');
