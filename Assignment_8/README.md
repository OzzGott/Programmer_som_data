### Exercise 10.1

(i) "Write 3-10 line descriptions of how the abstract machine executes each of the following instructions:"

We couldn't find listmachine.c, so instead we looked at the file `MicroVM/microvm.c`

Here, we need to tell the difference between real numbers and pointers.
Tag turns a real number into a labeled number, by shifting it left by one bit, then sticking a 1 on the end.
Untag throws away the label to get the real number back by shifting right by one bit.

• ADD, which adds two integers.

ADD works by adding the integer values of the first two integers on the stack. After adding them, the stack pointer sp is decremented, such that the result of the addition is left on index `sp-1` of the stack

• CSTI i, which pushes integer constant i.

It reads the constant i from the program array p, where it is stored untagged. Then it advances pc (program counter) past it, tags it, and pushes it. The stack grows by one as a result.

• NIL, which pushes a nil reference. What is the difference between NIL and CSTI 0?

NIL pushes the word 0 (NILVALUE) on top of the stack. The stack grows by one. The difference between NIL and CSTI 0 is that CSTI 0 would be stored as an interger value, while NIL stores a reference, since it isn't tagged.

• IFZERO, which tests whether an integer is zero, or a reference is nil.

IFZERO works by popping the top of the stack, then does the following:
If the value is an interger, then it is untagged and we check if the value is 0. 
If it is not an integer, then the pointer is likewise checked to see if it is 0.
Then, if the value of either the int or pointer is 0 (true), we jump to the label address p[pc]. If the result is false, we instead skip ahead to pc+1.

• CONS

CONS builds a cons cell by allocating a 2-word block with the CONSTAG in the heap. `allocate` returns a pointer to the start of this block. `word* p` means that p is a pointer to a word, so `p[1]` is first component and `p[2]` is the second. CONS takes its inputs from the stack: head at s[sp-1], tail at s[sp].

These two values are consumed, and the value left on the stack is the cell. The stack pointer is therefore decreased just once, such that one value is left. 


• CAR

CAR takes the word at the top of the stack, which should be a pointer to a cons cell, and treats it as a pointer p into the heap.
If p is 0 (nil), there is no cell to read, so it prints “Cannot take car of null” and aborts execution with return -1. Otherwise it replaces the top of the stack with p[1], the first field (car) of the cell 

• SETCAR
SETCAR pops the new value to be set v from the stack. It then takes the cons pointer which is now on top and then writes v into the first cell (`p[1]`).

It doesn't leave the value on the stack, just the cons pointer which is now at the top of the stack.

### Exercise 10.2 

### Exercise 10.3