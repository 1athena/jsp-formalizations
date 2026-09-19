# Lean pre-submission verification report — JSP-000301

**Overall verdict: Verification passed (`验证通过`).**

At the pinned proof commit `39b85298cffb83fb07423216e741550e90470c09` of
`1athena/jsp-formalizations`, the submitted Lean proof **completely settles the
original problem** recorded as JSP-000301 (Erdős problem #365): it proves the
exact negation of the catalogued yes/no question, the formal predicates provably
coincide with the textbook notions restated independently from the problem
source, the clean build and kernel replay succeed at the pinned toolchain
`leanprover/lean4:v4.33.0`, and the only axiom dependency is the standard
`propext`.

This is a contributor self-check performed with the awards repository's
bundled `lean-verify` skill. It is submitter-provided evidence, not independent
certification.

---

## 1. Direct answers

1. **Is the proved statement the specified original problem? — Yes.**
   The catalogued record asks whether two consecutive *powerful* positive
   integers must include a perfect square, and records the answer as a disproof
   by the witness 12167 = 23³, 12168 = 2³·3²·13². The formal target
   `JSP000301.original_claim_is_false` is the literal negation
   `¬ (∀ n : Nat, 0 < n → Powerful n → Powerful (n+1) → IsSquare n ∨ IsSquare (n+1))`,
   with `Powerful n := ∀ p, IsPrime p → p ∣ n → p*p ∣ n` and
   `IsSquare n := ∃ k, k*k = n`. Quantifier structure, antecedents and the
   disjunctive conclusion are unchanged. The submitted computable primality
   predicate is proved equivalent to the textbook definition by
   `JSP000301.isPrime_standard`, so no definition is weakened. The independent
   bridge file proves `StdPrime ↔ JSP000301.IsPrime`, `StdPowerful ↔ JSP000301.Powerful`
   and `StdSquare ↔ JSP000301.IsSquare` (the last by `rfl`), then discharges the
   restated intended statement from the submitted theorem.

2. **Does the specified commit actually verify? — Yes.**
   `lake build +JSP000301` and `lake build +AuditBridge` both succeed from a clean
   checkout at the pinned commit with the pinned toolchain; the submission was
   additionally replayed by the kernel (`Replayed JSP000301`) and re-checked with
   `lean --trust=0`. Axiom audit: `propext` only — no `sorryAx`, no `admit`,
   no custom axiom.

3. **Does it completely solve the original problem? — Yes.**
   The original question is yes/no; a complete refutation is a complete solution.
   `consecutive_powerful_neither_square` exhibits the explicit witness `n = 12167`
   satisfying all four required conjuncts (`0 < n`, `Powerful n`, `Powerful (n+1)`,
   neither is a square), and `original_claim_is_false` derives the negation of the
   universal claim from it. No sub-case, proof step or additional assumption is
   missing.

4. **Does it meet this verification's Lean completeness requirements? — Yes.**
   All necessary mechanical checks pass with full coverage of the single problem
   and single proof version: clean build, explicit per-target build, axiom audit,
   kernel replay, and an independently restated statement bridge.

**Verification levels completed:** static review ▸ actual Lean checks ▸ kernel
replay (lake replay of the target module and `lean --trust=0` re-elaboration) ▸
independent challenge-style bridge (`AuditBridge.intended_statement_is_false`
re-derives the intended statement from the submitted theorem).

**Trust dependencies:** `propext` only (standard classical Lean foundation, plus
the Lean kernel itself). The finite primality/divisibility/square checks are
closed by kernel reduction (`by decide` on `Bool` equality), **not** by
`native_decide`, external `implemented_by`, `extern`, or any unsafe mechanism;
`debug.skipKernelTC` does not appear. No mathlib or third-party dependency exists,
so there is no dependency-SHA surface to trust.

**Limitations:** the original repository has no Lake project (a single-file,
dependency-free proof). A minimal `lakefile.toml` / `lake-manifest.json` was added
**only inside the isolated audit copy** to let the audit helper address modules by
name; the submitted proof commit itself is byte-for-byte unmodified
(`JSP000301.lean` sha256 `d003ef1cc20b9560177050837275faa15b957cb6f7126e851ea21ae8c336dacf`).
Maintainer-side statement review, reproduction, mathematical-solution review and
solver-candidate registration are independent steps not decided here.

---

## 2. Fixed inputs

| Item | Value |
| --- | --- |
| Problem | JSP-000301, Erdős problem #365 (<https://www.erdosproblems.com/365>) |
| Catalog entry | `problems/catalog-0301-0400.md` (section `JSP-000301`) |
| Proof repository | <https://github.com/1athena/jsp-formalizations> |
| Branch containing the commit | `main` |
| Proof commit (verification target) | `39b85298cffb83fb07423216e741550e90470c09` |
| Proof entry | `JSP000301.lean` (statement and proof in one file) |
| Target theorem | `JSP000301.original_claim_is_false` |
| Companion witness theorem | `JSP000301.consecutive_powerful_neither_square` |
| Independent bridge | `AuditBridge.lean` → `AuditBridge.intended_statement_is_false` |
| Toolchain | `leanprover/lean4:v4.33.0` (declared in `/lean-toolchain` at the commit) |
| Local Lean | Lean 4.33.0, arm64-apple-darwin20.0.0, Release |
| Dependencies | none (Lean 4 core + Init/Std only; no mathlib, no manifest) |
| Verification date | 2026-09-19 (UTC 11:04–11:12) |
| `lean-verify` skill version | awards commit `54a55f6ad1528fc38f76b94e31e5c2296d696e68` |

Source provenance: the isolated project was produced by `git clone` of the proof
repository followed by `git checkout 39b85298cffb83fb07423216e741550e90470c09`;
`git rev-parse HEAD` returned exactly that SHA. The retrieved
`JSP000301.lean` is identical to the file present at that commit.

Isolation: all work ran under `/tmp/lv844/` (system temporary directory), outside
the user's working tree. `git status` at audit time listed only the three
audit-only additions (`AuditBridge.lean`, `lakefile.toml`, `lake-manifest.json`);
no committed file was modified.

## 3. Requirement coverage

The original problem imposes exactly one requirement, and it is fully covered:

| Requirement | Formal target | Coverage |
| --- | --- | --- |
| Settle the yes/no question for all positive integers with the catalogued definitions | `JSP000301.original_claim_is_false` (+ `AuditBridge.intended_statement_is_false`) | complete — proved for the whole quantified statement |
| Exhibit the refuting witness 12167 / 12168 | `JSP000301.consecutive_powerful_neither_square` | complete — all four conjuncts proved |

## 4. Commands, exit codes and evidence

Run inside `/tmp/lv844/project` with `LEAN_PATH` and `PATH` pointing at the
pinned Lean 4.33.0 toolchain.

| # | Command | Exit | Result |
| --- | --- | --- | --- |
| 1 | `lean -o JSP000301.olean JSP000301.lean` | 0 | clean build; axioms `[propext]` |
| 2 | `lean --trust=0 JSP000301.lean` | 0 | kernel re-check; axioms `[propext]` |
| 3 | `LEAN_PATH=. lean AuditBridge.lean` | 0 | bridge builds; axioms `[propext]` |
| 4 | `LEAN_PATH=. lean --trust=0 AuditBridge.lean` | 0 | kernel re-check; axioms `[propext]` |
| 5 | `python3 audit.py preflight --out evidence/preflight3.json targets.json` | 0 | `ready_for_target_checks: true`, `issues: []`, `head` = pinned SHA |
| 6 | `python3 audit.py run --out evidence/run3.json --lake <abs lake> targets.json` | 0 | `mechanical_status: standard_axioms_only` |

Axiom audit output (verbatim):

```text
'JSP000301.consecutive_powerful_neither_square' depends on axioms: [propext]
'JSP000301.original_claim_is_false' depends on axioms: [propext]
'AuditBridge.intended_statement_is_false' depends on axioms: [propext]
'AuditBridge.prime_bridge' depends on axioms: [propext]
'AuditBridge.powerful_bridge' depends on axioms: [propext]
```

Target-level result from the audit helper:

```text
mechanical_status = standard_axioms_only   (exit_code 0)
main     -> standard_axioms_only  ['propext']
witness  -> standard_axioms_only  ['propext']
bridge   -> standard_axioms_only  ['propext']
```

Artifacts preserved locally: `targets.json` (target manifest), `report.md`,
`evidence/preflight3.json/` and `evidence/run3.json/` (build, replay and
`#print` logs for every target), and `logs/clean_build.log`,
`logs/audit_bridge.log`.

## 5. Independent bridge source

`AuditBridge.lean` restates the problem from the original wording — `StdPrime`
(textbook: `2 ≤ p` and no divisor `2 ≤ d < p`), `StdPowerful`, `StdSquare` — and
proves `AuditBridge.intended_statement_is_false : ¬ IntendedClaim` by translating
between the restated and submitted predicates and applying
`JSP000301.original_claim_is_false`. A spot-check `example` re-validates the
witness 12167/12168 entirely at the level of the restated notions. Any silent
weakening of the submitted definitions would have made this bridge fail to
elaborate; it elaborated and kernel-checked.

## 6. Statement of AI assistance

The Lean formalization was produced with extensive AI assistance (coding-agent
authoring and review). This is disclosed in the pull request and in the proof
repository. The verification performed here is mechanical: the conclusions above
rest on Lean kernel checking at the pinned commit, not on any model's judgement.
