%% Euler method
function y = euler(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 1:n-1
    h = t(i+1) - t(i);
    y(i+1) = y(i) + h*(ydot(y(i), t(i))) ;
  end

end %function
