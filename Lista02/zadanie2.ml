(* https://stackoverflow.com/a/47665004 *)

let rec sublists xs =
  match xs with
  | [] -> [[]]
  | hd::tl ->
    let ls = sublists tl in
    (List.map (fun l -> hd :: l) ls) @ ls