# Vendored dependency and the patches applied to it

## Dependency

`Erdos548_192usd_21h.lean` is vendored verbatim from

* upstream: <https://github.com/tadamcz/erdos548>
* pinned commit: `82ffb751f3d37768927df9239ed08439bbe0dd09`
* author / formalization author: **Tom Adamczewski**
* licence: Apache-2.0 (upstream `LICENSE` and `NOTICE` retained in spirit; the
  provenance directory of the upstream repository records the authorship)
* role: proves `Erdos548.erdos_548`, the Erdős–Sós theorem (Erdős problem 548),
  which is the tree-embedding result referenced as JSP-000439 in the official
  catalog entry of JSP-000448.

The file is included **unmodified except** for the three mechanical
API-drift fixes listed below. No mathematical content, no statement and no
proof step was altered. All three fixes are pure adaptations to newer mathlib
/ Lean versions; they do not weaken any hypothesis or strengthen any
conclusion.

## Patches (Lean 4.35.0-rc2 + mathlib `44ba35c6daa9d69aff8fed9fff9bbde17ded774d`)

1. **`Erdos548_192usd_21h.lean:466`** — `Nat.factorial_succ` goal was discharged
   with `simpa only [...]`, which no longer normalises the `nsmul`/`Nat.cast`
   shape produced by `Finset.sum_const` + `nsmul_eq_mul`.
   Fix: `simpa [Nat.sub_add_cancel hn] using (Nat.factorial_succ (l₀.length - 1)).symm`.

2. **`Erdos548_192usd_21h.lean:598-599`** — `SimpleGraph.symm` changed from a
   bare `Symmetric Adj` proof to `Std.Symm Adj` (a structure), and
   `loopless` to `Std.Irrefl Adj`.
   Fix: `symm := ⟨by rintro (a | a) (b | b) h <;> first | exact h.symm | exact h⟩`,
   `loopless := by aesop_graph` (identical to the mathlib default).

3. **`Erdos548_192usd_21h.lean:855`** — `isBridge_iff` now states
   `G.IsBridge s(u,v) ↔ ¬ (G.deleteEdges {s(u,v)}).Reachable u v` (an `Iff`
   whose RHS is a negation), instead of returning a conjunction.
   Fix: dropped the trailing `.2` projection.

With these three changes the vendored file elaborates with **0 errors** under
Lean 4.35.0-rc2.
