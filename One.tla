----------------------------- MODULE One -----------------------------
EXTENDS Integers, Sequences, TLC

CONSTANTS modules

(* --algorithm sum
variable fuel = 0, i = Len(modules)
begin

while i > 0 do
  fuel := fuel + modules[i] \div 3 - 2;
  i := i - 1
end while;

print fuel;

end algorithm *)
\* BEGIN TRANSLATION
VARIABLES fuel, i, pc

vars == << fuel, i, pc >>

Init == (* Global variables *)
        /\ fuel = 0
        /\ i = Len(modules)
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF i > 0
               THEN /\ fuel' = (fuel + modules[i] \div 3 - 2)
                    /\ i' = i - 1
                    /\ pc' = "Lbl_1"
               ELSE /\ PrintT(fuel)
                    /\ pc' = "Done"
                    /\ UNCHANGED << fuel, i >>

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

======================================================================
