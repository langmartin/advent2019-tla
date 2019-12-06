----------------------------- MODULE Five2 -----------------------------
EXTENDS Five

Jump(code, test(_)) ==
  /\ Opcode = code
  /\ IF test(Param(1)) THEN i' = Param(2) + 1 ELSE i' = i + 3
  /\ UNCHANGED <<tape, fin>>

JumpT == Jump(5, LAMBDA x: x /= 0)
JumpF == Jump(6, LAMBDA x: x = 0)
Less  == Op2(7, LAMBDA x,y: IF x<y THEN 1 ELSE 0)
Equal == Op2(8, LAMBDA x,y: IF x=y THEN 1 ELSE 0)

Eval2 ==
  IF fin THEN UNCHANGED <<tape, i, fin>> ELSE
  \/ Add \/ Mult \/ Input \/ Output
  \/ JumpT \/ JumpF \/ Less \/ Equal
  \/ Halt

Next2 == Eval2
======================================================================
