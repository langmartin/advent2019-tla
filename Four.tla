----------------------------- MODULE Four ---------------------------
EXTENDS Integers, TLC, FiniteSets

Head(n) == n % 10
Tail(n) == n \div 10
Done(n) == n < 10

RECURSIVE Dups(_)
Dups(n) ==
  /\ IF Done(n) THEN FALSE
     ELSE
       IF Head(n) = Head(Tail(n)) THEN TRUE
       ELSE Dups(Tail(n))

RECURSIVE Desc(_)
Desc(n) ==
  /\ IF Done(n) THEN TRUE
     ELSE
       /\ Head(Tail(n)) <= Head(n)
       /\ Desc(Tail(n))

input == 152085..670283
Spec == PrintT( Cardinality({x \in input: Desc(x) /\ Dups(x)}) )
======================================================================
