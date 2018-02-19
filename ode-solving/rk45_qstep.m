function [Y, t, hdid, hnext] = rk45_qstep(Ydot, Yinitial, t, htry, m, eps, Yscale)
%RK45_QSTEP Summary of this function goes here
%   Detailed explanation goes here

SAFETY = 0.9;
PGROW = -0.2;
PSHRINK = -0.25;
ERRCON = 1.89e-4;

Ytemp = zeros(1,m);

h = htry;

while true
  % Take a step
  [Ytemp, Yerr] = rk45_step(Ydot, Yinitial, t, h, m);
  
  % Compute maximum error.
  errmax = max(Yerr ./ Yscale) / eps;
  
  % Step succeeded: exit loop if errmax is within acceptable range.
  if errmax <= 1.0; break; end
  
  % Step not succeed: compute next step size.
  htemp = SAFETY * h * errmax ^ PSHRINK;
  
  if h >= 0.0
    h = max(htemp, 0.1*h);
  else
    h = min(htemp, 0.1*h);
  end
  
  if t + h == t 
    error ('stepsize underflow in rk45_qstep');
  end
  
end %while

% Compute next step size
if errmax > ERRCON
  hnext = SAFETY * h * errmax ^ PGROW;
else
  hnext = 5*h;
end

hdid = h;
t = t + hdid;
Y = Ytemp;

end

