### Zadanie 1

Wyrażenie `fun x -> x` ma typ `'a -> 'a`. Funkcja identycznościowa typu
`int -> int` to np. `fun x -> x + x - x` (bo zwraca to samo a używa przy tym
operatorów dla liczb całkowitych).

* `(’a -> ’b) -> (’c -> ’a) -> ’c -> ’b` \
np. `let compose f g x = f (g x)`

* `’a -> ’b -> ’a` \
np. `let nothing x y = x`
np. `fun x -> (fun _ -> x)`

* `’a -> ’a -> ’a` \
np. `fun x y -> if true then x else y;;`

* `'a` \
np. `let x = assert false`
np. `failwith ""`
