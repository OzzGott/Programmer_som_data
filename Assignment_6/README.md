### Exercise 7.4

Added `PreInc` and `PreDec` to the abstract syntax in `Absyn.fs`.
Extended the interpreter to include a match case in `eval` for each of these cases. 
By first calling `access`, we get the location and store. We can then get the value associated with the address through a call to `getSto`. Finally, this integer value is incremented/decremented, and returned in a tuple along with the updated store (i.e. (value', store')).


### Exercise 7.5


### Exercise 8.1

### Exercise 8.3 

### Exercise 8.4