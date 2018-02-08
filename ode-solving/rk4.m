%% Runge-Kutta 4th-order method
function y = rk4(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 2:n
    h = t(i) - t(i-1);

    k1 = h * ydot(y(i-1),...
		  t(i-1));

    k2 = h * ydot(y(i-1) + k1/2, ...
		  t(i-1) + h/2);

    k3 = h * ydot(y(i-1) + k2/2, ...
		  t(i-1) + h/2);

    k4 = h * ydot(y(i-1) + k3, ...
		  t(i));

    y(i) = y(i-1) + 1/6*(k1 + 2*k2 + 2*k3 + k4);
  end

end %function
