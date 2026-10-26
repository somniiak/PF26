type formula =
  | Bot
  | Var of string
  | Imp of formula * formula

let rec string_of_formula f =
  match f with
  | Bot -> "⊥"
  | Var s -> s
  | Imp(l, r) ->
    let fl =
      match l with
      | Imp _ -> "(" ^ string_of_formula l ^ ")"
      | _ -> string_of_formula l
    in fl ^ " → " ^ string_of_formula r

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)

module FS = Set.Make (struct
  type t = formula
  let compare = compare
end)

type theorem = { hyps : FS.t; concl : formula }

let assumptions thm = FS.elements thm.hyps

let consequence thm = thm.concl

let pp_print_theorem fmtr thm =
  let open Format in
  pp_open_hvbox fmtr 2;
  begin match assumptions thm with
  | [] -> ()
  | f :: fs ->
    pp_print_formula fmtr f;
    fs |> List.iter (fun f ->
      pp_print_string fmtr ",";
      pp_print_space fmtr ();
      pp_print_formula fmtr f);
    pp_print_space fmtr ()
  end;
  pp_open_hbox fmtr ();
  pp_print_string fmtr "⊢";
  pp_print_space fmtr ();
  pp_print_formula fmtr (consequence thm);
  pp_close_box fmtr ();
  pp_close_box fmtr ()

let by_assumption f =
  { hyps = FS.singleton f; concl = f }

let imp_i f thm =
  { hyps = FS.remove f thm.hyps; concl = Imp(f, thm.concl) }

let imp_e th1 th2 =
  match th1.concl with
  | Imp(a, b) when a = th2.concl ->
    { hyps = FS.union th1.hyps th2.hyps; concl = b }
  | _ -> failwith "imp_e: wrong thesis"

let bot_e f thm =
  match thm.concl with
  | Bot ->
    { hyps = thm.hyps; concl = f }
  | _ -> failwith "bot_e: wrong thesis"

(*
open Logic;;
#install_printer Logic.pp_print_formula;;
#install_printer Logic.pp_print_theorem;;

let p = Var "p";;
let q = Var "q";;
let r = Var "r";;

let thm1 = imp_i p (by_assumption p);;

let thm2 = imp_i p (imp_i q (by_assumption p));;

let thm3 =
  let pqr = Imp (p, Imp (q, r)) in
  let pq = Imp (p, q) in
  let a = by_assumption pqr in            (* {pqr} ⊢ p → q → r *)
  let b = by_assumption pq in             (* {pq}  ⊢ p → q *)
  let c = by_assumption p in              (* {p}   ⊢ p *)
  let qr = imp_e a c in                   (* {pqr, p} ⊢ q → r *)
  let qq = imp_e b c in                   (* {pq, p}  ⊢ q *)
  let rr = imp_e qr qq in                 (* {pqr, p, pq} ⊢ r *)
  rr |> imp_i p |> imp_i pq |> imp_i pqr;;

let thm4 = imp_i Bot (bot_e p (by_assumption Bot));;
*)