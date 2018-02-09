%% Runge-Kutta 2nd-order method
function y = rk2(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = ydot(y(i), t(i));
    k2 = ydot(y(i) + h*ydot(y(i), t(i)), t(i+1));

    y(i+1) = y(i) + h/2*(k1+k2);
  end

end %function
