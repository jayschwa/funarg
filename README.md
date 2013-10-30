# Funarg: I heard you like function arguments so we put function arguments in your function ...

## Usage

~~~
julia> function foo(x, y)
         x * y
       end
foo (generic function with 1 method)
~~~

~~~
julia> a = 10
10
~~~

~~~
julia> @funarg foo_a_a
100
~~~

~~~
julia> @funarg foo_a_15
150
~~~

## FAQs

### Why?
Why not?

## TODOs:
Support named arguments
Make a macro that lets you declare variables and functions that conflict with reserved words