(* https://blog.ocaml.xyz/algorithm/2021/09/12/church-numerals.html *)
(* https://rosettacode.org/wiki/Church_numerals#OCaml *)

type cbool = { cbool : 'a. 'a -> 'a -> 'a }
type cnum = { cnum : 'a. ('a -> 'a) -> 'a -> 'a }

let ctrue =
  { cbool = fun a _ -> a }

let cfalse =
  { cbool = fun _ b -> b}

let cand f1 f2 =
  { cbool = fun a b -> f1.cbool (f2.cbool a b) b}

let cor f1 f2 =
  { cbool = fun a b -> f1.cbool a (f2.cbool a b)}

let cbool_of_bool b =
  if b then ctrue else cfalse

let bool_of_cbool f =
  f.cbool true false

(* (f, x) |-> f^n(x) - zaaplikuj funkcję f n-krotnie.*)

(* Zaaplikuj f 0-krotnie do x, czyli zwróć x *)
let zero =
  { cnum = fun _ x -> x }

let succ n =
  { cnum = fun f x -> f (n.cnum f x) }

let add m n =
  { cnum = fun f x -> n.cnum f (m.cnum f x)}

let mul m n =
  { cnum = fun f x -> m.cnum (n.cnum f) x}

let rec cnum_of_int n =
    if n <= 0 then zero
    else succ (cnum_of_int (n -1))

let int_of_cnum n =
  n.cnum (( + ) 1) 0

let rec is_zero n =
  if int_of_cnum n = 0 then ctrue else cfalse