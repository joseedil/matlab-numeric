function [Y, t] = rk45_fstep(Ydot, Yinitial, t0, t1, m, eps)
%RK45_FSTEP Summary of this function goes here
%   Detailed explanation goes here

TINY = 1.0e-30;
MAXSTEP = 10000;

% Preallocation
Y = zeros(1,m);

% Try to go straight to desired stepsize
h = (t1 - t0)/2;

for nstep = 1:MAXSTEP
  
  % Resize stepsize if it is too large to finish.
  if t0+h > t1
    h = t1-t0;
  end
  
  % Error scaling factors.
  dydt = Ydot(Yinitial, t0);
  Yscale = abs(Yinitial) + abs(dydt.*h) + TINY;
  
  % Step solution.
  [Y, t, hdid, hnext] = rk45_qstep(Ydot, Yinitial, t0, h, m, eps, Yscale);
  t
  
    % Are we done? Then, exit.
  if (t-t1)*(t1-t0) >= 0
    break;
  end
    
  % We are not done: update state and loop.
  Yinitial = Y;
  t0 = t;
  h = hnext;
   
end %for

end %function
