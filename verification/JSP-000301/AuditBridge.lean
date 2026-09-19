/-
  Independent statement audit bridge for JSP-000301 (Erdos problem #365).

  This file deliberately does NOT reuse the submitted predicates.  It restates
  the original problem's notions directly from the standard textbook wording
  recorded in the catalog entry, and then proves that the submitted theorem
  really discharges the restated (intended) statement.  Any weakening of the
  submitted definitions would show up here as a failed bridge.
-/
import JSP000301

namespace AuditBridge

/-- Textbook primality, stated independently of the submitted file. -/
def StdPrime (p : Nat) : Prop :=
  2 ≤ p ∧ ∀ d : Nat, 2 ≤ d → d < p → ¬ d ∣ p

/-- Textbook "powerful", built on the independent primality predicate. -/
def StdPowerful (n : Nat) : Prop :=
  ∀ p : Nat, StdPrime p → p ∣ n → p * p ∣ n

/-- Textbook "perfect square". -/
def StdSquare (n : Nat) : Prop := ∃ k : Nat, k * k = n

/-- The original yes/no question, restated from the problem source. -/
def IntendedClaim : Prop :=
  ∀ n : Nat, 0 < n → StdPowerful n → StdPowerful (n + 1) → StdSquare n ∨ StdSquare (n + 1)

/-- The bridge: the submitted primality predicate is exactly the textbook one.
    This is proved against `JSP000301.isPrime_standard`, which is itself
    kernel-checked, so the equivalence is not assumed. -/
theorem prime_bridge (p : Nat) : StdPrime p ↔ JSP000301.IsPrime p := by
  exact (JSP000301.isPrime_standard p).symm

/-- Consequence: the submitted `Powerful` agrees with the textbook one. -/
theorem powerful_bridge (n : Nat) : StdPowerful n ↔ JSP000301.Powerful n := by
  constructor
  · intro h p hp hpn
    exact h p ((prime_bridge p).mpr hp) hpn
  · intro h p hp hpn
    exact h p ((prime_bridge p).mp hp) hpn

/-- Consequence: the submitted `IsSquare` is literally the textbook one. -/
theorem square_bridge (n : Nat) : StdSquare n ↔ JSP000301.IsSquare n := by
  rfl

/-- THE INTENDED STATEMENT, discharged from the submitted theorem. -/
theorem intended_statement_is_false : ¬ IntendedClaim := by
  intro h
  apply JSP000301.original_claim_is_false
  intro n hn hpn hpn1
  rcases h n hn ((powerful_bridge n).mpr hpn) ((powerful_bridge (n + 1)).mpr hpn1) with hs | hs
  · exact Or.inl ((square_bridge n).mp hs)
  · exact Or.inr ((square_bridge (n + 1)).mp hs)

/-- Independent spot-check of the witness at the level of the restated notions. -/
example : StdPowerful 12167 ∧ StdPowerful 12168 ∧ ¬ StdSquare 12167 ∧ ¬ StdSquare 12168 := by
  exact ⟨(powerful_bridge 12167).mpr JSP000301.powerful_12167,
         (powerful_bridge 12168).mpr JSP000301.powerful_12168,
         fun h => JSP000301.not_square_12167 ((square_bridge 12167).mp h),
         fun h => JSP000301.not_square_12168 ((square_bridge 12168).mp h)⟩

#print axioms intended_statement_is_false
#print axioms prime_bridge
#print axioms powerful_bridge

end AuditBridge
