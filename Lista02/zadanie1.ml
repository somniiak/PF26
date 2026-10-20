(* https://ocaml.org/manual/5.2/api/List.html *)

(* Return the length (number of elements) of the given list. *)
let length xs =
  List.fold_left (fun acc x -> acc + 1) 0 xs

(* List reversal. *)
let rev xs =
  List.fold_left (fun acc x -> x :: acc) [] xs

(* Applies function f to x1, ..., xn, and builds the list [f x1; ...; f xn] *)
let map f xs =
  List.fold_right (fun x acc -> (f x) :: acc) xs []

(* Appends ys to xs. Same function as the infix operator @. *)
let append xs ys =
  List.fold_right (fun x acc -> x :: acc) xs ys

(* Reverses xs and concatenates it with ys. This is equivalent to (List.rev xs) @ ys. *)
let rev_append xs ys =
  List.fold_left (fun acc x -> x :: acc) ys xs

(* Returns all the elements of the list xs that satisfy the predicate f *)
let filter f xs =
  List.fold_right (fun x acc -> if f x then x :: acc else acc) xs []

(* Gives the same result as List.rev (List.map f xs), but is more efficient. *)
let rev_map f xs =
  List.fold_left (fun acc x -> (f x) :: acc) [] xs
