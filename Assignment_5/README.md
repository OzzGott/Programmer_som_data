#### Exercise 6.4 

∀
↦
⊢

- i: the reason it is polymorphic is that there is no operation in the function that forces x to be an integer. f will always return an integer, no matter the type of x.

the tree:

```
––––––––––––––––––––––––––––––––––––p1
  [x ↦ tx, f ↦ tx ↦ int] |- 1 = int          []
_______________________________________________________________p8
[] |- f x = 1 in f f end :
```
- ii:
```  
                                                                         gi__________p1   __________p1
                                                                          ρ ⊢ x : int    ρ ⊢ 1 : int
_____________p1   _______________p1                                          ________________________p4
  ρ ⊢ x : int      ρ ⊢ 10 : int                         ρ ⊢ f : int -> tr       ρ ⊢ x+1 : int
________________________________p5      ____________p1   _________________________________ p9
  ρ ⊢ x<10 : bool                        ρ ⊢ 42 : int       ρ ⊢ f(x+1) :  
_____________________________________________________________________________________p7          ________________________________________
[x ↦ tx, f ↦ tx ↦ tr] ⊢ if x<10 then 42 else f(x+1) :                                             [f ↦ ∀ a ... an . tx ↦ tr] ⊢ f 20 :
_____________________________________________________________________________________________________________________________________p8
[] ⊢ let f x if x<10 then 42 else f(x+1) in f 20 end :
```

#### Exercise 6.5


#### Exercise 7.1
#### Exercise 7.2
#### Exercise 7.3

