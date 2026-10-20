(* https://sauravbhattacharya001.github.io/Ocaml-sample-code/mergesort.html *)
(* https://blog.ocaml.xyz/algorithm/2023/11/20/mergesort.html *)

(* Bez rekursji ogonowej*)
let rec merge cmp l1 l2 =
  match l1, l2 with  
  | [], l | l, [] -> l  
  | h1 :: t1, h2 :: t2 ->
    if cmp h1 h2 then
      h1 :: merge cmp t1 l2  
    else
      h2 :: merge cmp l1 t2  

(* Z rekursją ogonową *)
let merge_tail cmp l1 l2 =
  let rec aux acc l1 l2 =
    match l1, l2 with
    | [], l | l, [] ->
      List.rev_append acc l
    | h1 :: t1, h2 :: t2 ->
      if cmp h1 h2 then
        aux (h1 :: acc) t1 l2
      else
        aux (h2 :: acc) l1 t2
  in aux [] l1 l2

(*
Przykład:
let a = List.init 9999999 (fun x -> x + 1);;
let b = List.init 9999999 (fun x -> x + 1);;
merge ( <= ) a b;;
merge_tail ( <= ) a b;;
*)

(*
`slow` usuwa po jednym elemencie od lewej i dodaje usunięty element do left.
`fast` usuwa w tym czasie po dwa elementy, gdy będzie pusty oznacza że `slow`,
ma już prawą połowę listy, a w `left` jest odwrócona pierwsza część listy.
*)
let halve lst =
  let rec aux slow fast left =
    match fast with
    | [] | [_] -> (left, slow)
    | _ :: _ :: tl ->
      aux (List.tl slow) tl (List.hd slow :: left)
  in
  let left_rev, right = aux lst lst [] in
  (List.rev left_rev, right)

let rec merge_sort lst =
  match lst with
  | [] | [_] -> lst
  | _ ->
    let left, right = halve lst in
    merge_tail ( <= ) (merge_sort left) (merge_sort right)
