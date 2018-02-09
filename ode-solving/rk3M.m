%% Runge-Kutta 3rd-order method
function Y = rk3M(Ydot, t, m)
  n = length(t);
  Y = zeros(m,n);		% Pre-allocated output vector

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
