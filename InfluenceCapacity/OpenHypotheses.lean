/-
# Paper axioms (A0, A1, A2, A4) and conditional hypotheses.

The paper's representation theorem (`thm:representation`) is conditional
on five labelled axioms `A0` (commensurability prior), `A1` (continuity),
`A2` (monotonicity), `A3` (zero-axis annihilation), `A4` (multiplicative
scaling), `A5` (log-additivity). `A3` and `A5` are both DERIVABLE from
`A1 + A2 + A4`; the load-bearing
representation axioms are `A0`, `A1`, `A2`, `A4`. Accordingly we
encode the load-bearing four as `axiom`, and the two derivable as
CLOSED `theorem`s with explicit derivation chain (the proofs of A3 and
A5 are in `MainTheorem.lean` since they reuse `aczel_multiplicative_cauchy`).

Beyond the load-bearing axioms, the paper invokes several CONDITIONAL
hypotheses that are explicitly flagged as such (slow-driver regime for
Proposition `prop:clustering`; special-rank-1 fungibility matrix for
Theorem `thm:exponent-derivation`; ex-ante regime-assignment protocol
for Proposition `prop:ex-ante-classification`; small-share Tullock
asymptotic for Theorem `thm:tullock-microfoundation`). These are
encoded as additional `axiom`s in this file.

## Inhabitation scaffolding.
The carrier `EconomicSystem` is opaque (Types.lean). We declare a
canonical witness `canonicalPost1815System` here as honest scaffolding
for the post-1815 industrial-era calibration case (the headline
calibration `(δ_PI, δ_NU, δ_MU) = (0.02, 0.05, 0.10)` and survival-weight
prediction `(a, b, c) = (0.83, 0.04, 0.13)`). All universal quantifiers
in the paper theorems are non-vacuous via this witness.
-/

import InfluenceCapacity.Types
import InfluenceCapacity.ClassicalResults

namespace InfluenceCapacity

/-! ## 0. Inhabitation scaffolding -/

/-- Honest opaque witness for the post-1815 industrial-era calibration
 case. Used to ensure universal quantifiers
 `∀ (S : EconomicSystem),.` in paper theorems are non-vacuous. -/
axiom canonicalPost1815System : EconomicSystem

/-- Honest opaque witness for the AEB Mongol historical-fit calibration
 case (paper Theorem `thm:collapse-aeb` numerical evaluation). -/
axiom canonicalAEBMongolSystem : EconomicSystem

/-! ## 1. Axiom A0 — Commensurability prior

Paper Axiom `\label{ax:commensurability}`: capability axes inhabit a
common normed vector space, allowing comparison and aggregation across
systems within an era. A0 is a load-bearing prior, not an implicit assumption.
-/

/-- **Axiom A0 (commensurability prior)**.

paper source: ax:commensurability.

Statement (paper). There exists a σ-finite measure `μ` on the joint
own-state × other-state coordinate space `R × T^m` that is invariant
under resource-relabeling actions and admits a product decomposition
`μ = μ_R ⊗ μ_T` over the own-state and coupled-state coordinates.
This is the measure used by `Influence` to assign a real number to the
reachable-set projection of `EconomicSystem` (paper Definition
`def:influence`). Within-era commensurability across systems is the
operational corollary; cross-era commensurability is NOT asserted
(paper Strange-incommensurability discussion). The relabeling-invariance
+ product-decomposition content is opaque here pending Mathlib's
measure-theory + group-action infrastructure in the form needed by the
paper's `R × T^m` carrier. -/
axiom A0a_relabeling_invariant_measure : AxiomA0a_RelabelingInvariantMeasure_Holds

/-- **Axiom A0b (product decomposition)**: substantively stronger clause
 of paper Axiom A0 (commensurability). The Fubini-style independence
 `μ = μ_R ⊗ μ_T` is what `thm:decomposition`'s per-axis sectional
 decomposition requires; rejecting A0b is the substantive empirical
 position of the structural-power tradition (Strange 1988). -/
axiom A0b_product_decomposition : AxiomA0b_ProductDecomposition_Holds

/-- **Axiom A0 (commensurability, conjunction)**: A0a ∧ A0b. Lean-derived
 from the two clauses; legacy aggregate handle for downstream theorems
 that invoke commensurability without distinguishing the clauses. -/
theorem A0_commensurability : AxiomA0_Commensurability_Holds :=
  ⟨A0a_relabeling_invariant_measure, A0b_product_decomposition⟩

/-! ## 2. Axiom A1 — Continuity -/

/-- **Axiom A1 (continuity)**.

paper source: ax:continuity.

