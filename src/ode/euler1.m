function y = euler1(ydot, t, yinitial)
%EULER1  Unidimensional euler method for integrating ODEs.
%   [Y] = EULER1(YDOT,T,YINITIAL) integrates the differential equation
%   y' = ydot(y,t) at the time instants specified by vector T with initial
%   condition YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t);
  y = [yinitial, zeros(1,n-1)];		% Pre-allocate output vector

  for i = 1:n-1
    h = t(i+1) - t(i);
    y(i+1) = y(i) + h*(ydot(y(i), t(i))) ;
  end

end %function
