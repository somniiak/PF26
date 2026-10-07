```ocaml
let m = 10;;
let f x = m + x;;
let m = 100;;

f 1;;
- : int = 11
```

Funkcja zwraca 11, bo używamy tu domknięcia funkcji (closure).
Funkcja w swojej definicji ma zapisane dodanie wartości 10.
