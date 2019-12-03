----------------------------- MODULE Two -----------------------------
EXTENDS Integers, TLC

CONSTANTS input
VARIABLES tape, i, result

Calc(Code, Op(_, _)) ==
  /\ tape[i] = Code
  /\ tape' = [tape EXCEPT ![tape[i+3]] = Op(tape[i+1], tape[i+2])]
  /\ i' = i+4
  /\ UNCHANGED <<result>>

Add == Calc(1, LAMBDA x, y: x + y)
Mult == Calc(2, LAMBDA x, y: x * y)

Halt ==
  /\ tape[i] = 99
  /\ result' = tape[1]
  /\ UNCHANGED <<tape, i>>
    
Init ==
  /\ i = 1
  /\ result = -1
  /\ tape = input

Eval ==
  /\ result = -1
  /\ \/ Add
     \/ Mult
     \/ Halt

Next ==
  \/ result /= -1 /\ PrintT(result) /\ UNCHANGED <<tape, i, result>>
  \/ Eval

======================================================================
