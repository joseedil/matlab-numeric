function Y = rk4(Ydot, Yinitial, t, m)
%RK4  Fourth order Runge-Kutta method for integrating ODEs.
%   [Y] = RK4(YDOT,YINITIAL,T,M) integrates the system of M differential 
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

    k3 = h * Ydot(Y(:,i) + k2/2, ...
		  t(i) + h/2);

    k4 = h * Ydot(Y(:,i) + k3, ...
		  t(i));

    Y(:,i+1) = Y(:,i) + 1/6*(k1 + 2*k2 + 2*k3 + k4);
  end

end %function
