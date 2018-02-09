%% Euler method
function Y = eulerM(Ydot, t, m)
  n = length(t);
  Y = zeros(m ,n);		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);
    Y(:,i+1) = Y(:,i) + h*(Ydot(Y(:,i), t(i))) ;
  end

end %function
