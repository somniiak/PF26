let ctrue a b = a

let cfalse a b = b

let zero f x = x

let succ fn = fun f x -> fn f (f x)

let add f1 f2 = fun f x -> f1 f (f2 f x)

let mul f1 f2 = fun f x -> (f1 (f2 f)) x
let is_zero f = 
  let g x = x + 1 
  in if (f g 0) = 0 then ctrue else cfalse
let rec cnum_of_int = function
  | 0 -> zero
  | n -> succ (cnum_of_int (n - 1))

let int_of_cnum f = f (fun x -> x + 1) 0
