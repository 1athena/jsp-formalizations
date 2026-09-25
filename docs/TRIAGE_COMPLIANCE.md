# JSP-000301 · Triage compliance record

Submission: PR **TheJustinSunPrize/awards#844** (Lean formalization intake)
Proof repository: **https://github.com/1athena/jsp-formalizations**
Pinned proof commit: **`39b85298cffb83fb07423216e741550e90470c09`** (40 hex)
Award-claim issue: **TheJustinSunPrize/awards#1709** (Lean formalization only)
Record last updated: 2026-09-25

This file answers, point by point, the re-submission conditions published by the
triage maintainer in `TheJustinSunPrize/awards#32` (2026-09-21, "Rejected: Identity &
Attribution Mismatch") and the requirements of `docs/attribution.md`,
`docs/award-process.md` and PR #4440. It is evidence only; no claim of priority is made.

---

## 1. Repository ownership and independence (§4.1, Gordon Triage Rule 2)

| Requirement | This submission |
| --- | --- |
| Formalization must reside in a dedicated, self-contained public repository **owned by the submitter** | `1athena/jsp-formalizations`, created **2026-09-17T17:41:56Z**, is a **standalone repository, not a fork** |
| No dynamic third-party fetching / unvendored dependencies | The proof imports only the Lean core / `Init` / `Std` prelude. **No mathlib, no `plby/lean-proofs`, no external repo is fetched or referenced at build time** |
| Third-party formalization code prohibited | **Zero third-party code.** Every definition and theorem in `JSP000301.lean` was written for this submission |
| No proxy scraping / packaging of unowned repositories | None. The submitter is the repository owner and the sole committer |

The fork `1athena/awards` is used only to carry the one-line catalog metadata change
required by the intake PR; it contains no proof code.

## 2. Attribution: solver vs formalizer (PR #4440, §2.1–§2.3)

* **Mathematical solution (not claimed here):** Solomon W. Golomb, "Powerful numbers",
  *Amer. Math. Monthly* **77**(8) (1970), 848–852, DOI [10.2307/2317020](https://doi.org/10.2307/2317020).
  The catalog entry itself records the disproof: `12167 = 23^3`, `12168 = 2^3 · 3^2 · 13^2`.
* **Lean formalization (claimed):** `1athena`. This is the only role claimed in issue #1709.
* Machine-readable version: [`sources.yaml`](../sources.yaml) in this repository, which binds
  account ↔ pinned SHA ↔ theorem names ↔ role ↔ "no third-party code" ↔ AI disclosure.
* Claim-issue status columns are left to maintainers; this submission does not self-mark them.

## 3. Constraint fidelity (Gordon Triage Rule 5 — no scope reduction)

The Lean file proves the **exact negation of the catalogued question**, not a special case:

* `consecutive_powerful_neither_square` — 12167 and 12168 are consecutive, both powerful,
  neither is a perfect square;
* `original_claim_is_false` — therefore the catalogued implication ("at least one of two
  consecutive powerful integers is a perfect square") is false.

Definitions are not weakened to make the proof easier: `IsPrime` is a computable `Bool`
predicate and `isPrime_standard` **proves** its equivalence with the standard
`2 ≤ p ∧ ∀ m, m ∣ p → m = 1 ∨ m = p` definition rather than asserting it.

## 4. Diff shape (§4.1: "only catalog link updates, no `.lean` source files in diff")

PR #844 changes exactly **one file**: `problems/catalog-0301-0400.md`, **+1 / −1**,
setting the `Lean proof` row to the repository URL + branch + the 40-digit SHA above.
No `.lean` file, no binary, no source code is added to the awards repository.
`Eligible to claim`, `Proof contributors` and the README index are left to maintainers.

## 5. Axioms and kernel replay (standard 3 axioms: `propext`, `Classical.choice`, `Quot.sound`)

Re-verified on **2026-09-25** with the pinned toolchain Lean **4.33.0** against the exact
pinned commit:

```
$ lean -o JSP000301.olean JSP000301.lean
'JSP000301.consecutive_powerful_neither_square' depends on axioms: [propext]
'JSP000301.original_claim_is_false'             depends on axioms: [propext]
```

* Axioms used: **`propext` only** — a strict subset of the three permitted axioms.
* No `Classical.choice` beyond the prelude's own use is introduced by this file; no
  `Quot.sound`, no custom axiom.
* **No** `native_decide`, `implemented_by`, `extern`, `unsafe`, `sorry`, `admit`.
* Build exits 0 and produces `JSP000301.olean`; there are no unsolved goals or warnings.

Earlier pre-submission self-check (repository `skills/lean-verify`) is archived under
`verification/JSP-000301/` (commit `8016360851ab…`).

## 6. Identity / claimant

* PR author, repository owner and award-claim issuer are the **same GitHub account**
  (`1athena`); no proxy, no agent filing on another person's behalf.
* Public contact email declared in issue #1709: `994578847@qq.com`.
* **Outstanding, human-only:** the off-chain identity email step required by
  `docs/attribution.md` ("every applicant, including Lean-only… existing source
  attribution does not waive this step") has **not** been completed by the account owner.
  It is recorded as pending rather than asserted as done.

## 7. AI assistance disclosure

The formalization was produced with AI assistance (WorkBuddy / LLM tooling) under the
direction of the account owner. This is disclosed in PR #844 and in issue #1709.