Statement (paper). The aggregator `F` is jointly continuous on the
closed non-negative orthant `ℝ_+^3 = [0,∞)^3` (continuity through the
boundary including axis-zero limits — load-bearing for the A3
derivability proof's `y → 0+` continuity argument) AND continuously
differentiable on the open positive orthant `ℝ_{++}^3 = (0,∞)^3`. The
per-axis continuity of `h_i : ℝ_+ → ℝ_+` (used in `thm:representation`
Step 3 to invoke Aczel) is a derived consequence after `thm:decomposition`
gives the multiplicatively-separable form. -/
axiom A1_continuity : AxiomA1_Continuity_Holds

/-! ## 3. Axiom A2 — Monotonicity -/

/-- **Axiom A2 (monotonicity)**.

paper source: ax:monotonicity.

Statement (paper). The aggregator `F` is non-decreasing in each axis
argument on the closed non-negative orthant `ℝ_+^3`, AND strictly
increasing on the open positive orthant `ℝ_{++}^3`. Equivalently on
`ℝ_{++}^3`: `∂F/∂PI > 0`, `∂F/∂MU > 0`,
`∂F/∂NU > 0`. The strict positivity on the open orthant propagates to
per-axis `h_i` being strictly increasing after `thm:decomposition`
gives the separable form. -/
axiom A2_monotonicity : AxiomA2_Monotonicity_Holds

/-! ## 4. Axiom A4 — Base-point-independent multiplicative scaling -/

/-- **Axiom A4 (base-point-independent multiplicative scaling)**.

paper source: ax:multiplicative-scaling.

Statement (paper, multi-variable form). The aggregator satisfies
`F(λ·PI, MU, NU) = h_1(λ) · F(PI, MU, NU)` (and analogously for
`MU` and `NU`) for some scalar function `h_1 : ℝ_{>0} → ℝ_{>0}`,
independent of the base point `(PI, MU, NU)`. After `thm:decomposition`
gives the multiplicatively-separable form `F = K · h_1(PI) · h_2(MU) · h_3(NU)`,
this base-point-independence yields the per-axis Cauchy equation
`h_i(λ · x) = h_i(λ) · h_i(x)` for `x, λ > 0`. The continuous + strictly
monotone solution (Aczel 1966 §2.1.2 = additive-Cauchy via log-transform;
see `aczel_additive_cauchy_continuous_linear` in `ClassicalResults.lean`)
is `h_i(x) = x^{γ_i}` with `γ_i > 0` from A2. -/
axiom A4_multiplicative_scaling : AxiomA4_MultiplicativeScaling_Holds

/-! ## 5. Slow-driver regime hypothesis (paper Proposition `prop:clustering`)

The strict over-dispersion claim `Var/E² > 1` requires the
slow-tension regime: `T(s)` varies on a timescale long compared to the
typical inter-shock gap, so `λ(T(s))` is approximately constant over
each `[t, t + τ]` and `τ | T(t) ~ Exp(λ(T(t)))`. Outside the slow-driver
regime, only the weaker `Var[τ] ≥ Var[E[τ | F_t]]` (law of total
variance) survives.

Empirical CV² = 0.45 < 1 in the post-1640 record is in the OPPOSITE
direction from the strict prediction — paper acknowledges this
opposite-direction empirical disclosure explicitly (rather than as a
mere "underpowered" defence).
-/

/-- **Slow-driver-regime hypothesis** for `prop:clustering`.

paper source: prop:clustering proof (slow-driver caveat).
Status: gapOpen for unconditional CV² > 1 claim; gapPartial under
 slow-driver restriction.

Typed as a parametric Prop: asserts that system `S` is in the slow-driver
regime with non-degenerate tension. The Cox-Lewis dispersion conclusion
of `prop:clustering` is derivable from this typed antecedent via
`cox_lewis_mixed_poisson_overdispersion` (ClassicalResults.lean §6). -/
def hyp_slow_driver_regime (S : EconomicSystem) : Prop :=
  SlowDriverApplies S ∧ TensionNonDegenerate S

/-! ## 6. Special-rank-1 fungibility hypothesis (paper Theorem
 `thm:exponent-derivation`)

The simpler form `w_k = δ_k⁻¹ · |∂W/∂x_k| · r_k` (no `L_k` factor) requires
the leakage `L_k = (1/R) Σ_ℓ φ_kℓ r_ℓ` to be axis-independent. The
more-general rank-1 form `φ_kℓ = α_k β_ℓ` leaves a residual
axis-dependent factor `α_k`; the SPECIAL-rank-1 form
`φ_kℓ = u · β_ℓ` with `u` axis-independent (or equivalently uniform `r`)
is the correct hypothesis.
-/

/-- **Special-rank-1 fungibility-matrix hypothesis** for
 `thm:exponent-derivation`.

paper source: thm:exponent-derivation Step 2 (special-rank-1 form
 with axis-independent coefficient `u`).

Statement (alternative-disjunctive). Either (a) the discrimination
parameters `r_ℓ` are approximately uniform across `ℓ`, OR (b) the
fungibility matrix `φ_{k,ℓ}` has the special-rank-1 form
`φ_{k,ℓ} = u · β_ℓ` with `u` axis-independent. Under either, `L_k`
becomes axis-independent and the simpler boxed formula
`w_k = δ_k⁻¹ |∂W/∂x_k| r_k` holds.

