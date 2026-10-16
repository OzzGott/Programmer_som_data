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

We ran Machinetrace on example 3, and analyzed the output. In it, each line has a stack frame and some instruction.
The numbers before the colon, like {22: ADD}, are the position of that instruction in the bytecode. When looking at the value in fsi after 
```
Label   instr                      description 
    
        LDARGS 1                   load command line arguments "n"
        Call (1, "L1")             main(n)
        STOP                       stop when main returns

L1:
        INCSP 1;                   int i
        GETBP; CSTI 1; ADD;        i = 0
        CSTI 0;
        STI;
        INCSP -1;
        GOTO "L3";                 jump to while condition 

L2:
        GETBP; CSTI 1; ADD;       
        LDI; PRINTI;               print i
        INCSP -1;
        GETBP; CSTI 1; ADD;    
        GETBP; CSTI 1; ADD; LDI;   i = i+1 
        CSTI 1; ADD;
        STI; INCSP -1;
        INCSP 0;                   end of while body

L3:
        GETBP; CSTI 1; ADD; LDI;   load i
        GETBP; CSTI 0; ADD; LDI;   load n
        LT; IFNZERO "L2";          jump to loop body if i < n
        INCSP -1;
        RET 0;                     otherwise return
``` 

### Exercise 8.3 

### Exercise 8.4