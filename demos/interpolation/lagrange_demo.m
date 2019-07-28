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

## Demonstrates interpolation with the Lagrange formula.
clear all
close all

## Function to be interpolated.
f = @(x) sin(x + 0.25*x.^2);

## Sample function. Those will be the support points.
ti = 0;
tf = 5.5;
N = 10;

x = linspace(ti, tf, N);
y = f(x);

## Calculate the Lagrange interpolation polynomial.
[p L] = lagrange(x,y);

## Sample points for ploting
S = 1000;
t = linspace(ti, tf, S);

## Figure 1: interpolatiing polynomial
figure(1);
subplot(2,1,1);
hold on;
plot(t, f(t), t, polyval(p,t));
plot(x,y, 'ok');
axis([ti tf -1.1 1.1]);
grid on;
title("Lagrange interpolation");
legend("Original function", "Interpolating polynomial", "Support points")

subplot(2,1,2);
plot(t, f(t) - polyval(p,t));
grid on;
title("Absolute error");

# Figure 2: interpolation basis
figure(2);
hold on;
plot(t, polyval(p, t), 'r');
plot(x,y, 'ok');
for i = 1: length(L)
  plot(t, polyval(L(i,:), t));
end
grid on;
#plot(t, f(t), 'k');
title("Lagrange polynomial basis");
legend("Interpolating polynomial", "Support points");
