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
When running the program, an exception "java.lang.OutOfMemoryError" occurs, because we run out of heap space. This happens due to the line:
`private final Node dummy = new Node(-444, null);`
where the queue object keeps a permanent variable called dummy, which all the following Node objects get chained after. The dummy Node is a way to ensure that head and tail always point at something, even when the queue is empty.
Java's garbage collector only frees things that aren't being pointed to. Say we have n additional nodes: if dummy points to node_1, node_1 points to node_2, and so on n many times, none of the nodes will ever be freed and, as such, we run out of heap space.

This is fixed by not keeping the dummy node in a field, but rather creating it in the constructor of SentinelLockQueue and pointing head and tail to it.