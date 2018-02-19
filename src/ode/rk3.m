%% Runge-Kutta 3rd-order method
function y = rk3(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = h * ydot(y(i),...
		  t(i));

    k2 = h * ydot(y(i) + k1/2, ...
		  t(i) + h/2);

    k3 = h * ydot(y(i) + 3/4*k2, ...
		  t(i) + 3/4*h);

    y(i+1) = y(i) + (2/9*k1 + 1/3*k2 + 4/9*k3);
  end

end %function
