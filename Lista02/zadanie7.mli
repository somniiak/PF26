type 'a heap =  private
  | Leaf
  | Node of 'a * int * 'a heap * 'a heap

val empty : 'a heap

val spine : 'a heap -> int

val merge : 'a heap -> 'a heap -> 'a heap

val insert : 'a -> 'a heap -> 'a heap

val delete_min : 'a heap -> 'a heap
