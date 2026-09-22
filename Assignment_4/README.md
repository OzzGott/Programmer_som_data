
#### Exercise 4.5

Added tokens AND and OR to Fun/FunPar.fsy. Added rules to match Expr AND Expr and Expr OR Expr.


#### Exercise 5.7
Added `TypL` to TypedFun/TypedFun.fs to represent the List containing elements of type `typ`. Furthermore added both
Nil, Cons, Match to the `typ` function with fails both if input isn't a list and if there is a type inconsistency.

#### Exercise 6.1
Please see Fun1 for relevant files. We tried to make the assignment work, but the changes made in Assingment 3 that 
allowed Call expressions to have multiple arguments and function closures to have multiple parameters, were seemingly 
not compatible with this exercise. In the original version, function applications are represented as nested Call 
expressions, which seems to be required for the curried functions used in this exercise. Please let us know if we should 
instead adapt our Assignment 3 implementation to support these exercise.

In ex3 (Fun1/ParseAndRunHigher.fs), the inner `let x = 77` does not affect the result. The function returned by `add 2` 
has already stored the value `2` for `x`, so `addTwo 5` uses `2` and not `77`. Therefore, the expression evaluates to `7 (2 + 5)`.

As for ex4, the call to `add` with argument `2` will return the function `f` with `f y = 2 + y`. Specifically it returns 
the closure representing:
`Closure("f", "y", x + y, [(x, 2)])`


#### Exercise 6.2

Added `Fun of string * expr` to the disjoint union in Fun1/Absyn.fs
Added Clos to the value type 
Adapted the evaluater in Fun1/HigherFun.fs to return Clos for anonymous functions.

#### Exercise 6.3
Added examples of parsing anonymous functions from strings at the bottom of Fun1/ParseAndRunHigher.fs
