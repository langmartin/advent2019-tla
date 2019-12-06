----------------------------- MODULE Five -----------------------------
EXTENDS Integers, TLC
CONSTANT tapeInit, input
VARIABLES tape, i, fin

Opcode == tape[i] % 100
Mode(code, j) == code \div ((10 * j) * 100)

Param(j) ==
  IF Mode(tape[i], j) = 0 THEN
    tape[i+j] + 1
  ELSE
    i+j+1

Op2(code, op(_, _)) ==
  /\ Opcode = code
  /\ tape' = [tape EXCEPT ![Param(3)] = op(Param(1), Param(2))]
  /\ i' = i + 4
  /\ UNCHANGED <<fin>>

Add  == Op2(1, LAMBDA x,y: x+y)
Mult == Op2(2, LAMBDA x,y: x+y)

Input ==
  /\ Opcode = 3
  /\ tape' = [tape EXCEPT ![Param(1)] = input]
  /\ i' = i + 2
  /\ UNCHANGED <<fin>>

Output ==
  /\ Opcode = 4
  /\ PrintT(Param(1))
  /\ i' = i + 2
  /\ UNCHANGED <<tape, fin>>

Halt ==
  /\ tape[i] = 99
  /\ fin' = TRUE
  /\ UNCHANGED <<tape, i>>

Eval ==
  /\ ~fin
  /\ \/ Add \/ Mult \/ Input \/ Output

----------------------------------------------------------------------

Init ==
  /\ tape = tapeInit
  /\ i = 1
  /\ fin = FALSE

Next == /\ Eval

======================================================================
