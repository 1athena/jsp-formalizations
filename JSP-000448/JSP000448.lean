/-
  JSP-000448 · Does the multicolor Ramsey number of a tree grow linearly with its order?

  Answer: YES.  We prove, in Lean, the explicit linear bound

      R_r(T_{k+1})  ≤  r * k + 2          (r ≥ 1)

  i.e. every r-colouring of the edges of the complete graph on N = r*k + 2
  vertices contains a monochromatic copy of every tree on k + 1 vertices.

  Derivation (the path indicated in the official catalog entry for JSP-000448):
    1. Pigeonhole: some colour class has at least C(N,2)/r edges.
    2. Erdős–Sós (JSP-000439, `Erdos548.erdos_548`): a graph on n vertices with
       more than ((k-1)/2) * n edges contains every tree on k+1 vertices.
    3. For N = r*k+2 one checks C(N,2)/r ≥ ((k-1)/2)*N + 1, hence the colour
       class found in (1) satisfies the hypothesis of (2).

  Dependency: `Erdos548_192usd_21h.lean` — Erdős problem 548 (Erdős–Sós
  conjecture) formalised by Tom Adamczewski, https://github.com/tadamcz/erdos548,
  Apache-2.0.  Vendored verbatim except for three mechanical API-drift fixes
  required by Lean 4.35 / current mathlib (see PATCHES.md); no mathematical
  content was altered.
-/

import Mathlib
import Erdos548_192usd_21h

open SimpleGraph

namespace JSP000448

noncomputable section

/-- The i-th colour class of an edge colouring `c` of the complete graph. -/
def colorClassGraph {N r : ℕ} (c : Sym2 (Fin N) → Fin r) (i : Fin r) :
    SimpleGraph (Fin N) where
  Adj v w := v ≠ w ∧ c s(v, w) = i
  symm := ⟨by
    intro a b h
    exact ⟨h.1.symm, by simpa [Sym2.eq_swap] using h.2⟩⟩
  loopless := ⟨by
    intro a h
    exact h.1 rfl⟩

/-- Classical decidability / finiteness instances for colour classes. -/
local instance colorClassDecAdj {N r : ℕ} (c : Sym2 (Fin N) → Fin r) (i : Fin r) :
    DecidableRel (colorClassGraph c i).Adj := fun _ _ => Classical.propDecidable _

local instance colorClassFintypeEdgeSet {N r : ℕ} (c : Sym2 (Fin N) → Fin r) (i : Fin r) :
    Fintype (colorClassGraph c i).edgeSet := SimpleGraph.fintypeEdgeSet _

/-- `edgeSet.ncard` agrees with `edgeFinset.card`. -/
lemma edgeSet_ncard_eq_edgeFinset_card {V : Type*} [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj] : G.edgeSet.ncard = G.edgeFinset.card := by
  simpa [SimpleGraph.edgeFinset] using (Set.ncard_eq_toFinset_card G.edgeSet)

/-- Membership in a colour class: exactly the edges of the complete graph of colour `i`. -/
lemma mem_colorClass_edgeFinset {N r : ℕ} (c : Sym2 (Fin N) → Fin r) (i : Fin r)
    (e : Sym2 (Fin N)) :
    e ∈ (colorClassGraph c i).edgeFinset ↔
      e ∈ (⊤ : SimpleGraph (Fin N)).edgeFinset ∧ c e = i := by
  constructor
  · intro he
    rcases e with ⟨v, w⟩
    rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet] at he
    have htop : s(v, w) ∈ (⊤ : SimpleGraph (Fin N)).edgeFinset := by
      rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
      simpa using he.1
    exact ⟨htop, he.2⟩
  · intro ⟨htop, hc⟩
    rcases e with ⟨v, w⟩
    rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
    rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet] at htop
    exact ⟨by simpa using htop, hc⟩

/-- The colour classes partition the edge set of the complete graph. -/
lemma colorClass_edgeFinset_eq {N r : ℕ} (c : Sym2 (Fin N) → Fin r) (i : Fin r) :
    (colorClassGraph c i).edgeFinset =
      (⊤ : SimpleGraph (Fin N)).edgeFinset.filter (fun e => c e = i) := by
  ext e
  simpa [Finset.mem_filter] using mem_colorClass_edgeFinset c i e

lemma sum_colorClass_edges {N r : ℕ} (c : Sym2 (Fin N) → Fin r) :
    (∑ i : Fin r, (colorClassGraph c i).edgeFinset.card) =
      (⊤ : SimpleGraph (Fin N)).edgeFinset.card := by
  simpa [colorClass_edgeFinset_eq] using
    (Finset.card_eq_sum_card_fiberwise (s := (⊤ : SimpleGraph (Fin N)).edgeFinset)
      (f := c) (t := (Finset.univ : Finset (Fin r)))
      (by intro x hx; simp)).symm

