function Y = euler(Ydot, Yinitial, t, m)
%EULER  First order Runge-Kutta method for integrating ODEs.
%   [Y] = EULER(YDOT,YINITIAL,T,M) integrates the system of M differential 
%   equations y' = ydot(y,t) at the time instants specified by vector T 
%   with initial conditions YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t);
  Y = [Yinitial, zeros(m ,n-1)];		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);
    Y(:,i+1) = Y(:,i) + h*(Ydot(Y(:,i), t(i))) ;
  end

end %function
