**ocamlc** - ocaml bytecode \
**ocamlopt** - kod maszynowy

### ocamlc
```shell
ocamlc -o fib-ocamlc fib.ml
time sh -c "./fib-ocamlc 42"

267914296

real    0m6.921s
user    0m6.896s
sys     0m0.005s
```

### ocamlopt
```shell
ocamlopt -o fib-ocamlopt fib.ml
time sh -c "./fib-ocamlopt 42"

267914296

real    0m0.934s
user    0m0.930s
sys     0m0.002s
```
