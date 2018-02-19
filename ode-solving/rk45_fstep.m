function [Y, t] = rk45_fstep(Ydot, Yinitial, t0, t1, m, eps)
%RK45_FSTEP Summary of this function goes here
%   Detailed explanation goes here

TINY = 1.0e-30;
MAXSTEP = 1000000;

% Preallocation
Y = zeros(m, MAXSTEP);
t = zeros(1, MAXSTEP);

Y(:,1) = Yinitial;
t(1) = t0;

% Try to go straight to desired stepsize
h = (t1 - t0)/2;

for i = 1:MAXSTEP
  
  % Resize stepsize if it is too large to finish.
  if t0+h > t1
    h = t1-t0;
  end
  
  % Error scaling factors.
  dydt = Ydot(Yinitial, t0);
  Yscale = abs(Yinitial) + abs(dydt.*h) + TINY;
  
  % Step solution.
  [Ytemp, ttemp, hdid, hnext] = rk45_qstep(Ydot, Yinitial, t0, h, m, eps, Yscale);
  
  % Save results.
  Y(:,i+1) = Ytemp;
  t(i+1) = ttemp;
  
    % Are we done? Then, exit.
  if (t-t1)*(t1-t0) >= 0
    break;
  end
    
  % We are not done: update state and loop.
  Yinitial = Ytemp;
  t0 = ttemp;
  h = hnext;
   
end %for

% Deallocate unused memory... 
Y = Y(:,1:i);
t = t(1:i);

end %function
