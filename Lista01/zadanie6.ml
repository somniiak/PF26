let ctrue a b = a

let cfalse a b = b

let cand f1 f2 a b = f1 (f2 a b) b

let cor f1 f2 a b = f1 a (f2 a b)

let cbool_of_bool b = if b then ctrue else cfalse

let bool_of_cbool f = f true false

;; cand ctrue cfalse |> bool_of_cbool
;; cor cfalse cfalse |> bool_of_cbool
