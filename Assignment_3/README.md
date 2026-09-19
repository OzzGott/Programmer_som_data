## Assignment 3


#### Exercise 3.5
Examples at the bottom of Expr/Parse.fs


#### Exercise 3.6
CompString in Expr/Expr.fs takes a string and parses it into an AST using Parse.fromString. Then it compiles the result into stack-machine instructions using scomp, and returns the instruction list.


#### Exercise 3.7
Extended Expr/Absyn.fs, Expr/ExprLex.fsl and Expr/ExprPar.fsy to include conditionals in the language.


#### Exercise 4.1
Ran the examples in Fun/ParseAndRun.fs and verified their evaluated results.


#### Exercise 4.2
Implemented and evaluated the examples at the bottom of Fun/ParseAndRun.fs.


#### Exercise 4.3
Altered Letfun and Call in Fun/Absyn.fs to take lists of parameters and arguments instead of a single parameter/argument.

Modified eval in Fun.fs to evaluate each argument using List.map. The resulting values are then paired with the parameter names using List.zip, allowing each parameter to be bound to its corresponding argument value.


#### Exercise 4.4
Altered the Fun/FunPar.fsy file to support non-empty parameter- and argument lists.
Changed Letfun to use Params1 and AppExpr to construct Call expressions containing a list of arguments. Tested the parser with multi-parameter functions and multi-argument function applications in Fun.fs