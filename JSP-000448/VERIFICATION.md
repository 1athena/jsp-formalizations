# JSP-000448 · Lean kernel verification record

**Claim proved:** the multicolor Ramsey number of a tree grows at most linearly
with its order; concretely

```
R_r(T_{k+1})  ≤  r * k + 2      for every r ≥ 1
```

**Formal statement** (`JSP000448.lean`):

```lean
theorem multicolor_tree_ramsey_linear (r k : ℕ) (hr : 0 < r) :
    ∀ c : Sym2 (Fin (r * k + 2)) → Fin r,
      ∃ i : Fin r, ∀ T : SimpleGraph (Fin (k + 1)),
        T.IsTree → T.IsContained (colorClassGraph c i)
```

## Environment

| Item | Value |
|---|---|
| Lean | `4.35.0-rc2` (`leanprover/lean4:v4.35.0-rc2`) |
| mathlib | `leanprover-community/mathlib4` @ `44ba35c6daa9d69aff8fed9fff9bbde17ded774d` |
| OS | arm64-apple-darwin24.6.0 |

## Clean-room reproduction

```sh
LEAN_PATH=<mathlib .lake/build/lib/lean + lake-packages>
lean -o Erdos548_192usd_21h.olean Erdos548_192usd_21h.lean   # exit 0 (47 deprecation warnings from the vendored file)
lean -o JSP000448.olean JSP000448.lean                        # exit 0, 0 warnings, 0 errors
```

`#print axioms`:

```
'JSP000448.multicolor_tree_ramsey_linear' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`propext`, `Classical.choice` and `Quot.sound` are the three standard axioms of
Lean's logic; no additional axioms, no `sorry`, no `admit`, no `unsafe`, no
`implemented_by`, no `native_decide` and no `extern` are used.

## Structure of the proof

1. `colorClassGraph c i` — the `i`-th colour class of an `r`-colouring `c` of the
   edges of the complete graph on `Fin N`.
2. `colorClass_edgeFinset_eq` — the colour classes are exactly the fibres of `c`
   over the edge set of `⊤`.
3. `sum_colorClass_edges` — hence their edge counts sum to `#⊤.edgeFinset`
   (via `Finset.card_eq_sum_card_fiberwise`).
4. `exists_colorClass_large` — pigeonhole: some colour class has at least
   `#⊤.edgeFinset / r` edges.
5. `card_edgeFinset_top_eq_card_choose_two` + `cast_choose_two` — that number is
   `N.choose 2 / r`.
6. `arithmetic_core` — for `N = r*k + 2`, `((k-1)/2) * N + 1 ≤ N.choose 2 / r`.
7. `Erdos548.erdos_548` (Erdős–Sós, JSP-000439) turns the edge count into a copy
   of every tree on `k+1` vertices inside that single colour class.

## Provenance of the dependency

`Erdos548_192usd_21h.lean` is the Erdős–Sós formalization of **Tom Adamczewski**
(<https://github.com/tadamcz/erdos548> @ `82ffb751f3d37768927df9239ed08439bbe0dd09`),
Apache-2.0, vendored with three mechanical API-drift fixes only — see
[PATCHES.md](PATCHES.md).

## AI usage disclosure

The selection of the target, the API-drift repairs and the drafting of the
Lean source were produced with substantial assistance from an AI coding agent
(WorkBuddy / LLM). Every resulting artefact was checked by the Lean kernel as
recorded above; nothing is asserted that the kernel did not accept.
