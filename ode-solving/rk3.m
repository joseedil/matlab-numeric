%% Runge-Kutta 3rd-order method
function y = rk3(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 2:n
    h = t(i) - t(i-1);

    k1 = h * ydot(y(i-1),...
		  t(i-1));

    k2 = h * ydot(y(i-1) + k1/2, ...
		  t(i-1) + h/2);

    k3 = h * ydot(y(i-1) + 3/4*k2, ...
		  t(i-1) + 3/4*h);

    y(i) = y(i-1) + (2/9*k1 + 1/3*k2 + 4/9*k3);
  end

end %function
