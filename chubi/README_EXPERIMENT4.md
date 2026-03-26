\# Experiment 4: Stability Under Small Code Changes



\## Modification

A small semantics-preserving change was applied to the Gson codebase. Specifically, a local variable in `JavaVersion.java` was renamed from `num` to `digits`. This change does not affect program behavior, control flow, or data flow.



\## Results



| Metric | Before Change | After Change |

|--------|-------------|-------------|

| Total Issues | 14 | 14 |

| Thread Safety Violations | 14 | 14 |



\- Issues moved: No  

\- Issues disappeared: No  

\- New issues appeared: No  



\## Analysis



The results remained identical after the change. This demonstrates that Infer is stable under small, semantics-preserving modifications. Since Infer performs path-sensitive analysis, it reasons about execution behavior rather than syntactic structure.



Renaming a variable does not impact the execution paths or memory access patterns, so the detected issues remain unchanged.



\## Conclusion



This experiment shows that Infer is robust to superficial code changes. Its analysis is based on program semantics, not syntax, making it reliable across refactoring operations that do not alter behavior.

