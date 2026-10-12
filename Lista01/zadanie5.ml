let rec tabulate ?(l=0) r s =
  if l = r then [s r]
  else s l :: tabulate ~l:(l + 1) r s

let rec print_list s =
  match s with 
  | [] -> print_endline ""
  | hd::tl -> (print_int hd; print_string ", "; print_list tl);;

(fun x -> 3 * x) |> tabulate ~l:2 8 |> print_list
