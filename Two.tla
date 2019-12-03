----------------------------- MODULE Two -----------------------------
EXTENDS Integers, TLC

CONSTANTS input, index
VARIABLES tape, i, result

\* input is 0 indexed, so we have to add 1 to destination position
Calc(Code, Op(_, _)) ==
  /\ tape[i] = Code
  /\ tape' = [tape EXCEPT ![tape[i+3]+1] = Op(tape[tape[i+1]+1], tape[tape[i+2]+1])]
  /\ i' = i+4
  /\ UNCHANGED <<result>>

Add == Calc(1, LAMBDA x, y: x + y)
Mult == Calc(2, LAMBDA x, y: x * y)

Halt ==
  /\ tape[i] = 99
  /\ result' = tape[index]
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
