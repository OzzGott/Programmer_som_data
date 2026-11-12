### Exercise 12.1
Added this auxilary function to `Contcomp.fs` (lines 112-116):
```f#
let rec addIFZERO lab3 c = 
    match c with
    | (IFZERO lab0 :: GOTO lab1 :: Label lab2 :: rs) when lab0 = lab2
         -> IFNZRO lab1 :: Label lab0 :: rs
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


### Exercise 12.3

### Exercise 12.4
