----------------------------- MODULE Four2 ---------------------------
EXTENDS Integers, TLC, FiniteSets, Four

Cadr(n) == Head(Tail(n))
Caddr(n) == Head(Tail(Tail(n)))

RECURSIVE Trips(_)
Trips(n) ==
  /\ IF n < 100 THEN FALSE
     ELSE
       IF Head(n) = Cadr(n) /\ Head(n) = Caddr(n) THEN TRUE
       ELSE Trips(Tail(n))

Spec2 == PrintT( Cardinality({x \in input: Desc(x) /\ Dups(x) /\ ~Trips(x) }) )
======================================================================
