let is_generated (module P : Perm.S) (p : P.t) (g : P.t list) : bool =
  let module PS = Set.Make(P) in

  let rec loop x =
    let step x =
      PS.fold (fun s acc ->
        let acc = PS.add (P.invert s) acc in
        PS.fold (fun t acc ->
          PS.add (P.compose s t) acc) x acc) x x
    in
    if PS.mem p x then true
    else
      let new_x = step x in
      if PS.equal x new_x then false else loop new_x
  in
  loop (PS.of_list (P.id :: g))

(*
module PI = Perm.Make (Int);;
let s12 = PI.swap 1 2;;
let s23 = PI.swap 2 3;;
is_generated (module PI) (PI.swap 1 3) [s12; s23];;
is_generated (module PI) (PI.swap 1 4) [s12; s23];;
*)