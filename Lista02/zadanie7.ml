type 'a heap = 
  | Leaf
  | Node of 'a * int * 'a heap * 'a heap

(* Node (wartość, długość prawego kręgosłupa, lewy syn, prawy syn) *)

let empty = Leaf

let spine h =
  match h with
  | Leaf -> 0
  | Node(_, s, _, _) -> s

(* x <= od wszystkich etykiet w obu poddrzewach. *)
(* To z większym kręgosłupem dajemy na lewo. *)
let make x a b =
  if spine a >= spine b then
    Node(x, spine b + 1, a, b)
  else
    Node(x, spine a + 1, b, a)

let rec merge a b =
  match a, b with
  | Leaf, h | h, Leaf -> h
  | Node (x, _, l1, r1), Node (y, _, l2, r2) ->
    if x < y then
      make x l1 (merge r1 b)
    else
      make y l2 (merge a r2)

let insert x h =
  merge (Node(x, 1, Leaf, Leaf)) h

let delete_min h =
  match h with
  | Leaf -> Leaf
  | Node(x, _, l, r) ->
    merge l r
