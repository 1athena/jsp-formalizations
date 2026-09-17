# jsp-formalizations

Lean 4 formalizations submitted to [The Justin Sun Prize](https://github.com/TheJustinSunPrize/awards)
problem bank.

## JSP-000301 — consecutive powerful numbers

**Official question:** *If two consecutive positive integers are powerful, must at
least one be a perfect square?*

**Official status:** Solved (disproved) — 12167 = 23³ and 12168 = 2³·3²·13² are
consecutive powerful numbers and neither is a perfect square.

**File:** `JSP000301.lean`

**Main results**

- `JSP000301.Powerful n` — standard definition: every prime divisor `p` of `n`
  satisfies `p * p ∣ n`.
- `JSP000301.original_claim_is_false` — the exact negation of the catalogued
  question, i.e. a complete solution.
- `JSP000301.consecutive_powerful_neither_square` — explicit witness `n = 12167`.
- `JSP000301.isPrime_standard` — proves the computable primality predicate used
  for kernel reduction is equivalent to the textbook definition
  (`2 ≤ p` and no divisor `d` with `2 ≤ d < p`).

## Build

```sh
lean JSP000301.lean
```

Requires **Lean 4.33.0** (e.g. `conda install -c conda-forge lean4=4.33.0`).
**No mathlib dependency** — the file uses only Lean core + Init/Std.

## Trust

- Kernel-checked; no `sorry`, no `admit`.
- `#print axioms` reports only `[propext]` (Lean's standard propositional
  extensionality). No custom axioms.

## Attribution and AI disclosure

The mathematical content (the counterexample 12167 / 12168) is **pre-existing and
already recorded in the official Justin Sun Prize catalog**; no new mathematical
discovery is claimed here.

The contribution of this repository is the **complete machine-checked Lean
formalization**. It was produced with AI assistance (model-assisted proof
engineering) and independently validated by the Lean kernel. It contains no
vendored or third-party model output.
