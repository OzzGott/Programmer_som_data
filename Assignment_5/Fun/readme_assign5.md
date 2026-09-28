### Exercise 6.5

All programs were run with `inferType (fromString "...")` as described in
section F of the README.

#### (1)

| Program | Result |
|---|---|
| 1 | `int` |
| 2 | `System.Exception: type error: circularity` |
| 3 | `bool` |
| 4 | `System.Exception: type error: bool and int` |
| 5 | `bool` |

**Program 1** works because `f` is let-bound and generalized to
`forall 'a. 'a -> int`, so the two uses of `f` in `f f` get different
instances (`'b -> int` and `('b -> int) -> int`).

**Program 2** fails because `g` is a parameter and therefore not
generalized, so both occurrences in `g g` share one type `'a`. The
application requires `'a = 'b -> 'c` where `'b = 'a`, i.e.
`'b = 'b -> 'c`. No finite type satisfies this, so the occurs check fails.

**Program 3** works because `g` (the identity) does not mention `x`, so it is
generalized and `g false` does not constrain `x`. `f : 'a -> bool`.

**Program 4** fails because the `if` forces `y` and `x` to have the same type
`'a`, so `g : 'a -> 'a`. Since `'a` is free in the environment (via `x`),
`g` is not generalized. `g false` then sets `'a = bool`, giving
`f : bool -> bool`, and `f 42` fails to unify `bool` with `int`.

**Program 5** is the same as program 4, but `f true` matches
`f : bool -> bool`.

#### (2)

| Type | Program |
|---|---|
| `bool -> bool` | `let f x = if x then true else false in f end` |
| `int -> int` | `let f x = x + 1 in f end` |
| `int -> int -> int` | `let f x = let g y = x + y in g end in f end` |
| `'a -> 'b -> 'a` | `let f x = let g y = x in g end in f end` |
| `'a -> 'b -> 'b` | `let f x = let g y = y in g end in f end` |
| `('a -> 'b) -> ('b -> 'c) -> ('a -> 'c)` | `let f g = let h k = let m x = k (g x) in m end in h end in f end` |
| `'a -> 'b` | `let f x = f x in f end` |
| `'a` | `let f x = f x in f 1 end` |

The last two rely on non-termination: `f x = f x` never constrains its
result type, so it stays a free type variable.