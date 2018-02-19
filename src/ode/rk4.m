%% Runge-Kutta 4th-order method
function y = rk4(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = h * ydot(y(i),...
		  t(i));

    k2 = h * ydot(y(i) + k1/2, ...
		  t(i) + h/2);

    k3 = h * ydot(y(i) + k2/2, ...
		  t(i) + h/2);

    k4 = h * ydot(y(i) + k3, ...
		  t(i+1));

    y(i+1) = y(i) + 1/6*(k1 + 2*k2 + 2*k3 + k4);
  end

end %function
