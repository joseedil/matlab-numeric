function Y = rk3(Ydot, Yinitial, t, m)
%RK3  Third order Runge-Kutta method for integrating ODEs.
%   [Y] = RK3(YDOT,YINITIAL,T,M) integrates the system of M differential 
%   equations y' = ydot(y,t) at the time instants specified by vector T 
%   with initial conditions YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t);
  Y = [Yinitial, zeros(m,n-1)];		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = h * Ydot(Y(:,i),...
		  t(i));

    k2 = h * Ydot(Y(:,i) + k1/2, ...
		  t(i) + h/2);

    k3 = h * Ydot(Y(:,i) + 3/4*k2, ...
		  t(i) + 3/4*h);

    Y(:,i+1) = Y(:,i) + (2/9*k1 + 1/3*k2 + 4/9*k3);
  end

end %function
