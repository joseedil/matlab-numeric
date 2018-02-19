function y = rk21(ydot, t, yinitial)
%RK21  Unidimensional second order Runge-Kutta method for integrating ODEs.
%   [Y] = RK21(YDOT,T,YINITIAL) integrates the differential equation
%   y' = ydot(y,t) at the time instants specified by vector T with initial
%   condition YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t);
  y = [yinitial, zeros(1,n-1)];		% Pre-allocate output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = ydot(y(i), t(i));
    k2 = ydot(y(i) + h*ydot(y(i), t(i)), t(i+1));

    y(i+1) = y(i) + h/2*(k1+k2);
  end

end %function
