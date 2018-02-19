function y = rk31(ydot, t, yinitial)
%RK31  Unidimensional third order Runge-Kutta method for integrating ODEs.
%   [Y] = RK31(YDOT,T,YINITIAL) integrates the differential equation
%   y' = ydot(y,t) at the time instants specified by vector T with initial
%   condition YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t);
  y = [yinitial, zeros(1,n-1)];		% Pre-allocate output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = h * ydot(y(i),...
		  t(i));

    k2 = h * ydot(y(i) + k1/2, ...
		  t(i) + h/2);

    k3 = h * ydot(y(i) + 3/4*k2, ...
		  t(i) + 3/4*h);

    y(i+1) = y(i) + (2/9*k1 + 1/3*k2 + 4/9*k3);
  end

end %function
