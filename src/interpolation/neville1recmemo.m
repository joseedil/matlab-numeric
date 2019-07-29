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
## @deftypefn  {} {@var{y} =} neville1recmemo (@var{t}, @var{x}, @var{f})
##
## Calculate the interpolating polynomial specified  by
## support abscissas @var{x} and ordinates @var{y} at points @var{t}
## using a memoized recursive implementation of Neville's algorithm.
##
## @seealso{polyval, poly}
## @end deftypefn

## Author: José E. G. de Medeiros
## Created: July 2019

function y = neville1recmemo(t, x, f)

  debug = false;			# Debug flag

  if (nargin != 3)		# Check number of arguments
    print_usage();
  endif

  # Check if arguments are vectors
  if (!isvector(x) || !isvector(f) || !isvector(t))
    error ("neville1rec: arguments t, x and f must be vectors");
  endif

  if (length(x) != length(f))	# Check if arguments match dimensions
    error ("neville1rec: x and f dimensions must match");
  endif

  x = reshape(x, 1, length(x));
  f = reshape(f, 1, length(f));

  ## Cache
  persistent cache;
  persistent calls;
  c_size = numel(cache);

  ## Initialize cache
  if(c_size == 0)
    ## cache{i}{k}: i = x vector size
    ## Format:    x   out
    cache{1}{1} = {[], []};
    calls = 0;			# Keep track of recursion depth.
  endif

  calls++;
  ## Check if we already cached the solution.
  ind = [];
  n = numel(x);

  if (n <= numel(cache))	# There is at least one entry of
				# size >= n
    if (!isempty(cache{n}))	# Cache is not empty for this dimension

      ## Search entry
      ##for i = numel(cache{n}):-1:1 # Search in reverse order
      for i = 1:numel(cache{n})
	if isequal(cache{n}{i}{1}, x)	# Entry found!
	  ind = i;
	  if debug; disp("Cache entry found."); endif
	  break;
	endif
      endfor
    endif
  endif


  if isempty(ind)		# If not cached

    ## Calculate solution...
    if debug;
      disp("Cache entry not found. Calculating new solution...");
    endif

    if(length(x) == 1)
      y = f;
    else
      x1 = x(1, 2:end); f1 = f(1, 2:end);
      x2 = x(1, 1:end-1); f2 = f(1, 1:end-1);

      y = ((t - x(1)).*neville1recmemo(t, x1, f1) ...
	   - (t -x(end)).*neville1recmemo(t, x2, f2)) ...
	  / (x(end) - x(1));
    endif

    ## Add cache entry
    if(n>1)
      cache{n}{end+1} = {x, y};
      if debug;
	disp("Cache entry added");
      endif
    endif


  else			# If cached
    y = cache{n}{ind}{2};
    if debug;
      disp("Using cache entry...");
    endif

  endif

  calls--;			# Exiting function: going up
				# on the recursion tree.
  if(calls == 0)		# This is the last call: clear cache.
    if debug; disp("Last call: clear cache"); endif;
    clear cache;

  endif

endfunction



## function y = neville1recmemo(t, x, f)

##   memoNeville = memoize(@neville1rec);
##   y = memoNeville(t, x, f);

## endfunction

## ## Specialized memoization function.
## ## t is the same between calls: don't cache.
## ## x and f always come in pairs: index by x only.
## function func = memoize(F)

##   ## cache{i} = {x f t out}
##   cache = {};
##   func = @inner;

##   function out = inner(in_t, in_x, in_f)

##     ## try to find in_x in cache
##     ind = [];
##     for i = 1:numel(m)
##       if(isequal(m{i}{1}, in_x)) # Found entry in cache
## 	ind = i;
## 	break;
##       endif
##     endfor

##     if (isempty(ind))		# Entry not in cache: call function
##       out = F(in_t, in_x, in_f);
##       cache{end+1} = {in_x, in_f, in_t, out}; # Add entry in cache
##     else		        # Entry is in cache: return result
##       out = m{ind}{4}
##     endif
##   endfunction

## endfunction
