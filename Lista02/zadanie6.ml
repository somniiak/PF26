(* https://stackoverflow.com/q/20196133 *)
(* http://typeocaml.com/2015/05/05/permutation/ *)

(* Przez wstawianie *)
let insert x lst =
  let rec aux prev acc lst =
    match lst with
    | [] ->
      (prev @ [x]) :: acc |> List.rev
    | hd::tl as l ->
      aux (prev @ [hd]) ((prev @ [x] @ l) :: acc) tl
  in aux [] [] lst

let rec permutations_insert lst =
  match lst with  
  | [] -> [[]]
  | hd ::tl -> List.fold_right (
    fun xs acc -> insert hd xs @ acc) (permutations_insert tl) []

(* Przez selekcje *)
let rec select lst =
  match lst with
  | [] -> []
  | x :: xs ->
    (x, xs) :: List.map (fun (y, ys) -> (y, x :: ys)) (select xs)

let rec permutations_select lst =
  match lst with
  | [] -> [[]]
  | _ ->
    List.concat_map (fun (x, rest) ->
      List.map (fun p -> x :: p) (permutations_select rest)
    ) (select lst)
