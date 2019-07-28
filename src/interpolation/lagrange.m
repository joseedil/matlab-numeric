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

## -*- texinfo -*-
## @deftypefn  {} {@var{p} =} lagrange (@var{x}, @var{f})
## @deftypefnx {} {[@var{p}, @var{l}] =} lagrange (@var{x}, @var{f})
##
## Calculate the Lagrange interpolating polynomial @var(p) at the
## specified support abscissas @var{x} and ordinates @var{f}.
##
## The second output @var{l)} represents the Lagrange basis
## polynomials for the given support points. The i-th line of @var{l}
## is the polynomial in which Li(x(i)) = 1 and zero on the other
## support abscissas.
##
## @seealso{polyval, poly}
## @end deftypefn

## Author: José E. G. de Medeiros
## Created: July 2019

function [p, L] = lagrange(x, f)

  if (nargin != 2)		# Check number of arguments
    print_usage();
  endif

  if (!isvector(x) || !isvector(f)) # Check if arguments are vectors
    error ("lagrange: arguments X and Y must be vectors");
  endif

  if (length(x) != length(f))	# Check if arguments match dimensions
    error ("lagrange: X and Y dimensions must match");
  endif

  x = reshape(x, 1, length(x));
  f = reshape(f, length(f), 1);

  L = zeros(length(x));
  ind = [0 ones(1, length(x) - 1)] >= 1;

  # Lagrange basis
  for i = 1:length(x)
    num = poly(x(shift(ind, i-1)));
    den = polyval(num, x(i));
    L(i,:) = num ./ den;
  endfor

  p = sum(repmat(f, 1, length(x)) .* L);

endfunction
