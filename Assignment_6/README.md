### Exercise 7.4

Added `PreInc` and `PreDec` to the abstract syntax in `Absyn.fs`.
Extended the interpreter to include a match case in `eval` for each of these cases. 
By first calling `access`, we get the location and store. We can then get the value associated with the address through a call to `getSto`. Finally, this integer value is incremented/decremented, and returned, along with the updated store, in the form of a tuple: (value', store').


### Exercise 7.5

- Added tokens for `++` and `--` in the .fsl file.

- Added `INC` and `DEC` as tokens in the .fsy file

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
The numbers before the colon, like {22: ADD}, are the position of that instruction in the bytecode.

| addr | Bytecode + args | instr | micro-c |
| ---- | ------- | ----- | ------- |
| 0    |  100 1  |LDARGS | (loads n from command line)        |
| 2    | 80 1 6  |CALL 1 6| main(n)     |
| 5    | 101     | STOP  |         |
| 6    | 62 1    | INCSP 1 |         |
| 8    | 60      | GETBP   |         |
| 9    | 0 1     | CSTI 1  |   |
| 11   | 10      | ADD  |    |
| 12   | 0 0     | CST 0  |    |
| 14   | 41      | STI  |    |
| 15   | 62 -1   | INCSP -1  |    |
| 17   | 70 44   | GOTO 44 |    |
| 44   | 60      | GETBP  |    |
| 45   | 0 0     | CSTI 0 |    |
| 47   | 10      | ADD  |    |
| 48   | 40      | LDI  |    |
| 49   | 60      | GETBP  |    |
| 50   | 0 0      | CSTI 0  |    |
| 52   | 10      | ADD  |    |
| 11   | 10      | ADD  |    |



### Exercise 8.3 

### Exercise 8.4