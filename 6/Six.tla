----------------------------- MODULE Six -----------------------------
EXTENDS Integers, TLC, FiniteSets
CONSTANT puzzle
VARIABLES implicits

EdgeOut(e) == {g \in puzzle: e.to = g.id}

MakeEdges(e, g) == {g, [id |-> e.id, to |-> g.id], [id |-> e.id, to |-> g.to]}

RECURSIVE ImplicitR(_)
ImplicitR(e) ==
  UNION {MakeEdges(e, g): g \in
    EdgeOut(e)
      \union
        UNION {ImplicitR(h): h \in EdgeOut(e)}}

----------------------------------------------------------------------

Roots == {e \in puzzle: e.id = "COM"}
Start == UNION {EdgeOut(e): e \in Roots}
More == UNION {EdgeOut(e): e \in Start}

Init ==
  /\ implicits = {}

Next ==
  /\ implicits' = UNION {ImplicitR(e): e \in Roots} \ puzzle
  /\ PrintT(Cardinality(implicits' \union puzzle))
======================================================================
