1. `let x = x in x ^ x` \
`x` związana

2. `let x = 10. in let y = x ** 2. in y *. x` \
`x` związana, `y` związana

3. `let x = 1 and y = x in x + y` \
`x` wolna, `y` związana

4. `let x = 1 in fun y z -> x * y * z` \
`x` związana, `y` związana, `z` związana