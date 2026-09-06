(* Programming language concepts for software developers, 2010-08-28 *)

(* Evaluating simple expressions with variables *)

//module Intro2

(* Association lists map object language variables to their values *)

let env = [("a", 3); ("c", 78); ("baf", 666); ("b", 111)];;

let emptyenv = [];;

let rec lookup env x =
    match env with 
    | []        -> failwith (x + " not found")
    | (y, v)::r -> if x=y then v else lookup r x;;

let cvalue = lookup env "c";;


(* Object language expressions with variables *)

type expr = 
  | CstI of int
  | Var of string
  | Prim of string * expr * expr
  | If of  expr * expr * expr;;

let e1 = CstI 17;;

let e2 = Prim("+", CstI 3, Var "a");;

let e3 = Prim("+", Prim("*", Var "b", CstI 9), Var "a");;


(* Evaluation within an environment *)

let rec eval e (env : (string * int) list) : int =
    match e with
    | CstI i            -> i
    | Var x             -> lookup env x 
    | Prim("+", e1, e2) -> eval e1 env + eval e2 env
    | Prim("*", e1, e2) -> eval e1 env * eval e2 env
    | Prim("-", e1, e2) -> eval e1 env - eval e2 env
    | Prim("max", e1, e2) -> if eval e1 env > eval e2 env then eval e1 env else eval e2 env
    | Prim("min", e1, e2) -> if eval e1 env < eval e2 env then eval e1 env else eval e2 env
    | Prim("==", e1, e2) -> if eval e1 env = eval e2 env then 1 else 0
    | If(e1, e2, e3)    -> if eval e1 env <> 0 then eval e2 env else eval e3 env
    | Prim _            -> failwith "unknown primitive";;

let rec eval2 e (env :(string * int) list) : int =
    match e with
    | CstI i            -> i
    | Var x             -> lookup env x
    | Prim(ope, e1, e2) ->
        let i1 = eval e1 env
        let i2 = eval e2 env
        match ope with
        | "+"   -> i1 + i2
        | "*"   -> i1 * i2
        | "-"   -> i1 - i2
        | "max" -> if i1 > i2 then i1 else i2
        | "min" -> if i1 < i2 then i1 else i2
        | "=="  -> if i1 = i2 then 1 else 0
        | _     -> failwith "unknown primitive"
    | If(e1, e2, e3)    -> if eval e1 env <> 0 then eval e2 env else eval e3 env;;

let e1v  = eval e1 env;;
let e2v1 = eval e2 env;;
let e2v2 = eval e2 [("a", 314)];;
let e3v  = eval e3 env;;

let e4 = Prim("max", Var "c", Var "baf");;
let e4v = eval e4 env;;
let e5 = Prim("==", Var "a", CstI 20);;
let e5v = eval e5 env;;
let e5v2 = eval e5 [("a", 20)];;

let e6 =  If(Var "a", CstI 11, CstI 22);;

// Exercise 1.2 

// (i)
type aexpr =                    
     | CstI of int
     | Var of string
     | Add of aexpr * aexpr
     | Mul of aexpr * aexpr
     | Sub of aexpr * aexpr;;
     
// (ii)
let ae1 = Sub(Var "v", Add(Var "w", Var "z"));; 
let ae2 = Mul(CstI 2, ae1);;
let ae3 = Add(Var "x", Add( Var "y", Add(Var "z", Var "v")));;

// (iii)

let rec fmt (a : aexpr) : string =          // fmt Mul(Add(CstI 2, Var "x"), Var "y") = "(2+x)*y"
    match a with
    | CstI x -> string x
    | Var v -> v
    | Add(a1, a2) -> "(" + fmt a1 + "+" + fmt a2 + ")"
    | Mul(a1, a2) -> "(" + fmt a1 + "*" + fmt a2 + ")"
    | Sub(a1, a2) -> "(" +  fmt a1 + "-" + fmt a2 + ")"
    | _ -> failwith "not implemented";;
    
// (iv)
let rec simplify (a : aexpr) : aexpr =
    match a with
    | CstI n        -> CstI n
    | Var v         -> Var v
    | Add(e, CstI 0) -> simplify e
    | Add(CstI 0, e) -> simplify e
    | Sub(e, CstI 0) -> simplify e
    | Mul(CstI 1, e) -> simplify e
    | Mul(e, CstI 1) -> simplify e
    | Mul(CstI 0, _) -> CstI 0
    | Mul(_, CstI 0) -> CstI 0
    | Sub(e1, e2) when e1 = e2 -> CstI 0
    | Mul(e1, e2)    -> Mul(simplify e1, simplify e2)
    | Sub(e1, e2)    -> Sub(simplify e1, simplify e2)
    | Add(e1, e2)    -> Add(simplify e1, simplify e2) 

// (v)
let rec diff (a : aexpr) x : aexpr =
    match a with
    | CstI _            -> CstI 0
    | Var v             -> if v = x then CstI 1 else CstI 0
    | Add (f, g)        -> Add(diff f x, diff g x)
    | Sub (f, g)        -> Sub(diff f x, diff g x)
    | Mul (f, g)        -> Add(Mul(diff f x, g) , Mul(f, diff g x))