%% Runge-Kutta 2nd-order method
function y = rk2(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 2:n
    h = t(i) - t(i-1);

    k1 = ydot(y(i-1), t(i-1));
    k2 = ydot(y(i-1) + h*ydot(y(i-1), t(i-1)), t(i));

    y(i) = y(i-1) + h/2*(k1+k2);
  end

end %function
