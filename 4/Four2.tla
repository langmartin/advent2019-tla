----------------------------- MODULE Four2 ---------------------------
EXTENDS Integers, TLC, FiniteSets, Four

Cddr(n) == Tail(Tail(n))
Cadr(n) == Head(Tail(n))
Caddr(n) == Head(Tail(Tail(n)))

RECURSIVE JustDups(_, _)
JustDups(skip, ns) ==
  CASE Done(ns) -> FALSE
    [] Head(ns) = skip -> JustDups(skip, Tail(ns))
    [] Head(ns) = Cadr(ns) /\ Head(ns) = Caddr(ns) -> JustDups(Head(ns), Cddr(ns))
    [] Head(ns) = Cadr(ns) -> TRUE
    [] OTHER -> JustDups(-1, Tail(ns))

Spec2 == PrintT( Cardinality({x \in input: Desc(x) /\ JustDups(-1, x) }) )
======================================================================
