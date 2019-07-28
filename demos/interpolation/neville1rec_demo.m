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

## Demonstrates interpolation with Neville's algorithm.
clear all
close all

## Function to be interpolated.
f = @(x) sin(x + 0.25*x.^2);

## Sample function. Those will be the support points.
ti = 0;
tf = 4;
N = 10;

x = linspace(ti, tf, N);
y = f(x);

## Sample points for ploting
S = 1000;
t = linspace(ti, tf, S);

in = f(t);
out = neville1rec(t,x,y);

## Figure 1: interpolatiing polynomial
figure(1);
subplot(2,1,1);
hold on;
plot(t, in, t, out);
plot(x,y, 'ok');
axis([0 4 -1.1 1.1]);
grid on;
title("Interpolation - Neville's algorithm");
#legend("Original function", "Interpolating polynomial",
#       "Support points", "location", "northeastoutside")

subplot(2,1,2);
hold on;
plot(t, in - out);
plot(x, f(x) - y, 'ok');
grid on;
title("Absolute error");
#legend("Error", "Support points", "location", "northeastoutside");
