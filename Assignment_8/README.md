### Exercise 10.1

#### (i) "Write 3-10 line descriptions of how the abstract machine executes each of the following instructions":

We couldn't find listmachine.c, so instead we looked at the file `MicroVM/microvm.c`

Here, we need to tell the difference between real numbers and pointers.
Tag turns a real number into a labeled number, by shifting it left by one bit, then sticking a 1 on the end.
Untag throws away the label to get the real number back by shifting right by one bit.

ADD, which adds two integers.

- ADD works by adding the integer values of the first two integers on the stack. After adding them, the stack pointer sp is decremented, such that the result of the addition is left on index `sp-1` of the stack

CSTI i, which pushes integer constant i.

- It reads the constant i from the program array p, where it is stored untagged. Then it advances pc (program counter) past it, tags it, and pushes it. The stack grows by one as a result.

NIL, which pushes a nil reference. What is the difference between NIL and CSTI 0?

- NIL pushes the word 0 (NILVALUE) on top of the stack. The stack grows by one. The difference between NIL and CSTI 0 is that CSTI 0 would be stored as an interger value, while NIL stores a reference, since it isn't tagged.

IFZERO, which tests whether an integer is zero, or a reference is nil.

- IFZERO works by popping the top of the stack, then does the following:
    - If the value is an interger, then it is untagged and we check if the value is 0. 
    - If it is not an integer, then the pointer is likewise checked to see if it is 0.
    - Then, if the value of either the int or pointer is 0 (true), we jump to the label address p[pc]. If the result is false, we instead skip ahead to pc+1.

CONS

- CONS builds a cons cell by allocating a 2-word block with the CONSTAG in the heap. `allocate` returns a pointer to the start of this block. `word* p` means that p is a pointer to a word, so `p[1]` is first component and `p[2]` is the second. CONS takes its inputs from the stack: head at s[sp-1], tail at s[sp].

- These two values are consumed, and the value left on the stack is the cell. The stack pointer is therefore decreased just once, such that one value is left. 

CAR

- CAR takes the word at the top of the stack, which should be a pointer to a cons cell, and treats it as a pointer p into the heap.
- If p is 0 (nil), there is no cell to read, so it prints “Cannot take car of null” and aborts execution with return -1. Otherwise it replaces the top of the stack with p[1], the first field (car) of the cell 

SETCAR
- SETCAR pops the new value to be set v from the stack. It then takes the cons pointer which is now on top and then writes v into the first cell (`p[1]`).

- It doesn't leave the value on the stack, just the cons pointer which is now at the top of the stack.

#### (ii):

Given a block header of 32-bits:
`tttttttt nnnnnnnnnnnnnnnnnnnnnn gg`

The C macros Length, Color and Paint can be applied to it.
The results are the following:
- Length(hdr) returns the length of the block’s contents in words, which is given in the 22 legth bits of the block. The right shift discards the 2 garbage (color) bits. The bit-mask removes the t bits.
- Color(hdr) returns the color that is given in the last two bits (gg) of the header, by performing bit-wise AND with the binary number 11 (decimal 3). This is either White, Blue, Black or gray.  
- Paint(hdr, color) results in the header being painted a given color. This is done by performing a bit-wise AND with a bit-mask (which ensures that the tag and length bits are preserved), then performing OR with the color (which is a 2 bit value).  


#### (iii):

In the interpreter loop (execcode), `allocate(...)` is called twice.
Firstly, `allocate(...)` is called when a cons cell is created.
Secondly, it is called for HEAPALLOC, which allocates heap objects with some tag.

The other interaction between the mutator and the garbage collector is of course that the mutator asks the garbage collector for a new object (a block), making the garbage collector inspect the freelist registers.
The stack is what holds the references into the heap, so when allocate calls collect(s, sp), the collector scans the stack to find what’s live. 

#### (iv):
`collect(...)` will be called in the situation where there is no free space, i.e. the mutator wants to allocate an object but lacks the space to do so.

### Exercise 10.2 

- `mark(word v)`: A recursive helper that takes a stack- or heap word. It returns right away if `v` is a tagged integer or nil, since those aren't heap references. Otherwise, it converts `v` to a `word*` which points at the block's header, and returns if the block isn't white (already visited). It then paints the block black, and recursively calls `mark` on each of the block's content words `block[1..len]`.
- `markPhase`: Loops over the stack slots `s[0..sp]` (inclusive, so `sp+1` iterations, because `sp` is the index of the top element) and calls `mark` on each, since the stack holds all the references into the heap.
- `sweepPhase`: scans the whole heap block by block. Black blocks are repainted white. White (unreachable) blocks are painted blue and prepended to the freelist. Blue blocks are skipped, since they are already on the freelist or are orphans. The "cursor" (sweep) advances by `len + 1` words each step (`sweep = sweep + len + 1`): `len` content words plus one for the header, because the length field excludes the header. This therefore lands on the next block's header.

### Exercise 10.3
To implement a `sweepPhase` that merges blocks together on the freelist, we iterate through the heap block by block, now also keeping a variable `next`, corresponding to the block that is being pointed to by the current block. If `next` is not out of range, and the next block is not black (live), then we extend the length of the next block by the the length of the current block, plus 1 for the header.
Then, after iterating through all consecutive white and blue blocks, we merge them by calling `mkheader(0, len, Blue)`.
We then add this to the freelist, granted that it is not an orphan (length 0).