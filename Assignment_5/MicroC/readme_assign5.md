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
We decided to construct the for-loop mentioned in exercise 7.3 first.
The whole idea is to write then rewrite, and we felt it made more sense to write them using the for-loop already.
And since a for-loop can easily be constructed from a while-loop using an iterator, we decided to skip the redundancy.

i) The solution to this can be found in `CEx/test1.c`.
In `main` we make and fill the integer array with the data from the exercise and we declare our `sum` and our pointer `*p` that points to the value of `sum`.
In `arrsum` we go over `arr` with a for-loop and with each iteration we add the value of `arr` to our sum.


ii) The solution to this can be found in `CEx/test2.c`.
Here we use `arrsum` in the same way as before, and `main` is very similar as well.
Where this changes from `test1.c` is in the `squares` function.
`squares` fills `arr` with the squares of the numbers of the index of `arr` so that `arr[n]` = n^2



iii) The solution to this can be found in `CEx/test3.c`.
The `main` function is of least importance and only serves to make the initial integer array as specified in the exercise, make the `freq` integer array and call the `histogram` function.
The interesting bit is the `histogram` function.
To solve the problem we chose to iterate over the array for each value we are looking for as denoted by `max`.
This might not be the most efficient way of doing it `O(n^2)`, but it works well enough.

To go over this we first make a for-loop of length `max+1` and for each iteration of that we go through `arr` with another for-loop of length `n` and count the instances of `i` in `arr` and add that to `freq[n]`.


### Exercise 7.3
We added the keyword `for` to `CLex.fsl` and declared a `FOR` token in `CPar.fsy`, together with productions that translate `for (e1; e2; e3) stmt` directly into the block `{ e1; while (e2) { stmt e3; } }`.
The productions are added to both StmtM and StmtU, mirroring while. Since the parser builds ordinary `Block`, `While` and `Expr` nodes, Absyn.fs and the interpreter are unchanged.

