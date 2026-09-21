(* File Fun/ParseAndRun.fs *)

module ParseAndRun

let fromString = Parse.fromString;;

let eval = Fun.eval;;

let run e = eval e [];;

(* Exercises 4.1 and 4.2 *)
let e1 = run (fromString "5+7");;
let e2 = run (fromString "let y = 7 in y + 2 end");;
let e3 = run (fromString "let f x = x + 7 in f 2 end");;

(* Compute the sum of the numbers from 1000 down to 1. *)
let e4 = run (fromString "let downTo n = if n = 1 then 1 else n + downTo (n - 1) in downTo 1000 end");;

(* Compute the number 3^8, that is, 3 raised to the power 8 *)
let e5 = run (fromString "let pow3 n = if n = 0 then 1 else 3 * pow3 (n - 1) in pow3 8 end");;

(* Compute 3^0 + 3^1 + ··· + 3^10 + 3^11, using a recursive function *)
let e6 = 
    run (fromString 
        "let pow3 x =
            if x = 0 then 1
            else 3 * pow3 (x - 1)
                in let sum n = 
                    if n = 0 then 1 
                    else pow3 n + sum (n - 1)
                        in sum 11
                end   
            end");;

(* Compute 1^8 + 2^8 + ··· + 10^8, again using a recursive function (or two) *)
let e7 =
    run (fromString 
        "let sum n = if n = 1
            then 1
            else (let pow x =
                if x = 0 then 1
                else n * pow (x - 1) 
                in pow 8 
                end) + sum (n - 1)
            in sum 10 
        end");;

(* tests for Exercise 4.5 *)

let e8 = run (fromString "let n = 2 in 1 < n && n < 3 end");; //should be true
let e9 = run (fromString "let n = 0 in n < 5 || n < 10 end");; //should be true
let e10 = run (fromString "let n = 5 in 20 < n || 10 < n end");; // should be false

let e11 = run (fromString "true && false");; // should be false
let e12 = run (fromString "true || false");; // should be true