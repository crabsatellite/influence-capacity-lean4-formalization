import Lake
open Lake DSL

/-!
Lake project for the Influence Capacity (Three-Axis Decomposition) Lean 4
formalisation.

Companion to the paper `Influence Capacity Beyond GDP: An Axiomatic
Three-Axis Decomposition` (Li, 2026; SSRN 6716498; v2.8 math-converged
2026-05-11 after R1-R10 D3 hostile review, 0 factual issues at convergence).

The top-level module `InfluenceCapacity` re-exports:
  * `InfluenceCapacity.Types`           — opaque types (System, capability axes
                                            PI/MU/NU, Influence functional,
                                            Jacobian, Tullock contest, etc.).
  * `InfluenceCapacity.ClassicalResults` — classical theorems used by the
                                            paper, axiomatised pending Mathlib
                                            port (Aczel multiplicative-Cauchy,
                                            Hartman-Grobman, Routh-Hurwitz,
                                            Bauer-Fike, mixed-Poisson dispersion).
  * `InfluenceCapacity.OpenHypotheses`  — paper axioms (A0 commensurability,
                                            A1 continuity, A2 monotonicity, A4
                                            multiplicative scaling) and
                                            conditional hypotheses (slow-driver
                                            regime, special-rank-1 fungibility,
                                            ex-ante regime-assignment protocol,
                                            small-share Tullock asymptotic).
  * `InfluenceCapacity.MainTheorem`     — paper theorems: representation,
                                            Tullock microfoundation, dynamics
                                            microfoundation, meta-theorem on
                                            collapse sequence, regime-(i)/(ii)/
                                            (iii) collapse-sequence theorems,
                                            threshold theorem, non-substitutability,
                                            survival-weight derivation, etc.
  * `InfluenceCapacity.Ledger`           — gap ledger per gap-ledger-in-Lean4
                                            methodology: every axiom + theorem
                                            + sub-clause typed with status
                                            (gapOpen/Partial/Blocked/DeadEnd/
                                            Closed/ClosedConditional/
                                            Definitional), input category
                                            (Cat 0/1/2/3), and attack history.

The current Lean sources are sorry-free. Remaining mathematical debt is exposed
through typed opaque axioms and `LedgerEntry` metadata rather than hidden
placeholders. Each `axiom` is grounded in an explicit paper hypothesis or
external citation, and each derivable redundancy (A3 from A1+A2+A4; A5 from
A1+A2+A4) is encoded as a CLOSED `theorem` rather than a fresh axiom.
-/

package «InfluenceCapacity» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.16.0"

@[default_target]
lean_lib «InfluenceCapacity» where
  roots := #[`InfluenceCapacity]
