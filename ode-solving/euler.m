%% Euler method
function y = euler(ydot, t)
  n = length(t);
  y = zeros(1,n);		% Pre-allocated output vector

  for i = 2:n
    h = t(i) - t(i-1);
    y(i) = y(i-1) + h*(ydot(y(i-1), t(i-1))) ;
  end

end %function
