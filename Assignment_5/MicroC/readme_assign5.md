### Exercise 7.1

When parsing ex01.c from CEx, the following tree was returned:

val it: Absyn.program =
  Prog
    [Fundec
       (None, "main", [(TypI, "n")],
        Block
          [Stmt
             (While
                (Prim2 (">", Access (AccVar "n"), CstI 0),
                 Block
                   [Stmt (Expr (Prim1 ("printi", Access (AccVar "n"))));
                    Stmt
                      (Expr
                         (Assign
                            (AccVar "n",
                             Prim2 ("-", Access (AccVar "n"), CstI 1))))]));
           Stmt (Expr (Prim1 ("println", CstI 10)))])]


The declarations here are `[Fundec (None, "main", [(TypI, "n")],` where `main` gets declared with param `n`
The types in main is the return type `None`(it is a void return type) and the parameter type `TypI` which is an integer.

The statements here are `Block`, `While`, `Expr` and `Stmt` 
The expressions are `Prim1`, `Prim2`, `Access`, `Assign`, `CstI`. 
Then `AccVar` is an access used inside `Access` and `Assign` to read `n` and write `n` respectively.


We also ran ex01.c and to no surprise it printed the numbers from n to 1, given that n is an integer over 0.
Running ex11.c with parameter 8, gave us all solutions to the 'Queens problem' for an 8x8 board. The 92 solutions was posted line-by-line with each having 8 numbers that symbolized in what column each queen would be in by row.

We did also run ex05.c which was not specified in the exercise, but was mentioned in the README.md file, and that returned the square number the input paramter.


### Exercise 7.2

### Exercise 7.3
We added the keyword `for` to `CLex.fsl` and declared a `FOR` token in `CPar.fsy`, together with productions that translate `for (e1; e2; e3) stmt` directly into the block `{ e1; while (e2) { stmt e3; } }`.
The productions are added to both StmtM and StmtU, mirroring while. Since the parser builds ordinary `Block`, `While` and `Expr` nodes, Absyn.fs and the interpreter are unchanged.

