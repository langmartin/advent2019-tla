----------------------------- MODULE One -----------------------------
EXTENDS Integers, Sequences, TLC

CONSTANTS modules

(* --algorithm sum
variable fuel = 0, i = Len(modules), ff = 0
begin

while i > 0 do
  ff := modules[i] \div 3 - 2;

  while ff > 0 do
    fuel := fuel + ff;
    ff := ff \div 3 - 2;
  end while;

  i := i - 1
end while;

print fuel;

end algorithm *)
\* BEGIN TRANSLATION
VARIABLES fuel, i, ff, pc

vars == << fuel, i, ff, pc >>

Init == (* Global variables *)
        /\ fuel = 0
        /\ i = Len(modules)
        /\ ff = 0
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF i > 0
               THEN /\ ff' = (modules[i] \div 3 - 2)
                    /\ pc' = "Lbl_2"
               ELSE /\ PrintT(fuel)
                    /\ pc' = "Done"
                    /\ ff' = ff
         /\ UNCHANGED << fuel, i >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF ff > 0
               THEN /\ fuel' = fuel + ff
                    /\ ff' = (ff \div 3 - 2)
                    /\ pc' = "Lbl_2"
                    /\ i' = i
               ELSE /\ i' = i - 1
                    /\ pc' = "Lbl_1"
                    /\ UNCHANGED << fuel, ff >>

Next == Lbl_1 \/ Lbl_2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

======================================================================
