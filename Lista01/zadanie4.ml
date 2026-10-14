let scan f a s =
  let rec it n =
    if n = 0 then f a (s n)
    else f (it (n - 1)) (s n)
  in it