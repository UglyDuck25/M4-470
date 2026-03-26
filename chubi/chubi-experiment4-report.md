\# Experiment 4: Stability Under Small Code Changes

\*\*Chibuikem Emeka-Nwuba\*\*



\## Method Selected

extractBeginningInt() in JavaVersion.java



\## Change Made

A semanticsvariable rename was made.

The local variable 'num' was renamed to 'digits'.

This change does not affect program behavior in any way.



Before:

&#x20; StringBuilder num = new StringBuilder();

&#x20; num.append(c);

&#x20; return Integer.parseInt(num.toString());



After:

&#x20; StringBuilder digits = new StringBuilder();

&#x20; digits.append(c);

&#x20; return Integer.parseInt(digits.toString());



\## Results



| Metric | Before | After |

|--------|--------|-------|

| Total Issues | 15 | 15 |

| NULL\_DEREFERENCE | 1 | 1 |

| THREAD\_SAFETY\_VIOLATION | 14 | 14 |

| Issues moved? | — | No |

| Issues disappeared? | — | No |

| New issues appeared? | — | No |



\## Analysis

The results were identical before and after the change. Infer reported 

the same 15 issues in the same files at the same line numbers.



This demonstrates that Infer's path-sensitive analysis is stable under 

semantics-preserving code changes. Unlike pattern-based tools such as 

Semgrep which match syntactic patterns, Infer reasons about program 

behavior and data flow. Renaming a variable does not change the execution 

path or data flow, so Infer's findings remain unchanged.



This stability is an important property for a static analysis tool — 

engineers can refactor code without fear of introducing false positives 

or losing existing findings.

