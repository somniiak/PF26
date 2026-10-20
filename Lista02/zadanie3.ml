let rec suffix xs =
  match xs with
  | [] -> [[]]
  | hd :: tl ->
    xs :: (suffix tl)

let rec prefix xs =
  match xs with
  | [] -> [[]]
  | hd :: tl ->
    let p = prefix tl in
    [] :: List.map (fun l -> hd :: l) p
