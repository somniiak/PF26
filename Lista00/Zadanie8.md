### Rodzaje ewaluacji
- **Gorliwa (eager)** - argumenty funkcji są obliczane od razu, zanim funkcja zostanie wywołana.
- **Leniwa (lazy)** - argument jest obliczany dopiero wtedy, gdy jego wartość jest potrzebna.

### Przykład gorliwości w OCamlu
`(fun x -> 42) (1 / 0);;` - argument w tej funkcji nie jest potrzebny bo wynikiem jest zawsze 42. Używając ewaluacji leniwej dostaniemy poprawny wynik od razu, bo nic nie trzeba liczyć. Ewaluując gorliwie najpierw obliczamy argument co w tym przypadku wyrzuci błąd.