/-- Pigeonhole: some colour class carries at least a `1/r` fraction of all edges. -/
lemma exists_colorClass_large {N r : ℕ} (hr : 0 < r) (c : Sym2 (Fin N) → Fin r) :
    ∃ i : Fin r, ((⊤ : SimpleGraph (Fin N)).edgeFinset.card : ℚ) / r ≤
      ((colorClassGraph c i).edgeFinset.card : ℚ) := by
  classical
  by_contra! h
  have hlt : (∑ i : Fin r, ((colorClassGraph c i).edgeFinset.card : ℚ)) <
      (∑ i : Fin r, (((⊤ : SimpleGraph (Fin N)).edgeFinset.card : ℚ) / r)) := by
    refine Finset.sum_lt_sum ?_ ?_
    · intro i hi; exact le_of_lt (h i)
    · exact ⟨⟨0, hr⟩, by simp, h ⟨0, hr⟩⟩
  have hsum_nat := sum_colorClass_edges (N := N) (r := r) c
  have hsum : (∑ i : Fin r, ((colorClassGraph c i).edgeFinset.card : ℚ)) =
      ((⊤ : SimpleGraph (Fin N)).edgeFinset.card : ℚ) := by
    exact_mod_cast hsum_nat
  have htotal : (∑ i : Fin r, (((⊤ : SimpleGraph (Fin N)).edgeFinset.card : ℚ) / r)) =
      ((⊤ : SimpleGraph (Fin N)).edgeFinset.card : ℚ) := by
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    field_simp [show (r : ℚ) ≠ 0 by exact_mod_cast (ne_of_gt hr)]
  rw [hsum, htotal] at hlt
  exact (lt_irrefl _ hlt)

/-- Cast of `n.choose 2` into the rationals. -/
lemma cast_choose_two (n : ℕ) : ((n.choose 2 : ℕ) : ℚ) = (n : ℚ) * ((n : ℚ) - 1) / 2 := by
  have hdiv : 2 ∣ n * (n - 1) := by
    cases n with
    | zero => simp
    | succ m =>
        rcases Nat.even_mul_succ_self m with ⟨t, ht⟩
        exact ⟨t, by simpa [two_mul, Nat.mul_comm] using ht⟩
  rw [Nat.choose_two_right]
  rw [Nat.cast_div hdiv (by norm_num : (2 : ℚ) ≠ 0)]
  have hm : (↑(n * (n - 1)) : ℚ) = (n : ℚ) * ((n : ℚ) - 1) := by
    cases n with
    | zero => norm_num
    | succ m => norm_num
  rw [hm]
  norm_num

/-- The arithmetic inequality that makes the Erdős–Sós threshold available. -/
lemma arithmetic_core (r k : ℕ) (hr : 0 < r) :
    ((k : ℚ) - 1) / 2 * (r * k + 2 : ℕ) + 1 ≤
      (((r * k + 2).choose 2 : ℕ) : ℚ) / r := by
  have hrq : (r : ℚ) ≠ 0 := by exact_mod_cast (ne_of_gt hr)
  have hrqpos : (0 : ℚ) < r := by exact_mod_cast hr
  rw [cast_choose_two]
  have hN : ((r * k + 2 : ℕ) : ℚ) = (r : ℚ) * k + 2 := by norm_num
  rw [hN]
  field_simp [hrq]
  ring_nf
  have hpoly : 0 ≤ (r : ℚ) ^ 2 * (k : ℚ) + (r : ℚ) * (k : ℚ) + 2 := by positivity
  nlinarith

/-- Main theorem: the multicolor Ramsey number of a tree grows at most linearly. -/
theorem multicolor_tree_ramsey_linear (r k : ℕ) (hr : 0 < r) :
    ∀ c : Sym2 (Fin (r * k + 2)) → Fin r,
      ∃ i : Fin r, ∀ T : SimpleGraph (Fin (k + 1)),
        T.IsTree → T.IsContained (colorClassGraph c i) := by
  classical
  intro c
  let N := r * k + 2
  have htopcard : (⊤ : SimpleGraph (Fin N)).edgeFinset.card = N.choose 2 := by
    simpa [N] using (SimpleGraph.card_edgeFinset_top_eq_card_choose_two (V := Fin N))
  obtain ⟨i, hi⟩ := exists_colorClass_large (N := N) (r := r) hr c
  refine ⟨i, ?_⟩
  intro T hT
  have hnk : k + 1 ≤ N := by
    dsimp [N]
    nlinarith [hr]
  have hdegQ : ((k : ℚ) - 1) / 2 * (N : ℚ) + 1 ≤
      ((colorClassGraph c i).edgeSet.ncard : ℚ) := by
    have hsum := arithmetic_core r k hr
    have h1 : (((r * k + 2).choose 2 : ℕ) : ℚ) / (r : ℚ) ≤
        ((colorClassGraph c i).edgeFinset.card : ℚ) := by
      have hi' := hi
      rw [htopcard] at hi'
      simpa [N] using hi'
    have h2 := le_trans hsum h1
    simpa [edgeSet_ncard_eq_edgeFinset_card, N] using h2
  exact Erdos548.erdos_548 N k hnk (colorClassGraph c i) hdegQ T hT

end

end JSP000448
