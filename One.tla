----------------------------- MODULE One -----------------------------
EXTENDS Integers

CONSTANTS modules
VARIABLES results

Fuel(mod) ==
  (* /\ results' = results \cup {[m -> mod, f -> (mod \div 3) - 2]} *)
  results' = results \cup {(mod \div 3) -2}

(* Init ==
  results = [modules |-> 0] *)

Init ==
  results = {}

Next ==
  \E m \in modules: Fuel(m)

======================================================================