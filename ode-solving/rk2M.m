%% Runge-Kutta 2nd-order method
function Y = rk2M(Ydot, t, m)
  n = length(t);
  Y = zeros(m,n);		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);

    k1 = Ydot(Y(:,i), t(i));
    k2 = Ydot(Y(:,i) + h*Ydot(Y(:,i), t(i)), t(i+1));

    Y(:,i+1) = Y(:,i) + h/2*(k1+k2);
  end

end %function
