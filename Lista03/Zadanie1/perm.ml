module type OrderedType = sig
  type t
  val compare : t -> t -> int
end

module type S = sig
  type key
  type t
  (** permutacja jako funkcja *)
  val apply : t -> key -> key
  (** permutacja identycznościowa *)
  val id : t
  (** permutacja odwrotna *)
  val invert : t -> t
  (** permutacja która tylko zamienia dwa elementy miejscami *)
  val swap : key -> key -> t
  (** złożenie permutacji (jako złożenie funkcji) *)
  val compose : t -> t -> t
  (** porównywanie permutacji *)
  val compare : t -> t -> int
end

module Make (Key : OrderedType) : (S with type key = Key.t) = struct
  type key = Key.t

  module M = Map.Make(Key)

  type t =
    { f : key M.t; inv : key M.t }

  let apply p x =
    match M.find_opt x p.f with
    | None -> x
    | Some(y) -> y

  let id =
    { f = M.empty; inv = M.empty}

  let invert p =
    { f = p.inv; inv = p.f }

  let swap a b =
    if Key.compare a b = 0 then id
    else let m = M.empty |> M.add a b |> M.add b a in
    { f = m; inv = m }

  let compose p q =
    let comp f g =
      M.merge (fun x _ _ ->
        let y = apply f (apply g x) in
        if Key.compare x y = 0 then None else Some(y)
      ) g.f f.f
    in { f = comp p q; inv = comp (invert q) (invert p)}

  let compare p q =
    M.compare Key.compare p.f q.f
end