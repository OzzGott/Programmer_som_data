### Exercise 7.4

Added `PreInc` and `PreDec` to the abstract syntax in `Absyn.fs`.
Extended the interpreter to include a match case in `eval` for each of these cases. 
By first calling `access`, we get the location and store. We can then get the value associated with the address through a call to `getSto`. Finally, this integer value is incremented/decremented, and returned, along with the updated store, in the form of a tuple: (value', store').


### Exercise 7.5

- Added tokens for `++` and `--` in the .fsl file.

- Added `PREINC` and `PREDEC` as tokens in the .fsy file. These were made non-associative.

### Exercise 8.1

i) Compiled and ran ex11.c using the functions from ParseAndComp.fs

ii) Repeated the steps from the warmup, now with ex03.c and ex05.c.

Running `java Machine CEx/ex03.out 8` produces the output:

0 1 2 3 4 5 6 7 
Used 0.003 seconds

Running `java Machine CEx/ex05.out 8` produces the output:

64 8 
Used 0.003 seconds

We ran compileToFile and Machinetrace on examples 3 and 5, and analyzed the outputs. compileToFile produces the symbolic instruction list, and writes the numeric bytecode to .out files. 
In the machine trace output, each line shows the stack contents before the instruction runs. This is followed by some {pc: instruction}, where pc is the instruction’s address in the bytecode. The addresses skip numbers because some instructions take multiple arguments.

When looking at the value in fsi after compiling to file, we see that the instruction list includes labels for every place a jump lands at some point during execution.

Example 3:
```
Label   instr                      description 
    
        LDARGS 1                   load command line arguments "n"
        Call (1, "L1")             main(n)
        STOP                       stop when main returns

L1:
        INCSP 1;                   int i; (make room for i)
        GETBP; CSTI 1; ADD;        i = 0;  (address of i)
        CSTI 0;                    (value 0)
        STI;                       (write 0 into i)
        INCSP -1;                  (discard leftover value)
        GOTO "L3";                 jump to while condition test

L2:
        GETBP; CSTI 1; ADD; LDI;   print i; (pop value of i)
        PRINTI;                    (print i)
        INCSP -1;                  (discard leftover value)
        GETBP; CSTI 1; ADD;        i = i+1 (get address of lhs i)
        GETBP; CSTI 1; ADD; LDI;   (value of i)
        CSTI 1; ADD;               (i + 1)
        STI; INCSP -1;             (write it into i, discard leftover)
        INCSP 0;                   (end of while body)

L3:
        GETBP; CSTI 1; ADD; LDI;   i < n (value of i)
        GETBP; CSTI 0; ADD; LDI;   (value of n)
        LT;                        (if i < n then 1 else 0)
        IFNZERO "L2";              (jump if 0)
        INCSP -1;                  (discard leftover)
        RET 0;                     otherwise return from main
``` 

Example 5:
```
Label   instr                      description 

        LDARGS 1;                  load command line arguments "n"
        CALL (1, "L1");            main(n)
        STOP;                      stop when main returns.

L1:         
        INCSP 1;                   int r; (make room for outer r, offset 1)
        GETBP; CSTI 1; ADD;        r = n; (get address of r)
        GETBP; CSTI 0; ADD; LDI;   (get value of n)
        STI;                       (write value of n into r)
        INCSP -1;                  (discard leftover)
        INCSP 1;                   { int r; (make room for inner r, offset 2)
        GETBP; CSTI 0; ADD; LDI;   square(n, &r) (1st argument: value of n)
        GETBP; CSTI 2; ADD;        (2nd arg: &r, address of inner r)
        CALL (2, "L2");            (call square)
        INCSP -1;                  (discard leftover)
        GETBP; CSTI 2; ADD; LDI;   print r; (pop value of inner)
        PRINTI; INCSP -1;          (print inner r, discard leftover)
        INCSP -1                   }  (end of inner block, pop inner r)                                    
        GETBP; CSTI 1; ADD; LDI;   print r; (pop value of first r)
        PRINTI; INCSP -1;          (print outer r, discard leftover)
        INCSP -1                   }  (end of main, pop outer r)                                    
        RET 0;                     return from main

L2:
        GETBP; CSTI 1; ADD; LDI;   *rp = i * i (value of rp (pointer), the address to write to)
        GETBP; CSTI 0; ADD; LDI;   (value of i);
        GETBP; CSTI 0; ADD; LDI;   (value of i again);
        MUL; STI;                  (i * i)
        STI;                       (write into address that rp points to)
        INCSP -1;                  (discard leftover)
        INCSP 0;                   (end of function body)
        RET 1;                     return from square 
    
```

### Exercise 8.3 

### Exercise 8.4