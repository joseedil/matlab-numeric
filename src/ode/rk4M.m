%% Runge-Kutta 4th-order method
function Y = rk4M(Ydot, t, m)
  n = length(t);
  Y = zeros(m,n);		% Pre-allocated output vector

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
