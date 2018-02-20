function Y = rk2(Ydot, Yinitial, t, m)
%RK2  Second order Runge-Kutta method for integrating ODEs.
%   [Y] = RK2(YDOT,YINITIAL,T,M) integrates the system of M differential 
%   equations y' = ydot(y,t) at the time instants specified by vector T 
%   with initial conditions YINITIAL at time T(1).
%
%   This is a single step, fixed time step solver for didatic purposes 
%   only.

  n = length(t);
  Y = [Yinitial, zeros(m,n-1)];		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = Ydot(Y(:,i), t(i));
    k2 = Ydot(Y(:,i) + h*Ydot(Y(:,i), t(i)), t(i+1));

    Y(:,i+1) = Y(:,i) + h/2*(k1+k2);
  end

end %function
