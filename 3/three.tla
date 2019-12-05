----------------------------- MODULE Three ---------------------------

----------------------------- MODULE A ---------------------------
EXTENDS Sequences

CONSTANT wire1, wire2

(* --algorithm manhattan
variable pts1 = {}, pts2 = {}, i = 0, x = 0, y = 0, pts = {}, wire
begin

	       wire := wire1;

	       while i < Len(wire) do

	       if wire[i].o = "U" then
	       x := x + 1;
	       elsif wire[i].o = "D" then
	       x := x - 1;
	       elsif wire[i].o = "L" then
	       y := y - 1;
	       elsif wire[i].o = "R" then
	       y := y + 1;
	       end if;

	       pts := pts \union {["x"|->x, "y"|->y]};
	       end while;

	       pts1 := pts

end algorithm; *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES pts1, pts2, i, x, y, pts, wire, pc

vars == << pts1, pts2, i, x, y, pts, wire, pc >>

Init == (* Global variables *)
        /\ pts1 = {}
        /\ pts2 = {}
        /\ i = 0
        /\ x = 0
        /\ y = 0
        /\ pts = {}
        /\ wire = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ wire' = wire1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << pts1, pts2, i, x, y, pts >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF i < Len(wire)
               THEN /\ IF wire[i].o = "U"
                          THEN /\ x' = x + 1
                               /\ y' = y
                          ELSE /\ IF wire[i].o = "D"
                                     THEN /\ x' = x - 1
                                          /\ y' = y
                                     ELSE /\ IF wire[i].o = "L"
                                                THEN /\ y' = y - 1
                                                ELSE /\ IF wire[i].o = "R"
                                                           THEN /\ y' = y + 1
                                                           ELSE /\ TRUE
                                                                /\ y' = y
                                          /\ x' = x
                    /\ pts' = (pts \union {["x"|->x', "y"|->y']})
                    /\ pc' = "Lbl_2"
                    /\ pts1' = pts1
               ELSE /\ pts1' = pts
                    /\ pc' = "Done"
                    /\ UNCHANGED << x, y, pts >>
         /\ UNCHANGED << pts2, i, wire >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

==================================================================



======================================================================
