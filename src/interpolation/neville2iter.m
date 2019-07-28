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
## @deftypefn  {} {@var{y} =} neville2iter (@var{t}, @var{x}, @var{f})
##
## Calculate the interpolating polynomial specified  by
## support abscissas @var{x} and ordinates @var{y} at points @var{t}
## using a modified iterative implementation of Neville's algorithm.
##
## @seealso{polyval, poly}
## @end deftypefn

## Author: José E. G. de Medeiros
## Created: July 2019

function y = neville2iter(t, x, f)

  if (nargin != 3)		# Check number of arguments
    print_usage();
  endif

  # Check if arguments are vectors
  if (!isvector(x) || !isvector(f) || !isvector(t))
    error ("neville2iter: arguments t, x and f must be vectors");
  endif

  if (length(x) != length(f))	# Check if arguments match dimensions
    error ("neville2iter: x and f dimensions must match");
  endif

  x = reshape(x, 1, length(x));
  f = reshape(f, 1, length(f));

  for k = 1:length(t)
    if (length(x) == 1)
      out(k) = f;
    else
      y = f;
      for i = 1:length(x)
	for j = 1:length(x)-i
	  y(j) = y(j+1) + (y(j+1) - y(j))/((t(k)-x(j))/(t(k)-x(j+i))-1);
	endfor
      endfor
      out(k) = y(1);
    endif
  endfor


  y = out;

  endfunction
