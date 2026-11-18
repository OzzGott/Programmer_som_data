### Exercise 12.1
Added this auxilary function to `Contcomp.fs` (lines 112-116):
```f#
let rec addIFZERO lab3 c = 
    match c with
    | GOTO lab2 :: Label lab1 :: rs) when lab1 = lab3
         -> IFNZRO lab2 :: Label lab1 :: rs
    | _  -> IFZERO lab3 :: c
```

Now, by calling this in cStmt for the If(e1, e2, e3) match case, we can optimize the byte code by ensuring that it 
replaces instructions like:

`IFZERO L1; GOTO L2; Label L1`

with:

`IFNZRO L2; Label 1`

- Wrote a similar function, `addIFNZRO` which does essentially the same thing, but for IFNZRO.
- Replaced all occurences of `IFZERO Lab :: code` with `addIFZERO lab code` and likewise for IFNZRO.

### Exercise 12.2
Added the following to `Contcomp.fs`

```F#
    | (i, CSTI i' :: EQ :: c1)         -> if i = i' then addCST 1 c1 else addCST 0 c1
    | (i, CSTI i' :: LT :: c1)         -> if i < i' then addCST 1 c1 else addCST 0 c1
    | (i, CSTI i' :: SWAP :: LT :: c1) -> if i' < i then addCST 1 c1 else addCST 0 c1
```
Which matches on the constant i and instruction list c. If c contains another `CstI i'` followed by one of the operations:
<, >, or =, the comparison will be compiled to it's boolean value.
Also added a test `addcst_test.c` which succesfully compiles to bytecode instructions without the "LDI, GETBP, LDI, LT" 
that would otherwise be present without this optimization. 

### Exercise 12.3

Added the following to the `expr` type in `Absyn.fs`:
```F#
  | Cond of expr * expr * expr       (* 12.3:   e1 ? e2 : e3        *)
```
then, i added the following match case to cExpr in Contcomp.fs:
```F#
| Cond(e1, e2, e3) ->                                                      
  let (jumpend, c1) = makeJump c
  let (labelse, c2) = addLabel (cExpr e3 varEnv funEnv c1)      // else
    cExpr e1 varEnv funEnv (addIFZERO labelse (                              
      cExpr e2 varEnv funEnv (addJump jumpend c2)))             // then
```
which does almost the exact same as If(e, stmt1, stmt2).
Extended the lexer and parser to include symbols `?` and `:`, and wrote the test `condtest.c` to verify that this works as intended.

### Exercise 12.4

Changed the parser specification in `CPar.fsy` such that `&&` and `||` are now built using Cond(e1, e2, e3):
```F#
 | Expr SEQAND Expr                    { Cond($1, $3, CstI 0) }
 | Expr SEQOR  Expr                    { Cond($1, CstI 1, $3) }
```
Wrote the (not exhaustive) test `seqtest.c` which tests the functionality of this.
