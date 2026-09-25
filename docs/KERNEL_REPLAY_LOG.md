# Kernel replay log

Dated, reproducible records of re-running the pinned proof through the Lean
kernel from a **fresh clone of this repository** (not from a local working
copy).  Each entry states the exact commit, toolchain, command, exit status and
the `#print axioms` output.  Pinned proof commit:
`39b85298cffb83fb07423216e741550e90470c09`.

## 2026-09-25 (round 35) — clean-clone replay

| item | value |
|---|---|
| commit | `39b85298cffb83fb07423216e741550e90470c09` |
| clone | `git clone https://github.com/1athena/jsp-formalizations.git` then `git checkout 39b85298cffb83fb07423216e741550e90470c09` |
| toolchain | Lean 4.33.0, arm64-apple-darwin20.0.0, Release (matches `lean-toolchain`) |
| command | `lean -o JSP000301.olean JSP000301.lean` |
| exit status | `0` |
| warnings | none |
| axioms (`consecutive_powerful_neither_square`) | `[propext]` |
| axioms (`original_claim_is_false`) | `[propext]` |
| forbidden constructs | none: no `sorry`, no `admit`, no `axiom`, no `native_decide`, no `implemented_by`, no `extern`, no `unsafe` |

`propext` is one of the three standard axioms of Lean's own logic
(`propext`, `Classical.choice`, `Quot.sound`); no custom axiom is introduced
anywhere in the file.

## 2026-09-25 (round 34) — local re-run

Same commit, same Lean 4.33.0 toolchain, same command, exit status `0`,
axioms `[propext]` for both theorems.  Recorded in
[`docs/TRIAGE_COMPLIANCE.md`](TRIAGE_COMPLIANCE.md).

## How to reproduce

```
git clone https://github.com/1athena/jsp-formalizations.git
cd jsp-formalizations
git checkout 39b85298cffb83fb07423216e741550e90470c09
lean -o JSP000301.olean JSP000301.lean     # exit 0
# then, inside Lean:
#   #print axioms consecutive_powerful_neither_square
#   #print axioms original_claim_is_false
```
