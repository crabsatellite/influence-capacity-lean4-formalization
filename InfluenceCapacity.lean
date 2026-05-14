/-
# InfluenceCapacity — top-level re-export.

Companion Lean 4 formalisation to:

  Li, A. C. (2026). *Influence Capacity Beyond GDP: An Axiomatic
  Three-Axis Decomposition*. SSRN Working Paper 6716498. v2.8
  math-converged 2026-05-11 (D3 hostile review R1-R10, 0 factual issues).

The InfluenceCapacity Lean library provides:
  * Opaque types for the paper's primitive objects (System, capability axes
    PI / MU / NU, Influence functional, Jacobian, Tullock contest, etc.)
    pending Mathlib support.
  * Axiomatised classical results invoked by the paper proofs (Aczel's
    Cauchy multiplicative theorem, Hartman-Grobman, Routh-Hurwitz, Bauer-Fike,
    mixed-Poisson dispersion / Cox-Lewis test).
  * The paper's load-bearing axioms (A0, A1, A2, A4) plus its conditional
    hypotheses (slow-driver regime, special-rank-1 fungibility, ex-ante
    regime-assignment protocol, small-share Tullock asymptotic).
  * The paper's main theorems as sorry-free Lean declarations, reduced via
    explicit chains to axioms / classical results / paper hypotheses above.
  * A typed gap ledger recording both status (gapOpen / gapPartial /
    gapBlocked / gapDeadEnd / gapClosed / gapClosedConditional /
    gapDefinitional) and source-of-truth category (Cat 0/1/2/3), with attack
    history.
-/

import InfluenceCapacity.Types
import InfluenceCapacity.ClassicalResults
import InfluenceCapacity.OpenHypotheses
import InfluenceCapacity.MainTheorem
import InfluenceCapacity.Ledger
