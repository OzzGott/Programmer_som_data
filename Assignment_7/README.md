### Exercise 8.5 

- Added a case `Ternary` of `expr * expr * expr` to the expr type in `Absyn.fs`
- Added tokens for the symbols '?' and ':' in the fsl file.
- Also extended the .fsy file to include tokens "QMAKR" and "COLON".

### Exercise 8.6 

- Added the case `Switch of expr * (int * stmt) list` to the statement type in `Absyn.fs`. The cases in the list consist of integers and b are represented 
- 

### Exercise 9.1

- Dissasembled the selection sort algorithm `Selsort` both for C# and Java, using `ilspycmd` and `javap` respectively.
- From this `Selsort.il` and `Selsort.jvmbytecode` was generated, and we isolated the method `SelectionSort` in both.
- We then commented what happened in both onto the code. The actual going on of the code was of course the same, but the ways the two types of bytecode looks and were structured were wildly different.
- For example in the jvm bytecode, the local value `3` is both `j` and `tmp` since the jvm notices that those two aren't used at the same time.

### Exercise 9.3 