the disjunction is now type-level visible. Typed via
disjunctive predicate `IsLeakageAxisIndependent` (canonical) in
`Types.lean` Section 14, defined as
`IsUniformDiscriminationLoading S ∨ IsSpecialRank1FungibilityForm S`.
The previously opaque `IsSpecialRank1Fungibility` axiom predicate is
retained as a definitional alias of `IsLeakageAxisIndependent` for
paper-citation linkage (this `hyp_special_rank_1_fungibility` def
continues to wrap it; the underlying disjunction is now reachable
via `IsLeakageAxisIndependent`'s unfolding). -/
def hyp_special_rank_1_fungibility (S : EconomicSystem) : Prop :=
  IsSpecialRank1Fungibility S

/-! ## 7. Ex-ante regime-assignment protocol (paper Proposition
 `prop:ex-ante-classification`)

The 9-strict-of-11 count + p ≈ 4×10⁻⁶ rejection of random null requires
the ex-ante protocol: regime classification + measurement convention
locked from primitives observable at the latest pre-crossing date,
no post-hoc reclassification. Mughal central-treasury MU is the only
MU measurement available pre-1650; the post-hoc switch to
aggregate-South-Asian MU is NOT licensed.
-/

/-- **Ex-ante regime-assignment-protocol hypothesis** for
 `prop:ex-ante-classification`.

paper source: prop:ex-ante-classification preamble.

Statement. For each historical case in the calibration set, the regime
classification (SP / AEB / regime-(ii) info-era) is locked from
primitives observable at the latest pre-crossing date, with no post-hoc
reclassification (Mughal central-treasury MU stays as the lock-date
choice; aggregate-South-Asian MU emerges only post-Maratha-1719 and is
NOT licensed). Typed via opaque predicate `IsExAnteRegimeAssignmentLocked`
in `Types.lean` Section 14. -/
def hyp_ex_ante_regime_assignment_protocol
    (cases : List EconomicSystem) : Prop :=
  IsExAnteRegimeAssignmentLocked cases

/-! ## 8. Small-share Tullock asymptotic (paper Theorem
 `thm:tullock-microfoundation`)

The Cobb-Douglas form `Influence ∝ ∏_k x_k^{r_k}` is the leading-order
approximation in the small-share limit `s_{i,k} = x_{i,k}^{r_k}/X_k → 0`.
At hegemonic shares (`s_max ≈ 0.74` for raw 70% reserve-currency leader
under multi-rival distribution and `r_NU ≈ 1.13`), Cor.~`cor:finite-share-tullock`
gives a finite-share correction whose tight bound is `1 - (1 - s_max)^3 ≈ 0.98`.
The qualitative ordering theorem `thm:meta-collapse` survives at finite
share because it depends on slow-mode eigenvalue ordering (which finite-share
corrections shift only by `O(s_max²)`); cardinal predictions of cross-coupling
magnitudes carry the explicit finite-share correction.
-/

/-- **Small-share Tullock-asymptotic hypothesis** for
 `thm:tullock-microfoundation`.

paper source: thm:tullock-microfoundation hypothesis + Remark
 `rem:linearization-caveats` clause (iii).

Statement. The focal system's Tullock-weight share in each contest is
asymptotically small enough that the Cobb-Douglas best-response identity
`s_ℓ^* = r_ℓ / R` (paper Lemma `lem:budget-feedback`) holds to leading
order. Hegemonic-state applications (Britain 1860 peak; postwar US;
USSR 1985) operate at the BOUNDARY of this regime; cardinal predictions
require Cor.~`cor:finite-share-tullock`. Typed via existing
`SmallShareRegime` predicate (`Types.lean` §4). -/
def hyp_small_share_tullock
    (S : EconomicSystem) (r : TullockParameters) : Prop :=
  SmallShareRegime S r

/-! ## 9. Time-invariant cross-couplings within a regime (paper Remark
 `rem:linearization-caveats` clause (ii))

The cross-coupling matrix `A = (α_km)` is treated as time-invariant
within an era. Discrete regime changes (Bretton Woods 1971; 2018 chip
export controls; 2022 sanctions cascade) violate constant-`A` within
calibration windows that span the discrete change. Under time-varying
`A(t)`, Lemma `lem:hss-exists` and Theorem `thm:threshold` lose their
closed-form solutions; the qualitative-ordering theorem survives if
`A(t)` stays in a Hurwitz neighbourhood.
-/

/-- **Time-invariant cross-couplings hypothesis** for `lem:hss-exists` /
 `thm:threshold` closed-form claims.

paper source: rem:linearization-caveats (ii). Typed via opaque predicate
`IsTimeInvariantCrossCoupling` in `Types.lean` Section 14. -/
def hyp_time_invariant_cross_couplings (J : Jacobian3) : Prop :=
  IsTimeInvariantCrossCoupling J

/-! ## 10. Special-rank-1 + small-share are consequences of two structural choices

These two hypotheses are NOT independent of the paper's other choices:
small-share is the asymptotic regime of `thm:tullock-microfoundation`,
and special-rank-1 reflects either uniform `r` (under the calibration
`r ∈ [0.21, 0.40]` to within a factor of two) or the structural
microfoundation `α_km = L_k · ∂W/∂x_m` of `thm:dynamics-microfoundation`
when `L_k` is axis-independent.
-/

end InfluenceCapacity
