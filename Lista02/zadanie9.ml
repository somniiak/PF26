type 'a clist = { clist : 'z. ('a -> 'z -> 'z) -> 'z -> 'z }

(* lista pusta *)
let cnil =
  { clist = fun _ z -> z }

(* dołączanie głowy do listy *)
let ccons (x : 'a) (l : 'a clist) : 'a clist =
  { clist = fun f z -> f x (l.clist f z)}

(* nakładania podanej funkcji na wszystkie wartości listy *)
let map (g : 'a -> 'b) (l : 'a clist) : 'b clist =
  { clist = fun f z -> l.clist (fun x acc -> f (g x) acc) z }

(* konkatenacja list *)
let append (l1 : 'a clist) (l2 : 'a clist) : 'a clist =
  { clist = fun f z -> l1.clist f (l2.clist f z) }

(* lista Churcha do standardowej listy *)
let clist_to_list (l : 'a clist) :  'a list =
  l.clist (fun x acc -> x :: acc) []

(* standardowa lista do listy Churcha *)
let rec clist_of_list (l : 'a list) : 'a clist =
  match l with
  | [] -> cnil
  | hd :: tl -> ccons hd (clist_of_list tl)

let prod (l1 : 'a clist) (l2 : 'b clist) : ('a * 'b) clist =
  { clist = fun f z -> l1.clist (fun a acc1 -> l2.clist (fun b acc2 -> f (a, b) acc2) acc1) z }
