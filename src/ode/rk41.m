function y = rk41(ydot, t0, yinitial)
%RK41  Unidimensional fourth order Runge-Kutta method for integrating ODEs.
%   [Y] = RK41(YDOT,T,YINITIAL) integrates the differential equation
%   y' = ydot(y,t) at the time instants specified by vector T with initial
%   condition YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t0);
  y = [yinitial, zeros(1,n-1)];		% Pre-allocate output vector

  for i = 1:n-1
    h = t0(i+1) - t0(i);

    k1 = h * ydot(y(i), t0(i));
    k2 = h * ydot(y(i) + k1/2, t0(i) + h/2);
    k3 = h * ydot(y(i) + k2/2, t0(i) + h/2);
    k4 = h * ydot(y(i) + k3, t0(i+1));

    y(i+1) = y(i) + 1/6*(k1 + 2*k2 + 2*k3 + k4);
  end

end %function
