----------------------------- MODULE Two -----------------------------
EXTENDS Integers

CONSTANTS tape
VARIABLES i, halt

R(j) == tape[j+3]

Calc(Code, Op(_, _)) ==
  /\ tape[i] = Code
  /\ tape[R(i)]' = Op(tape[i+1], tape[i+2])
  /\ i' = i+4
  /\ UNCHANGED <<halt>>

Add == Calc(1, LAMBDA x, y: x + y)
Mult == Calc(2, LAMBDA x, y: x * y)

Halt ==
  /\ tape[i] = 99
  /\ halt' = 1
    
Init ==
  /\ i = 1
  /\ halt = 0

Next ==
  /\ halt = 0
    \/ Add \/ Mult \/ Halt

======================================================================
