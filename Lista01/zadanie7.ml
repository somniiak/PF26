let ctrue a b = a

let cfalse a b = b

let zero f x = x

let succ fn = fun f x -> fn f (f x)

let add f1 f2 = fun f x -> f1 f (f2 f x)

let mul f1 f2 = fun f x -> (f1 (f2 f)) x

let rec cnum_of_int n =
  if n <= 0 then zero
  else succ (cnum_of_int (n - 1))

let int_of_cnum f = f (fun x -> x + 1) 0

let is_zero n =
  if int_of_cnum n = 0 then ctrue else cfalse
