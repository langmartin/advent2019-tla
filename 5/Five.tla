----------------------------- MODULE Five -----------------------------
EXTENDS Integers, TLC
CONSTANT tapeInit, input
VARIABLES tape, i, fin

Nth(j, ns) == (ns % 10^j) \div 10^(j-1)

Opcode  == tape[i] % 100
Mode(j) == Nth(j+2, tape[i])

Param(j) ==
  IF Mode(j) = 0 THEN
    tape[tape[i+j] + 1]
  ELSE
    tape[i+j]

Op2(code, op(_, _)) ==
  /\ Opcode = code
  /\ tape' = [tape EXCEPT ![tape[i+3]+1] = op(Param(1), Param(2))]
  /\ i' = i + 4
  /\ UNCHANGED <<fin>>

Add  == Op2(1, LAMBDA x,y: x+y)
Mult == Op2(2, LAMBDA x,y: x*y)

Input ==
  /\ Opcode = 3
  /\ tape' = [tape EXCEPT ![tape[i+1]+1] = input]
  /\ i' = i + 2
  /\ UNCHANGED <<fin>>

Output ==
  /\ Opcode = 4
  /\ PrintT(Param(1))
  /\ i' = i + 2
  /\ UNCHANGED <<tape, fin>>

Halt ==
  /\ Opcode = 99
  /\ fin' = TRUE
  /\ UNCHANGED <<tape, i>>

Eval ==
  IF fin THEN UNCHANGED <<tape, i, fin>> ELSE
  \/ Add \/ Mult \/ Input \/ Output \/ Halt

----------------------------------------------------------------------

Init ==
  /\ tape = tapeInit
  /\ i = 1
  /\ fin = FALSE

Next == /\ Eval

======================================================================
