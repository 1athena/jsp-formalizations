# Official `skills/lean-verify` audit run (round 36)

Date: 2026-09-25 (local, UTC+8)
Target: JSP-000301, pinned commit `39b85298cffb83fb07423216e741550e90470c09`
Repository: https://github.com/1athena/jsp-formalizations

The awards repository ships an official pre-submission self-check skill
`skills/lean-verify` (SKILL.md + `scripts/audit.py`). This run executes that
**official script unmodified** against the exact pinned proof commit.

## Environment

* Lean toolchain pinned by the repository: `leanprover/lean4:v4.33.0`
  (`lean-toolchain`, tracked at the pinned commit)
* Observed: `Lake version 5.0.0-src (Lean version 4.33.0)` and
  `Lean (version 4.33.0, arm64-apple-darwin20.0.0, Release)`
* Working copy: clean `git clone` + `git checkout 39b85298cffb83fb07423216e741550e90470c09`
  (HEAD equals the pinned commit; no tracked worktree changes)
* Only untracked audit scaffolding was added: `lakefile.lean`
  (a `lean_lib` target so `lake build +JSP000301` resolves the module).

## Commands executed by the official script

| command | exit | seconds |
| --- | --- | --- |
| `lake --version` | 0 | 0.0 |
| `lake env lean --version` | 0 | 0.6 |
| `lake build +JSP000301` | 0 | 19.3 |
| `lake env lean JSP000301.lean` | 0 | 18.8 |
| `lake env lean Audit0000.lean` | 0 | 0.8 |
| `lake build +JSP000301` (bridge) | 0 | 0.6 |
| `lake env lean JSP000301.lean` (bridge) | 0 | 18.4 |
| `lake env lean Audit0001.lean` | 0 | 0.8 |

## Result (`result.json`, exit code 0)

* `preflight.ready_for_target_checks` = **true**, `issues` = **[]**
  (toolchain file matches, source SHA-256 equals the blob at the pinned commit,
  HEAD equals the pinned commit, no tracked worktree changes)
* `mechanical_status` = **standard_axioms_only**
* target `main` (`JSP000301.consecutive_powerful_neither_square`):
  **standard_axioms_only**, axioms = `[propext]`
* target `bridge` (`JSP000301.original_claim_is_false`):
  **standard_axioms_only**, axioms = `[propext]`
* `inputs_stable` = true (pre/post file hashes identical)

`[propext]` is a strict subset of the standard Lean axioms
(`propext`, `Classical.choice`, `Quot.sound`). The proof uses no
`native_decide`, `implemented_by`, `extern`, `unsafe`, `axiom`, `sorry` or `admit`.

## Scope

This is the mechanical outcome of the official script only. It is not a
mathematical verdict (`semantic_verdict` = `not_determined` by design);
statement fidelity and attribution remain for maintainer review.

Artifacts: `official_lean_verify_result.json`, `official_lean_verify_manifest.json`.
