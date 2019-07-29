## Copyright 2019 José E. G. de Medeiros
##
## Permission is hereby granted, free of charge, to any person
## obtaining a copy of this softwareand associated documentation files
## (the "Software"), to deal in the Software without restriction,
## including without limitation the rights to use, copy, modify,
## merge, publish, distribute, sublicense, and/or sell copies of the
## Software, and to permit persons to whom the Software is furnished
## to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be
## included in all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
## EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
## MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
## IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
## CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
## TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
## IN THE SOFTWARE.

## Compares different implementation time
clear all
close all
warning("off");

verbose = true;

## Methods to evaluate
eval_lagrange = false;
eval_neville1rec = false;	# Very slow, don't go over nf=18...
eval_neville1recmemo = true;
eval_neville1iter = true;
eval_neville2iter = true;

## Function to be interpolated.
f = @(x) sin(x + 0.25*x.^2);

## Sample function. Those will be the support points.
ti = 0;
tf = 5.5;

## Sample points
S = 100;
t = linspace(ti, tf, S);

ni=10;
nf=60;
inc = 10;

N = ni:inc:nf;

for i = 1:length(N)

  x = linspace(ti, tf, N(i));
  y = f(x);
  k = 0;

  if(verbose)
    disp("");
    disp("Polynomials of order: "); disp(N(i));
  endif

  if(eval_lagrange);
    k = k+1;
    if(verbose); disp("Lagrange..."); endif;
    tic; polyval(lagrange(x,y), t); time(k,i) = toc;
    clear -functions;
    if(verbose); disp("Done!"); endif;
  endif

  if(eval_neville1rec)
    k = k+1;
    if(verbose); disp("Recursive Neville..."); endif;
    tic; neville1rec(t,x,y); time(k,i) = toc;
    clear -functions;
    if(verbose); disp("Done!"); endif;
  endif

  if(eval_neville1recmemo)
    k = k+1;
    if(verbose); disp("Memoized recursive Neville..."); endif;
    tic; neville1recmemo(t,x,y); time(k,i) = toc;
    clear -functions;
    if(verbose); disp("Done!"); endif;
  endif

  if(eval_neville1iter)
    k = k+1;
    if(verbose); disp("Iterative Neville..."); endif;
    tic; neville1iter(t,x,y); time(k,i) = toc;
    clear -functions;
    if(verbose); disp("Done!"); endif;
  endif

  if(eval_neville2iter)
    k = k+1;
    if(verbose); disp("Modified Iterative Neville..."); endif;
    tic; neville2iter(t,x,y); time(k,i) = toc;
    clear -functions;
    if(verbose); disp("Done!"); endif;
  endif

endfor

## Figure 1: interpolatiing polynomial
figure(1);
hold on;

k = 0;
if(eval_lagrange);
  k = k+1;
  plot(N, time(k,:), 'DisplayName', 'Lagrange', '-o');
endif

if(eval_neville1rec)
  k = k+1;
  plot(N, time(k,:), 'DisplayName', 'Recursive Neville', '-+');
endif

if(eval_neville1recmemo)
  k = k+1;
  plot(N, time(k,:), 'DisplayName', 'Memoized rec. Neville', '-*');
endif

if(eval_neville1iter)
  k = k+1;
  plot(N, time(k,:), 'DisplayName', 'Iterative Neville', '-x');
endif

if(eval_neville2iter)
  k = k+1;
  plot(N, time(k,:), 'DisplayName', 'Mod. Iter. Neville', '-s');
endif

legend("location", "northwest");
legend show;
xlabel("# of support points");
ylabel("Time [s]");

grid on;

## subplot(2,1,2);
## hold on;
## plot(t, in - out);
## plot(x, f(x) - y, 'ok');
## grid on;
## title("Absolute error");
## #legend("Error", "Support points", "location", "northeastoutside");

warning("on");
