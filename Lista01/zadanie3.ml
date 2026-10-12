(* Head - pierwszy element*)
let hd s = s 0

(*Tail - ogon, strumień bez pierwszego elementu*)
let tl s =
  fun n -> s (n + 1)

(*Add - każdy element większy o zadaną stałą*)
let add c s =
  fun n -> s n + c

(*Map - funkcja zaaplikowana do każdego elementu*)
let map f s =
  fun n -> f (s n)

(*Map2 - funkcja dwuargumentowa biorąca dwa strumienie*)
let map2 f s1 s2 =
  fun x -> let a = s1 x and b = s2 x in f a b

(*Replace - zwraca strumień w którym wartości są takie same
oprócz n-tego elementu, który ma wartość a*)
let replace n a s =
  fun x -> if x = n then a else s x

(*Take_every - tworzy nowy strumień złożony z co n-tego
elementu strumienia s*)
let take_every n s =
  fun x -> s (x * n)


let rec print_list s =
  match s with 
  | [] -> print_endline ""
  | hd::tl ->
      (print_int hd; print_string ", "; print_list tl)


let s1 x = x + 1;;
s1 |> List.init 5 |> print_list;;
s1 |> add 5 |> List.init 5 |> print_list;;
s1 |> map (fun x -> x * 5)|> List.init 5 |> print_list;;
s1 |> replace 3 67 |> List.init 5 |> print_list;;

let s2 x = x * x;;
s2 |> List.init 5 |> print_list;;
s2 |> add 7 |> List.init 5 |> print_list;;
s2 |> take_every 2 |> List.init 5 |> print_list;;
map2 (+) s1 s2 |> List.init 5 |> print_list;;
