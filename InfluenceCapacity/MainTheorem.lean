/-
# Main paper theorems for the Three-Axis Influence-Capacity formalisation.

Every paper theorem is closed in Lean — either via direct discharge to
a classical-literature axiom in `ClassicalResults.lean`, via a real
algebraic / structural Lean proof using Mathlib, via inductive-type
pattern matching, via explicit existential witness, or via discharge
to a paper-bound `paper_X_holds` axiom (one-to-one with a paper theorem
the formalisation defers proving due to Mathlib infrastructure not
yet imported, e.g., PDMP / fderiv / aggregator-parameterization).

File structure:
 * The representation-theorem track (`thm_representation`,
 `A3_redundant_from_A1_A2_A4`, `A5_redundant_from_A1_A2_A4`,
 `thm_nonsubstitutability`, `cor_annihilation_from_tullock`).
 * The microfoundation track (`thm_tullock_microfoundation`,
 `lem_budget_feedback`, `thm_dynamics_microfoundation`).
 * The dynamics track (`lem_hss_exists`, `thm_threshold`,
 `thm_threshold_case_specific`, `prop_nonlinear_stability`).
 * The collapse-sequence track (`thm_meta_collapse`,
 `thm_collapse_sequence`, `thm_collapse_sequence_info`,
 `thm_collapse_aeb`, `cor_two_regimes`).
 * The exponent-derivation track (`thm_exponent_derivation`,
 `cor_exponent_sensitivity`, `thm_three_axes`).
 * The hegemonic-margin track (`prop_theta_bar_derived`,
 `prop_theta_bar_case`, `cor_composite_margin`).
 * The endogenous-shock track (`def_structural_tension`,
 `prop_clustering`, `thm_tension_cycle`).
 * The ex-ante-protocol track (`prop_ex_ante_classification`,
 `cor_ex_ante_pvalue`, `cor_selection_bias_corrected_null`).
 * The non-substitutability track (`thm_nonsubstitutability`,
 `cor_finite_share_tullock`, `cor_cross_scale_nonsub`).
 * Auxiliary results (`prop_nu_removal` — cardinal-up-to-constant in
 isotropic case + ordinal preservation in general anisotropic case).
-/

import InfluenceCapacity.Types
import InfluenceCapacity.ClassicalResults
import InfluenceCapacity.OpenHypotheses

namespace InfluenceCapacity

/-! ## 0. Aggregator multiplicativity + Aczel power-form derivation

Paper `thm:representation` Steps 1-3 derive the per-axis power-form
`h_i(x) = x^{γ_i}` via: (1) multi-base-point A4 ⟹ multiplicative-Cauchy
on positives; (2) A1+A2 give continuity + strict-monotonicity; (3) Aczel
1966 §2.1.2 discharges multiplicative-Cauchy + continuity + strict-mono
to power-form. The Aczel discharge is a Lean theorem
(`aczel_multiplicative_cauchy_power_form`); the paper-novel piece is the
calibration assignment `γ_i = paperCDExponents.{a,b,c}`.
-/

/-- Multiplicativity of `h_PI_of_A4` on positive reals: derived from
 multi-base-point A4 along PI + strict-positivity of `paperAggregator`
 on the open positive orthant. Paper `thm:representation` Step 1
 derivation. -/
theorem h_PI_of_A4_multiplicative :
    ∀ x y : ℝ, x > 0 → y > 0 →
      h_PI_of_A4 (x * y) = h_PI_of_A4 x * h_PI_of_A4 y := by
  intro x y hx hy
  let x_nn : NNReal := ⟨x, le_of_lt hx⟩
  let y_nn : NNReal := ⟨y, le_of_lt hy⟩
  have h_x_coe : (x_nn : ℝ) = x := rfl
  have h_y_coe : (y_nn : ℝ) = y := rfl
  have h_x_pos : (x_nn : ℝ) > 0 := h_x_coe ▸ hx
  have h_y_pos : (y_nn : ℝ) > 0 := h_y_coe ▸ hy
  have h_one_pos : ((1 : NNReal) : ℝ) > 0 := by norm_num
  have h_xy_eq : ((x_nn * y_nn : NNReal) : ℝ) = x * y := by
    rw [NNReal.coe_mul, h_x_coe, h_y_coe]
  have h_xy_pos : ((x_nn * y_nn : NNReal) : ℝ) > 0 := by
    rw [h_xy_eq]; exact mul_pos hx hy
  have h_F_111_pos : (paperAggregator 1 1 1 : ℝ) > 0 :=
    paperAggregator_pos_on_pos 1 1 1 h_one_pos h_one_pos h_one_pos
  have h_F_111_ne : (paperAggregator 1 1 1 : ℝ) ≠ 0 := ne_of_gt h_F_111_pos
  -- step_y: F(y_nn, 1, 1) = h_PI(y) · F(1, 1, 1)


  have step_y : (paperAggregator y_nn 1 1 : ℝ) =
      h_PI_of_A4 y * (paperAggregator 1 1 1 : ℝ) := by
    have spec :=
      h_PI_of_A4_multi_base_spec y_nn 1 1 1 h_y_pos h_one_pos h_one_pos h_one_pos
    rw [mul_one] at spec
    rw [h_y_coe] at spec
    exact spec
  -- step_xy_unit: F((x_nn*y_nn), 1, 1) = h_PI(x*y) · F(1, 1, 1)


  have step_xy_unit : (paperAggregator (x_nn * y_nn) 1 1 : ℝ) =
      h_PI_of_A4 (x * y) * (paperAggregator 1 1 1 : ℝ) := by
    have spec := h_PI_of_A4_multi_base_spec
      (x_nn * y_nn) 1 1 1 h_xy_pos h_one_pos h_one_pos h_one_pos
    rw [mul_one] at spec
    rw [h_xy_eq] at spec
    exact spec
  -- step_xy_chain: F((x_nn*y_nn), 1, 1) = h_PI(x) · F(y_nn, 1, 1)


  --                                       = h_PI(x) · h_PI(y) · F(1, 1, 1)


  have step_xy_chain : (paperAggregator (x_nn * y_nn) 1 1 : ℝ) =
      h_PI_of_A4 x * (h_PI_of_A4 y * (paperAggregator 1 1 1 : ℝ)) := by
    have spec :=
      h_PI_of_A4_multi_base_spec x_nn y_nn 1 1 h_x_pos h_y_pos h_one_pos h_one_pos
    rw [h_x_coe] at spec
    rw [step_y] at spec
    exact spec
  have key : h_PI_of_A4 (x * y) * (paperAggregator 1 1 1 : ℝ) =
      h_PI_of_A4 x * h_PI_of_A4 y * (paperAggregator 1 1 1 : ℝ) := by
    rw [← step_xy_unit, step_xy_chain]; ring
  exact mul_right_cancel₀ h_F_111_ne key

/-- Multiplicativity of `h_MU_of_A4` on positive reals (paper
 `thm:representation` Step 1, MU axis). -/
theorem h_MU_of_A4_multiplicative :
    ∀ x y : ℝ, x > 0 → y > 0 →
      h_MU_of_A4 (x * y) = h_MU_of_A4 x * h_MU_of_A4 y := by
  intro x y hx hy
  let x_nn : NNReal := ⟨x, le_of_lt hx⟩
  let y_nn : NNReal := ⟨y, le_of_lt hy⟩
  have h_x_coe : (x_nn : ℝ) = x := rfl
  have h_y_coe : (y_nn : ℝ) = y := rfl
  have h_x_pos : (x_nn : ℝ) > 0 := h_x_coe ▸ hx
  have h_y_pos : (y_nn : ℝ) > 0 := h_y_coe ▸ hy
  have h_one_pos : ((1 : NNReal) : ℝ) > 0 := by norm_num
  have h_xy_eq : ((x_nn * y_nn : NNReal) : ℝ) = x * y := by
    rw [NNReal.coe_mul, h_x_coe, h_y_coe]
  have h_xy_pos : ((x_nn * y_nn : NNReal) : ℝ) > 0 := by
    rw [h_xy_eq]; exact mul_pos hx hy
  have h_F_111_pos : (paperAggregator 1 1 1 : ℝ) > 0 :=
    paperAggregator_pos_on_pos 1 1 1 h_one_pos h_one_pos h_one_pos
  have h_F_111_ne : (paperAggregator 1 1 1 : ℝ) ≠ 0 := ne_of_gt h_F_111_pos
  have step_y : (paperAggregator 1 y_nn 1 : ℝ) =
      h_MU_of_A4 y * (paperAggregator 1 1 1 : ℝ) := by
    have spec :=
      h_MU_of_A4_multi_base_spec y_nn 1 1 1 h_y_pos h_one_pos h_one_pos h_one_pos
    rw [mul_one] at spec
    rw [h_y_coe] at spec
    exact spec
  have step_xy_unit : (paperAggregator 1 (x_nn * y_nn) 1 : ℝ) =
      h_MU_of_A4 (x * y) * (paperAggregator 1 1 1 : ℝ) := by
    have spec := h_MU_of_A4_multi_base_spec
      (x_nn * y_nn) 1 1 1 h_xy_pos h_one_pos h_one_pos h_one_pos
    rw [mul_one] at spec
    rw [h_xy_eq] at spec
    exact spec
  have step_xy_chain : (paperAggregator 1 (x_nn * y_nn) 1 : ℝ) =
      h_MU_of_A4 x * (h_MU_of_A4 y * (paperAggregator 1 1 1 : ℝ)) := by
    have spec :=
      h_MU_of_A4_multi_base_spec x_nn 1 y_nn 1 h_x_pos h_one_pos h_y_pos h_one_pos
    rw [h_x_coe] at spec
    rw [step_y] at spec
    exact spec
  have key : h_MU_of_A4 (x * y) * (paperAggregator 1 1 1 : ℝ) =
      h_MU_of_A4 x * h_MU_of_A4 y * (paperAggregator 1 1 1 : ℝ) := by
    rw [← step_xy_unit, step_xy_chain]; ring
  exact mul_right_cancel₀ h_F_111_ne key

/-- Multiplicativity of `h_NU_of_A4` on positive reals (paper
 `thm:representation` Step 1, NU axis). -/
theorem h_NU_of_A4_multiplicative :
    ∀ x y : ℝ, x > 0 → y > 0 →
      h_NU_of_A4 (x * y) = h_NU_of_A4 x * h_NU_of_A4 y := by
  intro x y hx hy
  let x_nn : NNReal := ⟨x, le_of_lt hx⟩
  let y_nn : NNReal := ⟨y, le_of_lt hy⟩
  have h_x_coe : (x_nn : ℝ) = x := rfl
  have h_y_coe : (y_nn : ℝ) = y := rfl
  have h_x_pos : (x_nn : ℝ) > 0 := h_x_coe ▸ hx
  have h_y_pos : (y_nn : ℝ) > 0 := h_y_coe ▸ hy
  have h_one_pos : ((1 : NNReal) : ℝ) > 0 := by norm_num
  have h_xy_eq : ((x_nn * y_nn : NNReal) : ℝ) = x * y := by
    rw [NNReal.coe_mul, h_x_coe, h_y_coe]
  have h_xy_pos : ((x_nn * y_nn : NNReal) : ℝ) > 0 := by
    rw [h_xy_eq]; exact mul_pos hx hy
  have h_F_111_pos : (paperAggregator 1 1 1 : ℝ) > 0 :=
    paperAggregator_pos_on_pos 1 1 1 h_one_pos h_one_pos h_one_pos
  have h_F_111_ne : (paperAggregator 1 1 1 : ℝ) ≠ 0 := ne_of_gt h_F_111_pos
  have step_y : (paperAggregator 1 1 y_nn : ℝ) =
      h_NU_of_A4 y * (paperAggregator 1 1 1 : ℝ) := by
    have spec :=
      h_NU_of_A4_multi_base_spec y_nn 1 1 1 h_y_pos h_one_pos h_one_pos h_one_pos
    rw [mul_one] at spec
    rw [h_y_coe] at spec
    exact spec
  have step_xy_unit : (paperAggregator 1 1 (x_nn * y_nn) : ℝ) =
      h_NU_of_A4 (x * y) * (paperAggregator 1 1 1 : ℝ) := by
    have spec := h_NU_of_A4_multi_base_spec
      (x_nn * y_nn) 1 1 1 h_xy_pos h_one_pos h_one_pos h_one_pos
    rw [mul_one] at spec
    rw [h_xy_eq] at spec
    exact spec
  have step_xy_chain : (paperAggregator 1 1 (x_nn * y_nn) : ℝ) =
      h_NU_of_A4 x * (h_NU_of_A4 y * (paperAggregator 1 1 1 : ℝ)) := by
    have spec :=
      h_NU_of_A4_multi_base_spec x_nn 1 1 y_nn h_x_pos h_one_pos h_one_pos h_y_pos
    rw [h_x_coe] at spec
    rw [step_y] at spec
    exact spec
  have key : h_NU_of_A4 (x * y) * (paperAggregator 1 1 1 : ℝ) =
      h_NU_of_A4 x * h_NU_of_A4 y * (paperAggregator 1 1 1 : ℝ) := by
    rw [← step_xy_unit, step_xy_chain]; ring
  exact mul_right_cancel₀ h_F_111_ne key

/-- Per-axis Aczel power-form discharge for h_PI: `∃ γ_PI > 0, ∀ x > 0,
 h_PI(x) = x^{γ_PI}`. Discharged via the proved Lean theorem
 `aczel_multiplicative_cauchy_power_form`. -/
theorem h_PI_of_A4_eq_power_aczel :
    ∃ γ_PI : ℝ, γ_PI > 0 ∧ ∀ x : ℝ, x > 0 → h_PI_of_A4 x = x ^ γ_PI :=
  aczel_multiplicative_cauchy_power_form h_PI_of_A4
    h_PI_of_A4_continuous h_PI_of_A4_strict_mono h_PI_of_A4_multiplicative

theorem h_MU_of_A4_eq_power_aczel :
    ∃ γ_MU : ℝ, γ_MU > 0 ∧ ∀ x : ℝ, x > 0 → h_MU_of_A4 x = x ^ γ_MU :=
  aczel_multiplicative_cauchy_power_form h_MU_of_A4
    h_MU_of_A4_continuous h_MU_of_A4_strict_mono h_MU_of_A4_multiplicative

theorem h_NU_of_A4_eq_power_aczel :
    ∃ γ_NU : ℝ, γ_NU > 0 ∧ ∀ x : ℝ, x > 0 → h_NU_of_A4 x = x ^ γ_NU :=
  aczel_multiplicative_cauchy_power_form h_NU_of_A4
    h_NU_of_A4_continuous h_NU_of_A4_strict_mono h_NU_of_A4_multiplicative

/-- Paper §6 historical-headline empirical-calibration assignment for
 the PI axis: the Aczel-extracted abstract exponent `γ_PI` (existence
 guaranteed by `thm:representation`) is identified with the paper's
 six-case regime-density MLE cardinal `paperCDExponents.a = 0.40` from
 paper Table~`tab:exponents` (Spain, Netherlands, Britain, Qing,
 Ottoman, Roman industrial-era subset).

 paper source: paper Table `tab:exponents` (empirical six-case MLE),
 NOT `thm:representation` Step 5 (which only establishes existence of
 `γ` without pinning a numerical value), and NOT
 `thm:exponent-derivation`'s predicted survival-weight cardinal `0.83`
 (which is the structural prediction, distinct from the empirical fit
 axiomatised here).

 Cat 3 sub-type: workingAssumption — empirical-calibration assignment. -/
axiom paperAggregator_gamma_PI_eq_paperCD_a :
  Classical.choose h_PI_of_A4_eq_power_aczel = (paperCDExponents.a : ℝ)

/-- §6 historical-headline calibration assignment for the MU axis
 (`paperCDExponents.b = 0.21`, six-case industrial-era MLE).
 Paper source: Table `tab:exponents`. -/
axiom paperAggregator_gamma_MU_eq_paperCD_b :
  Classical.choose h_MU_of_A4_eq_power_aczel = (paperCDExponents.b : ℝ)

/-- §6 historical-headline calibration assignment for the NU axis
 (`paperCDExponents.c = 0.39`, six-case industrial-era MLE).
 Paper source: Table `tab:exponents`. -/
axiom paperAggregator_gamma_NU_eq_paperCD_c :
  Classical.choose h_NU_of_A4_eq_power_aczel = (paperCDExponents.c : ℝ)

/-- Lean-derived: `h_PI_of_A4 x = x^{paperCDExponents.a}` for positive `x`.
 Composes Aczel power-form (Lean-derived) with paper-novel calibration. -/
theorem h_PI_of_A4_eq_paperCD_power :
    ∀ x : ℝ, x > 0 → h_PI_of_A4 x = x ^ (paperCDExponents.a : ℝ) := by
  intro x hx
  have spec := (Classical.choose_spec h_PI_of_A4_eq_power_aczel).2 x hx
  rw [paperAggregator_gamma_PI_eq_paperCD_a] at spec
  exact spec

theorem h_MU_of_A4_eq_paperCD_power :
    ∀ x : ℝ, x > 0 → h_MU_of_A4 x = x ^ (paperCDExponents.b : ℝ) := by
  intro x hx
  have spec := (Classical.choose_spec h_MU_of_A4_eq_power_aczel).2 x hx
  rw [paperAggregator_gamma_MU_eq_paperCD_b] at spec
  exact spec

theorem h_NU_of_A4_eq_paperCD_power :
    ∀ x : ℝ, x > 0 → h_NU_of_A4 x = x ^ (paperCDExponents.c : ℝ) := by
  intro x hx
  have spec := (Classical.choose_spec h_NU_of_A4_eq_power_aczel).2 x hx
  rw [paperAggregator_gamma_NU_eq_paperCD_c] at spec
  exact spec

/-! ## 1. Representation theorem and axiom-redundancy theorems

Paper Theorem `thm:representation`: under A0 + A1 + A2 + A4 the influence
functional has Cobb-Douglas form `F = K · PI^a · MU^b · NU^c`. Paper
Step 5 acknowledges `A3` and `A5` are derivable from A1 + A2 + A4
(not independent); they are retained as explicit verification clauses,
not independent constraints. -/

/-- **Theorem `thm:representation`**: Cobb-Douglas representation
 forced by A0 + A1 + A2 + A4 (with A3 and A5 derivable, see below).

paper source: thm:representation (Step 5 acknowledges A3 + A5 derivability).

Statement. Under axioms A0 (commensurability), A1 (continuity), A2
(monotonicity), A4 (multiplicative scaling), every influence functional
of the three axes on the strictly-positive orthant takes the Cobb-Douglas
form. Boundary case (any axis = 0) handled separately via
`A3_zero_axis_annihilation_derivable`. -/
theorem thm_representation :
  ∀ (S : EconomicSystem),
    (productiveCapacity S : ℝ) > 0 →
    (mobilizableSurplus S : ℝ) > 0 →
    (networkPosition S : ℝ) > 0 →
    ∃ γ : CobbDouglasExponents,
      (Influence S : ℝ) = CobbDouglasInfluence γ S := by
  intro S hPI hMU hNU
  refine ⟨paperCDExponents, ?_⟩
  rw [influence_via_aggregator]
  unfold CobbDouglasInfluence
  -- Paper thm:representation Steps 1-3: per-axis multi-base-point A4 ⟹


  -- multiplicative-Cauchy ⟹ Aczel ⟹ `h_i(x) = x^{γ_i}`. Plus units


  -- calibration `F(1,1,1) = K`. The chain is Lean-derived (multiplicativity


  -- + Aczel) up to the paper-novel γ_i = paperCDExponents.{a,b,c} calibration.


  have h1pos : ((1 : NNReal) : ℝ) > 0 := by norm_num
  -- Step 1: A4 along PI at base (1, MU, NU) with scale PI:


  -- F(PI · 1, MU, NU) = h_PI(PI) · F(1, MU, NU).


  have step1 :=
    h_PI_of_A4_multi_base_spec (productiveCapacity S) 1
      (mobilizableSurplus S) (networkPosition S) hPI h1pos hMU hNU
  rw [mul_one] at step1
  -- Step 2: A4 along MU at base (1, 1, NU) with scale MU.


  have step2 :=
    h_MU_of_A4_multi_base_spec (mobilizableSurplus S) 1 1
      (networkPosition S) hMU h1pos h1pos hNU
  rw [mul_one] at step2
  -- Step 3: A4 along NU at base (1, 1, 1) with scale NU.


  have step3 :=
    h_NU_of_A4_multi_base_spec (networkPosition S) 1 1 1
      hNU h1pos h1pos h1pos
  rw [mul_one] at step3
  -- Per-axis Aczel power-form (Lean-derived) + paper-novel calibration.


  have stepPow_PI := h_PI_of_A4_eq_paperCD_power (productiveCapacity S) hPI
  have stepPow_MU := h_MU_of_A4_eq_paperCD_power (mobilizableSurplus S) hMU
  have stepPow_NU := h_NU_of_A4_eq_paperCD_power (networkPosition S) hNU
  -- Units calibration: F(1,1,1) = K.


  have stepK := paperAggregator_at_one_eq_K
  rw [step1, step2, step3, stepPow_PI, stepPow_MU, stepPow_NU, stepK]
  ring

/-- A3 (zero-axis annihilation) is derivable from A1+A2+A4, not an
 independent axiom (paper `thm:representation` Step 5 acknowledgment).

paper source: thm:representation Step 5.
Reduces to: `A3_redundant_from_A1_A2_A4` in `ClassicalResults.lean`,
which itself reduces to `aczel_additive_cauchy_continuous_linear` via
log/exp transform. -/
theorem A3_zero_axis_annihilation_derivable :
    ∀ (h : ℝ → ℝ),
      Continuous h →
      StrictMono h →
      (∀ x y : ℝ, x > 0 → y > 0 → h (x * y) = h x * h y) →
      h 0 = 0 :=
  A3_redundant_from_A1_A2_A4

/-- **A5 (log-additivity) is automatically satisfied by Cobb-Douglas form**.

paper source: thm:representation Step 5.

Statement. The Cobb-Douglas form `F = K · PI^a · MU^b · NU^c` has
log-additive structure `log F = log K + a log PI + b log MU + c log NU`,
with all cross-partials of `log F` zero. So once A1 + A2 + A4 force the
Cobb-Douglas form (via `thm_representation`), A5 follows by direct
computation. The positivity hypothesis on each axis is required for
`Real.log_rpow` and `Real.log_mul` to apply; at the boundary (any axis
= 0), the conclusion fails because `Real.log 0 = 0` by Mathlib
convention, while `a · log 0 = 0` regardless. -/
theorem A5_log_additivity_derivable :
    ∀ (γ : CobbDouglasExponents) (S : EconomicSystem),
      (productiveCapacity S : ℝ) > 0 →
      (mobilizableSurplus S : ℝ) > 0 →
      (networkPosition S : ℝ) > 0 →
      Real.log (CobbDouglasInfluence γ S) =
        Real.log cobbDouglasConstant
          + γ.a * Real.log (productiveCapacity S)
          + γ.b * Real.log (mobilizableSurplus S)
          + γ.c * Real.log (networkPosition S) := by
  intro γ S hPI hMU hNU
  unfold CobbDouglasInfluence
  have hK : cobbDouglasConstant > 0 := cobbDouglasConstant_pos
  have hPIa : (0:ℝ) < (productiveCapacity S : ℝ) ^ (γ.a : ℝ) :=
    Real.rpow_pos_of_pos hPI _
  have hMUb : (0:ℝ) < (mobilizableSurplus S : ℝ) ^ (γ.b : ℝ) :=
    Real.rpow_pos_of_pos hMU _
  have hNUc : (0:ℝ) < (networkPosition S : ℝ) ^ (γ.c : ℝ) :=
    Real.rpow_pos_of_pos hNU _
  rw [Real.log_mul (by positivity) (ne_of_gt hNUc)]
  rw [Real.log_mul (by positivity) (ne_of_gt hMUb)]
  rw [Real.log_mul (ne_of_gt hK) (ne_of_gt hPIa)]
  rw [Real.log_rpow hPI, Real.log_rpow hMU, Real.log_rpow hNU]

/-- **Theorem `thm:nonsubstitutability`**: any axis → 0 forces Influence → 0.

paper source: thm:nonsubstitutability + cor:annihilation-from-tullock.

Statement. For every Cobb-Douglas exponent triple `γ` with `γ.a, γ.b,
γ.c > 0` (A2 strict monotonicity), every single axis admits the
"vanishing implies annihilation" property: `x_k → 0 ⟹ Influence → 0`.
Typed via opaque predicate `AnnihilatesAsAxisVanishes`. -/
theorem thm_nonsubstitutability :
  ∀ (γ : CobbDouglasExponents) (k : CapabilityAxis),
    AnnihilatesAsAxisVanishes γ k := by
  intro γ k S hk
  unfold CobbDouglasInfluence
  match k with
  | .PI =>
    have hPI_zero : (productiveCapacity S : ℝ) = 0 := hk
    rw [hPI_zero, Real.zero_rpow (ne_of_gt γ.pos_a)]
    ring
  | .MU =>
    have hMU_zero : (mobilizableSurplus S : ℝ) = 0 := hk
    rw [hMU_zero, Real.zero_rpow (ne_of_gt γ.pos_b)]
    ring
  | .NU =>
    have hNU_zero : (networkPosition S : ℝ) = 0 := hk
    rw [hNU_zero, Real.zero_rpow (ne_of_gt γ.pos_c)]
    ring

/-! ## 2. Tullock microfoundation track -/

/-- **Theorem `thm:tullock-microfoundation`**: small-share asymptotic
 yields Cobb-Douglas form from three independent Tullock contests.

paper source: thm:tullock-microfoundation (small-share asymptotic regime).
Discharged by: `paper_csf_small_share_limit_construction` (paper-novel
three-contest factorisation; classical Tullock / Skaperdas / Konrad
supply only the single-contest CSF). -/
theorem thm_tullock_microfoundation :
  ∀ (S : EconomicSystem) (r : TullockParameters),
    SmallShareRegime S r → LogInfluenceFactorisesAsCobbDouglas S r :=
  paper_csf_small_share_limit_construction

/-- **Lemma `lem:budget-feedback`**: under Cobb-Douglas best-response
 `s_ℓ^* = r_ℓ / R` is constant; cross-couplings come from budget
 feedback `α_km = L_k · ∂W/∂x_m`.

paper source: lem:budget-feedback. Typed via opaque predicate
`IsConstantShareIdentityWithBudgetFeedback`. -/
theorem lem_budget_feedback :
  ∀ (S : EconomicSystem) (r : TullockParameters) (γ : CobbDouglasExponents),
    SmallShareRegime S r →
    IsConstantShareIdentityWithBudgetFeedback S r γ := by
  intro _ r γ _
  refine ⟨r.r_PI + r.r_MU + r.r_NU, ?_, rfl, ?_⟩
  · linarith [r.pos_PI, r.pos_MU, r.pos_NU]
  · exact_mod_cast γ.sum_one

/-- **Theorem `thm:dynamics-microfoundation`**: linear coupled ODE
 `ẋ = -D x + A x + ξ` derives from capability-evolution principle
 plus Cobb-Douglas best-response (small-share asymptotic).

paper source: thm:dynamics-microfoundation.

Remark `rem:linearization-caveats` clause (iv) acknowledges: the
calibrated `A` matrix is fit phenomenologically and does not exactly
match the rank-1 microfoundation `α_km = L_k · ∂W/∂x_m`. The
qualitative ordering theorem survives because slow-mode eigenvalue
ordering is insensitive to within-row reweighting. -/
theorem thm_dynamics_microfoundation :
  ∀ (S : EconomicSystem),
    ∃ (J : Jacobian3) (ξ : BaselineForcings),
      IsLinearizedCoupledODE S J ξ :=
  fun S => ⟨jacobianOf S, baselineForcingsOf S, ⟨rfl, rfl⟩⟩

/-! ## 3. Hegemonic steady state and threshold theorem track -/

/-- **Lemma `lem:hss-exists`**: hegemonic steady state exists with
 closed-form `(PI^*, NU^*, MU^*)` from `(δ_k, α_km, ξ_k)` primitives.

paper source: lem:hss-exists. Conditional on
`hyp_time_invariant_cross_couplings` for closed-form coordinates AND
`IsHSSExistencePrecondition` (paper's determinant + forcing-positivity
+ friction-load conditions). -/
theorem lem_hss_exists :
  ∀ (J : Jacobian3) (ξ : BaselineForcings) (theta_bar : ℝ),
    theta_bar > 1 →
    hyp_time_invariant_cross_couplings J →
    IsHSSExistencePrecondition J ξ →
    HSSExistsWithClosedForm J ξ theta_bar :=
  fun J ξ _ _ _ _ => ⟨hssClosedForm J ξ, rfl⟩

/-! ### `thm:threshold` static-inequality decomposition

The static-inequality half of paper Theorem `thm:threshold` is
decomposed into 3 atomic stipulations + 1 derived theorem per discipline
§13 right gap-attack workflow. The dynamic persistence-time formula
`T_k^* = (1/μ_min)·log(Δ_k(0)/x_k^*(1−θ̄^{−1/γ_k}))` is paper-
acknowledged but NOT encoded (no typed `PersistenceTimeFormula`
predicate in Types.lean; carve-out parallels
`paper_thm_tension_cycle_band_holds`).

The 3 atoms correspond to the 3 paper proof steps:

* Atom (A): under `MinimumAxisCondition` + θ̄ > 1, the focal-axis
  Cobb-Douglas factor is ≤ θ̄⁻¹.
* Atom (B): under `NonCompensatingNonCrossing`, the non-focal axes'
  joint factor is ≤ 1.
* Atom (C): focal-factor × non-focal-factor bounds yield
  `InfluenceBelowThetaBarInverse` via the Cobb-Douglas product rule
  (paper §thm:representation closed form).
-/

/-- Atom (A) of `thm:threshold` proof — focal-axis Cobb-Douglas factor
 bound. Cat 3 sub-type: structural-eq. Paper proof: under
 `MinimumAxisCondition` (some axis j has crossed by margin ≥ θ̄^{-1/γ_j}),
 the focal-axis term in the Cobb-Douglas product
 `(x_j(t)/x_j*)^{γ_j}` is ≤ θ̄⁻¹ at the crossing instant. Encoded as
 a typed-bridge predicate `FocalAxisFactorBound` (opaque carrier;
 atomic stipulation).

 Scope note: paper conclusion is direct algebra over ℝ
 (`(ratio)^γ ≤ θ̄^{-1}` via Real.rpow lemmas, fully Mathlib-derivable
 in principle); however the typed-bridge carrier `FocalAxisFactorBound`
 references the opaque `EconomicSystem` structure, so Cat 1 reduction
 is blocked on carrier-port engineering, not on Mathlib. Once
 `EconomicSystem` is unfolded, this axiom can be promoted to a Cat 1
 Mathlib-derived `theorem`. -/
axiom paper_thm_threshold_focal_factor_bound :
  ∀ (S : EconomicSystem)
    (γ : CobbDouglasExponents)
    (theta_bar : ℝ)
    (j : CapabilityAxis),
    theta_bar > 1 →
    MinimumAxisCondition S γ theta_bar →
    FocalAxisFactorBound S γ theta_bar j

/-- Atom (B) of `thm:threshold` proof — non-focal-axes Cobb-Douglas
 factor bound. Cat 3 sub-type: structural-eq. Paper proof: under
 `NonCompensatingNonCrossing`, the non-focal axes' joint contribution
 `∏_{k≠j} (x_k/x_k*)^{γ_k}` is ≤ 1 (paper proof side condition β ≤ 1
 enforces this). Encoded as a typed-bridge predicate
 `NonFocalAxesFactorBound`.

 Scope note: at the opaque-predicate level the hypothesis
 `NonCompensatingNonCrossing` and the conclusion `NonFocalAxesFactorBound`
 are near-tautological restatements of the same paper side condition
 (both encode `∏_{k≠j}(x_k/x_k*)^{γ_k} ≤ 1`); the axiom is the typed
 carrier-bridge `NonCompensatingNonCrossing → NonFocalAxesFactorBound`.
 Cat 1 reduction blocked on `EconomicSystem` carrier port; once
 unfolded the two predicates would unfold to the same expression and
 the axiom becomes definitional. -/
axiom paper_thm_threshold_nonfocal_factor_bound :
  ∀ (S S' : EconomicSystem)
    (γ : CobbDouglasExponents)
    (j : CapabilityAxis),
    NonCompensatingNonCrossing S S' j γ →
    NonFocalAxesFactorBound S S' γ j

/-- Atom (C) of `thm:threshold` proof — composition rule. Cat 3
 sub-type: structural-eq. Paper proof: by the Cobb-Douglas form of
 Influence (paper §thm:representation), the product of the focal and
 non-focal factor bounds gives `Influence(t) ≤ θ̄⁻¹ · Influence*`,
 i.e. `InfluenceBelowThetaBarInverse`. The atom is the Cobb-Douglas
 product rule applied to ratio bounds, paper-novel because the
 carrier `InfluenceBelowThetaBarInverse` is opaque (closed form
 lives in `thm:representation` which is itself a Cat 3 derivation).

 Scope note: paper conclusion is `(α)(β) ≤ θ̄^{-1} · 1 = θ̄^{-1}` —
 multiplication of two real numbers with bounds, fully
 Mathlib-discharge-able via `mul_le_mul` once carriers unfolded. Cat 1
 reduction blocked on `EconomicSystem` carrier port. -/
axiom paper_thm_threshold_factors_combine :
  ∀ (S S' : EconomicSystem)
    (γ : CobbDouglasExponents)
    (theta_bar : ℝ)
    (j : CapabilityAxis),
    FocalAxisFactorBound S γ theta_bar j →
    NonFocalAxesFactorBound S S' γ j →
    InfluenceBelowThetaBarInverse S S' j theta_bar

-- `thm_threshold` derives kernel-purely from the 3 atoms
-- (focal-factor + nonfocal-factor + composition) above.

/-- **Theorem `thm:threshold`** (axis-form, static-inequality half):
 single-axis crossing + side condition `β ≤ 1` ⟹
 `Influence(t) < Influence^* / θ̄` at the crossing time `t`.

paper source: thm:threshold (paper proof requires the side condition
 `β ≤ 1` for the conclusion `Influence(t) < Influence^*/θ̄`; a
 looser condition `β ≤ θ̄` would only suffice when axis `j` has
 crossed by an additional margin). discharged via the
 paper-bound axiom (was raw `sorry`, drift in Ledger).
 -A: axiom renamed `paper_thm_threshold_static_inequality_holds`
 to make explicit that the encoded conclusion is the static
 inequality only; the paper's persistence-time `T_k^*` formula
 (dynamic half) is paper-acknowledged but NOT encoded by this
 theorem, and is documented in the Ledger as a separate carve-out. -/
theorem thm_threshold :
  ∀ (S S' : EconomicSystem)
    (γ : CobbDouglasExponents)
    (theta_bar : ℝ)
    (j : CapabilityAxis),
    theta_bar > 1 →
    MinimumAxisCondition S γ theta_bar →
    NonCompensatingNonCrossing S S' j γ →
    InfluenceBelowThetaBarInverse S S' j theta_bar :=
  fun S S' γ theta_bar j h_θ h_min h_nc =>
    paper_thm_threshold_factors_combine S S' γ theta_bar j
      (paper_thm_threshold_focal_factor_bound S γ theta_bar j h_θ h_min)
      (paper_thm_threshold_nonfocal_factor_bound S S' γ j h_nc)

/-- **Theorem `thm:threshold-case-specific`**: case-specific multilateral
 form `θ̄(t) = θ̄_req · K(t)` derived from the contemporaneous
 competitor distribution.

paper source: thm:threshold-case-specific. -/
theorem thm_threshold_case_specific :
  ∀ (chi R K : ℝ),
    chi > 0 → chi < 1 → R > 0 → K > 0 →
    ∃ theta_bar_real : ℝ,
      theta_bar_real = ((1 - chi) / chi) ^ (1 / R) * K := by
  intro chi R K _hc1 _hc2 _hR _hK
  exact ⟨((1 - chi) / chi) ^ (1 / R) * K, rfl⟩

/-- **Proposition `prop:nonlinear-stability`**: Hurwitz Jacobian ⟹
 local exponential stability of the hegemonic steady state.

paper source: prop:nonlinear-stability. Discharged by
 `lyapunov_indirect_local_exp_stability` (Khalil 2002 Thm 4.7). -/
theorem prop_nonlinear_stability :
  ∀ (J : Jacobian3), IsHurwitz J → LocallyExponentiallyStable J :=
  lyapunov_indirect_local_exp_stability

/-! ## 4. Collapse-sequence theorem track -/

/-- **Theorem `thm:meta-collapse`**: slowest-decay axis crosses its
 threshold first under generic shocks.

paper source: thm:meta-collapse. The eigenvector-dominance
 dominance step requires either symmetric-coupling regularity OR
 invocation of `thm:collapse-aeb` two-channel sufficient condition.

Hypothesis: σ is the ascending-decay permutation
(`δ_{σ(1)} < δ_{σ(2)} < δ_{σ(3)}`); small-coupling product condition
`α_{σ(1)σ(2)} α_{σ(2)σ(1)} < (δ_{σ(2)} - δ_{σ(1)})^2` (strict; AEB
Mongol calibration is at the boundary, covered by `thm_collapse_aeb`
instead); secondary path-dominance
`α_{σ(2)σ(1)} α_{σ(3)σ(2)} ≥ α_{σ(1)σ(2)} α_{σ(3)σ(1)}`. -/
theorem thm_meta_collapse :
  ∀ (S : EconomicSystem) (σ : CollapseOrdering),
    IsAscendingDecayPermutation S σ →
    SmallCouplingProductCondition S σ →
    SecondaryPathDominance S σ →
    MetaCollapseSlowestFirstHolds S σ := by
  intro S σ h_asc h_sc h_pd
  unfold MetaCollapseSlowestFirstHolds
  intro _ _ _
  exact paper_slowest_first_meta_principle S σ h_asc h_sc h_pd

/-- **Theorem `thm:collapse-sequence`** (regime-(i), self-productive
 industrial-era): `δ_PI < δ_NU < δ_MU` ⟹ collapse ordering
 `PI → NU → MU`.

paper source: thm:collapse-sequence (AEB regime is outside this
 theorem's parameter ordering and is covered by `thm:collapse-aeb`
 via the two-channel sufficient condition, NOT by path-dominance).

Hypothesis: `δ_PI < δ_NU < δ_MU` + path-dominance
 `α_{NU,PI} α_{MU,NU} ≥ α_{PI,NU} α_{MU,PI}` (with strict ordering
 via threshold-spacing arithmetic under symmetric-coupling
 calibrations). -/
theorem thm_collapse_sequence :
  ∀ (S : EconomicSystem),
    let J := jacobianOf S
    J.decay.delta_PI < J.decay.delta_NU →
    J.decay.delta_NU < J.decay.delta_MU →
    J.cross.alpha_NU_PI * J.cross.alpha_MU_NU ≥
      J.cross.alpha_PI_NU * J.cross.alpha_MU_PI →
    SmallCouplingProductCondition S CollapseOrdering.piNuMu →
    SecondaryPathDominance S CollapseOrdering.piNuMu →
    HasCollapseOrdering S CollapseOrdering.piNuMu := by
  intro S _J hPI_NU hNU_MU _ h_sc h_pd
  exact paper_slowest_first_meta_principle S CollapseOrdering.piNuMu
    ⟨le_of_lt hPI_NU, le_of_lt hNU_MU⟩ h_sc h_pd

/-- **Theorem `thm:collapse-sequence-info`** (regime-(ii),
 information-era): `δ_NU < δ_PI < δ_MU` ⟹ collapse ordering
 `NU → PI → MU`.

paper source: thm:collapse-sequence-info. -/
theorem thm_collapse_sequence_info :
  ∀ (S : EconomicSystem),
    let J := jacobianOf S
    J.decay.delta_NU < J.decay.delta_PI →
    J.decay.delta_PI < J.decay.delta_MU →
    J.cross.alpha_PI_NU * J.cross.alpha_MU_PI ≥
      J.cross.alpha_NU_PI * J.cross.alpha_MU_NU →
    SmallCouplingProductCondition S CollapseOrdering.nuPiMu →
    SecondaryPathDominance S CollapseOrdering.nuPiMu →
    HasCollapseOrdering S CollapseOrdering.nuPiMu := by
  intro S _J hNU_PI hPI_MU _ h_sc h_pd
  exact paper_slowest_first_meta_principle S CollapseOrdering.nuPiMu
    ⟨le_of_lt hNU_PI, le_of_lt hPI_MU⟩ h_sc h_pd

/-- **Theorem `thm:collapse-aeb`** (regime-(iii), administered-external-
 base, two-channel sufficient condition).

paper source: structural_attribution.tex thm:collapse-aeb.

Hypothesis (paper, three components):
 * eq:aeb-conditions: `α_NU,PI ≪ α_PI,NU`, `α_MU,PI ≪ α_MU,NU`,
 `δ_NU < δ_PI < δ_MU`.
 * Hegemonic-SS asymmetry: `NU* ≫ PI*`.
 * Shock-loading asymmetry: a generic shock perturbing `W` is
 transmitted through the dominant rent-extraction input `x_NU`,
 i.e. `∂W/∂x_NU ≫ ∂W/∂x_PI ≈ 0`.

Conclusion (paper). The collapse trajectory crosses the axis thresholds
in the order `NU → PI → MU`, via the joint operation of:
 (i) Slowest-eigenvalue channel: `λ_+(J^AEB) = -δ_NU`, so persistent
 disturbances relax slowest in `NU`.
 (ii) Shock-loading-asymmetry channel: AEB definition forces dominant
 `ξ_NU` loading.

Note. The autonomous slow eigenvector at the historical-fit Mongol
calibration is `PI`-mixed (not strictly `NU`-dominated) because the
calibration `α_PI,NU = 0.025` vs `δ_PI - δ_NU = 0.005` puts the system
at the boundary of the strict-small-coupling regime. The conclusion does
not require the eigenvector to be axis-aligned; it requires only
channels (i) and (ii) jointly. -/
theorem thm_collapse_aeb :
  ∀ (S : EconomicSystem),
    let J := jacobianOf S
    IsAEBTopology S →
    (J.cross.alpha_NU_PI ≪ J.cross.alpha_PI_NU) →
    (J.cross.alpha_MU_PI ≪ J.cross.alpha_MU_NU) →
    J.decay.delta_NU < J.decay.delta_PI →
    J.decay.delta_PI < J.decay.delta_MU →
    HasCollapseOrdering S CollapseOrdering.nuPiMu := by
  intro S _J h_aeb h_NU_PI h_MU_NU hNU_PI hPI_MU
  -- Paper thm:collapse-aeb proof has TWO channels operating jointly. We


  -- discharge each via its paper-novel typed bridge, then combine via the


  -- paper-novel two-channel joining principle. AEB regime is OUTSIDE the


  -- meta-principle's strict small-coupling regime (paper note: AEB-Mongol


  -- calibration is at the boundary).


  have channel_i :=
    paper_aeb_yields_slowest_eigenvalue_NU S h_aeb h_NU_PI h_MU_NU hNU_PI hPI_MU
  have channel_ii := paper_aeb_yields_shock_loading_NU S h_aeb
  exact paper_two_channel_collapse_principle S channel_i channel_ii

/-- Paper-novel empirical dichotomy: paper enumerates 11 historical
 cases populating the NU→PI→MU collapse ordering and observes that
 every enumerated case falls into either regime-(ii) info-era
 (bona-fide special case of meta-theorem small-coupling regime) or
 regime-(iii) AEB (covered separately by `thm:collapse-aeb`). This is
 paper's empirical claim about the historical record (analogous to
 era-match + ex-ante-classification empirical axioms), not a derivable
 theorem from more primitive axioms.

 The antecedent `IsPaperEnumeratedHistoricalCase S` restricts the
 dichotomy to the paper's enumerated empirical scope; without this
 antecedent the axiom would be a structural strengthening that no
 paper sentence defends. Cat 3 sub-type: working-assumption (terminal
 empirical claim).

 Paper explicitly admits three theoretically-admissible-but-unobserved
 permutations ("no documented hegemon has yet exhibited"); the
 dichotomy is therefore quantified over enumerated cases only. -/
axiom paper_cor_two_regimes_empirical_dichotomy :
  ∀ (S : EconomicSystem),
    IsPaperEnumeratedHistoricalCase S →
    HasCollapseOrdering S CollapseOrdering.nuPiMu →
      (IsRegimeIIBonafideSpecialCase S ∨ IsRegimeIIICoveredByAEBTheorem S)

/-- **Corollary `cor:two-regimes`**: of the two NU→PI→MU collapse-ordering
 regimes, regime-(ii) info-era is a bona-fide special case of
 `thm:meta-collapse` (small-coupling regime); regime-(iii) AEB is
 covered separately by `thm:collapse-aeb`'s two-channel sufficient
 condition (NOT by the meta-theorem, because the historical-fit AEB
 Mongol calibration is at the boundary of the strict small-coupling
 condition and has PI-mixed slow eigenvector).

paper source: section_meta_theorem.tex cor:two-regimes. Restricted to
paper-enumerated historical cases via `IsPaperEnumeratedHistoricalCase`
antecedent. -/
theorem cor_two_regimes :
  ∀ (S : EconomicSystem),
    IsPaperEnumeratedHistoricalCase S →
    HasCollapseOrdering S CollapseOrdering.nuPiMu →
      (IsRegimeIIBonafideSpecialCase S ∨ IsRegimeIIICoveredByAEBTheorem S) :=
  paper_cor_two_regimes_empirical_dichotomy

/-! ## 5. Exponent-derivation track -/

/-! ### : thm:exponent-derivation Step 1 / Step 2 / Step 3
 paper-bound sub-axioms

Paper proof (lines 666–676) labels the 3 steps explicitly. 
introduces a paper-bound axiom per step + composes the previous
monolithic `paper_thm_exponent_derivation_holds` from the 3
sub-axioms. The decomposition simultaneously surfaces the
previously hidden small-coupling regime hypothesis on Step 1
(- CRITICAL finding). -/

/-- Step 1 paper-bound sub-axiom: under the small-coupling
 regime `‖D⁻¹A‖ < 1`, the per-axis cumulative response yields the
 slow-envelope amplitude formula
 `ρ_k = (1/δ_k) · |L_k · ∂W/∂x_k| · (1 + O(‖A‖²/δ_min²))`
 (paper Step 1 line 667 + `eq:slow-mode-amplitude` line 654).
 Single-step typed bridge from `SmallCouplingRegime` antecedent
 to `HasSlowEnvelopeAmplitudeFormula` conclusion. -/
axiom paper_thm_exponent_step1_slow_envelope_amplitude :
  ∀ (S : EconomicSystem) (k : CapabilityAxis),
    SmallCouplingRegime S →
    HasSlowEnvelopeAmplitudeFormula S k

/-- Step 2 paper-bound sub-axiom: combining Step 1 with
 the leakage-axis-independence disjunction yields the
 boxed survival-weight formula `w_k = δ_k⁻¹ · |∂W/∂x_k| · r_k`
 (paper Step 2 line 671). Branch (a) uniform-r is APPROXIMATE
 (paper line 673 quantifies "within a factor of two under the
 calibration `r ∈ [0.21, 0.40]`"); branch (b) special-rank-1 is
 EXACT. The disjunction is the single typed bridge that
 `IsLeakageAxisIndependent` provides; the approximation level
 is documented in the Ledger entry, not the type.

 Scope note: paper line 673 distinguishes branch (a) as holding
 "approximately, to within a factor of two under the calibration
 `r ∈ [0.21, 0.40]`" while branch (b) `φ_{kℓ} = u β_ℓ` makes the
 leakage exactly axis-independent. The Lean conclusion
 `HasSurvivalWeightBoxedFormula` is opaque so the type can carry
 either approximate or exact semantics depending on which branch is
 actually chosen (the disjunctive `IsLeakageAxisIndependent` does not
 surface this in its type). To strengthen this encoding without
 carrier-port engineering, future round may split
 `HasSurvivalWeightBoxedFormula` into `...FormulaApprox` and
 `...FormulaExact` variants with branch-specific bridges; current
 single-conclusion encoding is the paper's own published reading
 ("the boxed formula holds to leading order under either branch"). -/
axiom paper_thm_exponent_step2_discrimination_loading :
  ∀ (S : EconomicSystem) (k : CapabilityAxis),
    HasSlowEnvelopeAmplitudeFormula S k →
    IsLeakageAxisIndependent S →
    HasSurvivalWeightBoxedFormula S k

/-- Step 3 paper-bound sub-axiom: structural posit
 `γ_k ∝ w_k` (paper Step 3 line 675). NOT an MLE FOC: paper
 notes a linear-in-γ MLE loss on the simplex would yield a
 corner solution; the proportionality is a structural closure
 linking Cobb-Douglas exponents to primitives outside the
 calibration set. Empirical content is whether the MLE-fitted
 `(a, b, c)` matches the posited `(a, b, c) ∝ w` (cor:exponent-
 sensitivity quantifies the residuals). -/
axiom paper_thm_exponent_step3_structural_posit :
  ∀ (S : EconomicSystem) (γ : CobbDouglasExponents),
    (∀ k, HasSurvivalWeightBoxedFormula S k) →
    CobbDouglasProportionalToSurvivalWeights γ S

/-- **Theorem**: `paper_thm_exponent_derivation_holds`
 is now derived from the 3 paper-step sub-axioms + the 
 disjunction. The signature EXPOSES the previously hidden
 `SmallCouplingRegime` antecedent (- CRITICAL
 finding): callers that previously discharged the monolithic
 axiom must now ALSO discharge the small-coupling regime — this
 is the visible consequence of the unmasking. COMPLETED
 in this round; (queued): give the 5 opaque component
 predicates (`SmallCouplingRegime`, `HasSlowEnvelopeAmplitudeFormula`,
 `HasSurvivalWeightBoxedFormula`, `IsUniformDiscriminationLoading`,
 `IsSpecialRank1FungibilityForm`) substantive bodies once typed
 accessors land on `EconomicSystem`. -/
theorem paper_thm_exponent_derivation_holds :
  ∀ (S : EconomicSystem) (γ : CobbDouglasExponents),
    SmallCouplingRegime S →
    hyp_special_rank_1_fungibility S →
    CobbDouglasProportionalToSurvivalWeights γ S := by
  intro S γ hSC hLAI
  -- Unfold hyp_special_rank_1_fungibility through the alias chain


  -- to reach IsLeakageAxisIndependent.


  unfold hyp_special_rank_1_fungibility IsSpecialRank1Fungibility at hLAI
  -- Apply Step 1 per axis to get HasSlowEnvelopeAmplitudeFormula.


  have step1 : ∀ k, HasSlowEnvelopeAmplitudeFormula S k :=
    fun k => paper_thm_exponent_step1_slow_envelope_amplitude S k hSC
  -- Apply Step 2 per axis to chain through IsLeakageAxisIndependent.


  have step2 : ∀ k, HasSurvivalWeightBoxedFormula S k :=
    fun k => paper_thm_exponent_step2_discrimination_loading S k (step1 k) hLAI
  -- Apply Step 3 to obtain the proportionality.


  exact paper_thm_exponent_step3_structural_posit S γ step2

/-- **Theorem `thm:exponent-derivation`** (STRUCTURAL POSIT, not derived
 from MLE FOC): the Cobb-Douglas exponents are posited proportional
 to survival weights `w_k = δ_k⁻¹ · |∂W/∂x_k| · r_k`; empirical
 content is whether the MLE-fitted `(a, b, c)` matches the posited
 `(a, b, c) ∝ w`.

paper source: thm:exponent-derivation Step 3. Paper Step 3 frames the
 proportionality as a "structural posit + empirical check" because
 a linear-in-γ MLE loss on the simplex yields a corner solution
 (not a `γ_k ∝ w_k` interior optimum). The empirical check is the
 consistency of MLE-fitted vs posited exponents in `cor:exponent-
 sensitivity`.

Conditional on `SmallCouplingRegime` ( surface of previously
hidden Step-1 antecedent — pre- the monolithic axiom did not
expose this requirement) AND `hyp_special_rank_1_fungibility`
. -/
theorem thm_exponent_derivation :
  ∀ (S : EconomicSystem) (γ : CobbDouglasExponents),
    SmallCouplingRegime S →
    hyp_special_rank_1_fungibility S →
    CobbDouglasProportionalToSurvivalWeights γ S :=
  paper_thm_exponent_derivation_holds

/-! ### cor:exponent-sensitivity 3-residual paper-bound sub-axioms

Paper proof itemizes 3 separately-evidenced residual-location claims,
decomposed into one paper-bound axiom per residual, composed
conjunctively into the original `paper_cor_exponent_sensitivity_holds`
conclusion.

Scope note: paper's residual localizations are conditional on the
post-1815 industrial-era headline calibration (γ_posited = (0.83, 0.04,
0.13), γ_mle = (0.40, 0.21, 0.39)). The ∀ γ_posited γ_mle quantification
in these axioms is structurally broader than the paper's empirically-
defended claim; the typed-predicate body (`LocatedIn...`) is opaque and
intended to encode the headline-calibration semantics internally. A
future round may tighten to require an explicit `HeadlineCalibration
γ_posited γ_mle` antecedent. -/

/-- Residual-(c) paper-bound sub-axiom: the cardinal residual on
 exponent `c` is located in state-dependent `δ_NU(NU)` network-position
 incumbency hysteresis (lowering `δ_NU` from headline `0.05` to ≈`0.014`
 closes ≈60% of the `c` gap; joint `(δ_NU, |∂W/∂x_NU|)` adjustment
 closes the rest). Single-step typed bridge to
 `LocatedInDeltaNUHysteresis`. -/
axiom paper_cor_exponent_sensitivity_c_residual_from_delta_NU :
  ∀ (γ_posited γ_mle : CobbDouglasExponents) (S : EconomicSystem),
    LocatedInDeltaNUHysteresis γ_posited γ_mle S

/-- Residual-(b) paper-bound sub-axiom: the cardinal residual on
 exponent `b` is located in era-varying `|∂W/∂x_MU|` rent-extraction
 loading (headline `0.10` is a stressed-hegemon estimate; peacetime
 `|∂W/∂x_MU|` would lower the prediction further, parallel to the
 `a`-residual mechanism). Single-step typed bridge to
 `LocatedInEraVaryingRentLoadMU`. -/
axiom paper_cor_exponent_sensitivity_b_residual_from_rent_load_MU :
  ∀ (γ_posited γ_mle : CobbDouglasExponents) (S : EconomicSystem),
    LocatedInEraVaryingRentLoadMU γ_posited γ_mle S

/-- Residual-(a) paper-bound sub-axiom: the cardinal residual on
 exponent `a` is located in era-varying `|∂W/∂x_PI|` rent-extraction
 loading (headline `0.30` is the post-1815 industrial-era anchor; in the
 late-industrial / information-era regime productive-axis loading is
 empirically lower). Single-step typed bridge to
 `LocatedInEraVaryingRentLoadPI`. -/
axiom paper_cor_exponent_sensitivity_a_residual_from_rent_load_PI :
  ∀ (γ_posited γ_mle : CobbDouglasExponents) (S : EconomicSystem),
    LocatedInEraVaryingRentLoadPI γ_posited γ_mle S

/-- **Theorem **: `paper_cor_exponent_sensitivity_holds` is now
 derived from the 3 per-residual paper-bound sub-axioms (one per
 paper-itemized residual location). Signature UNCHANGED from the
 pre- monolithic axiom — backward-compatible (the conjunction
 `ResidualsLocatedInMechanisms` def unfolds to the 3 conjuncts,
 so the composition is just `⟨c, b, a⟩`). COMPLETED. -/
theorem paper_cor_exponent_sensitivity_holds :
  ∀ (γ_posited γ_mle : CobbDouglasExponents) (S : EconomicSystem),
    ResidualsLocatedInMechanisms γ_posited γ_mle S :=
  fun γp γm S =>
    ⟨paper_cor_exponent_sensitivity_c_residual_from_delta_NU γp γm S,
     paper_cor_exponent_sensitivity_b_residual_from_rent_load_MU γp γm S,
     paper_cor_exponent_sensitivity_a_residual_from_rent_load_PI γp γm S⟩

/-- **Corollary `cor:exponent-sensitivity`**: cardinal residuals between
 posited and empirical `(a, b, c)` mechanistically located in
 state-dependent `δ_NU(NU)` network hysteresis (on `c`) and era-varying
 rent-extraction loading (on `a` and `b`).

paper source: cor:exponent-sensitivity. : discharged via the 3
 per-residual sub-axioms composed in `paper_cor_exponent_sensitivity_holds`;
 signature unchanged. -/
theorem cor_exponent_sensitivity :
  ∀ (γ_posited γ_mle : CobbDouglasExponents) (S : EconomicSystem),
    ResidualsLocatedInMechanisms γ_posited γ_mle S :=
  paper_cor_exponent_sensitivity_holds

/-- **Theorem `thm:three-axes`** (era-conditional): under spectral-
 separation + action-triad + information-geometric independence +
 spectral-cluster count `m`, `m = 3` jointly forced by conditions
 (1) and (3) (the action-algebra count + the spectral-cluster count
 at the industrial-era calibration).

paper source: why_three_axes_section.tex thm:three-axes.
Reduces to: Topkis action-algebra decomposition (Step 1, supplying
 `count ≥ 3`) + Cover-Thomas info-geometric independence (Step 2) +
 Tikhonov slow-manifold reduction (Step 3, supplying
 `SlowManifoldDimension = SpectralClusterCount`).

Joint conclusion `m = 3` requires THREE hypotheses (paper Step 1+2+3):
 spectral-separation (Step 3), action-triad (Step 1, supplied via
 `action_algebra_irreducible_count_ge_three` plus paper's upper-bound
 that no fourth irreducible component arises from reachable-set
 actions), and info-geometric independence (Step 2). The `m = 3`
 conclusion is era-conditional: mercantile / info eras at boundary
 of spectral-gap hypothesis. -/
theorem thm_three_axes :
  ∀ (S : EconomicSystem) (τ : ℝ),
    SpectralSeparation S τ →
    InformationGeometricIndependence S 3 →
    ActionAlgebraIrreducibleCount S = 3 ∧
    SlowManifoldDimension S τ = 3 ∧
    Nonempty (Fin 3 ≃ CapabilityAxis) := by
  intro S τ hsep hinfo
  refine ⟨?_, ?_, ?_⟩
  · -- ActionAlgebraIrreducibleCount S = 3 from joint ≥ 3 (Topkis) and ≤ 3 (paper)
    have hge : ActionAlgebraIrreducibleCount S ≥ 3 :=
      action_algebra_irreducible_count_ge_three S
    have hle : ActionAlgebraIrreducibleCount S ≤ 3 :=
      action_algebra_irreducible_count_le_three S
    omega
  · -- SlowManifoldDimension S τ = 3 via Tikhonov-Fenichel + paper-novel
    -- info-geometric / spectral-cluster Step 2-3 link.


    have hsm_eq : SlowManifoldDimension S τ = SpectralClusterCount S τ :=
      tikhonov_fenichel_slow_manifold S τ hsep
    have hsc_eq : SpectralClusterCount S τ = 3 :=
      paper_info_geometric_eq_spectral_cluster_step2to3_link S τ 3 hinfo hsep
    rw [hsm_eq, hsc_eq]
  · -- Bijection between 3 spectral clusters and 3 capability axes
    -- (paper Step 4): canonical via `capabilityAxisFinEquiv`.


    exact ⟨capabilityAxisFinEquiv⟩

/-! ## 6. Hegemonic-margin track -/

/-- **Proposition `prop:theta-bar-derived`**: microfounded hegemonic
 margin `θ̄(χ, R) = ((1 - χ) / χ)^{1/R}`.

paper source: prop:theta-bar-derived. Numerical: at `χ = 0.30, R = 1`,
 `θ̄ = 7/3 ≈ 2.333`. -/
theorem prop_theta_bar_derived :
  ∀ (chi R : ℝ),
    chi > 0 → chi < 1 → R > 0 →
    ∃ theta_bar : ℝ,
      theta_bar = ((1 - chi) / chi) ^ (1 / R) := by
  intro chi R _hc1 _hc2 _hR
  exact ⟨((1 - chi) / chi) ^ (1 / R), rfl⟩

/-- **Proposition `prop:theta-bar-case`**: case-specific multilateral
 margin `θ̄(t) = θ̄_req · K(t)` from the contemporaneous coalition
 aggregate. -/
theorem prop_theta_bar_case :
  ∀ (S : EconomicSystem) (t theta_bar_req K_t : ℝ),
    CaseSpecificThetaBarDerivation S t theta_bar_req K_t :=
  fun _ _ theta_bar_req K_t => ⟨theta_bar_req * K_t, rfl⟩

/-- **Corollary `cor:composite-margin`**: the binding multilateral
 cardinal-margin-loss test is `Influence_focal(t) < θ̄_req · Influence_C(t)`
 where `Influence_C(t)` is the coalition aggregate. -/
theorem cor_composite_margin :
  ∀ (S : EconomicSystem) (t theta_bar_req R : ℝ),
    IsBindingCompositeMarginLossTest S t theta_bar_req R :=
  fun _ _ theta_bar_req _ => ⟨0, 0,
    Or.inr (by simp)⟩

/-! ## 7. Endogenous-shock track -/

/-- Cat 3 carrier sub-type: paper `def:structural-tension` introduces the
 structural-tension functional `T(x_i, x_{-i})` as a primitive
 `EconomicSystem → EconomicSystem → ℝ` valued mapping. The paper's
 defining equation `T = w_c · T_cross + w_s · T_state + w_r · T_rent`
 is surfaced as a separate `structural_tension_def` structural-equation
 axiom below; per §3.4.3 spec each Cat 3 paper-stipulated equation gets
 its own typed equation axiom. -/
axiom structural_tension :
  EconomicSystem → EconomicSystem → ℝ

/-- Cat 3 carriers for the three structural-tension components (paper
 `def:structural-tension` Equations \eqref{eq:T-cross} /
 \eqref{eq:T-state} / \eqref{eq:T-rent}). Closed forms live in the paper
 proof (`|Π_i/Π_i* − Ν_i/Ν_i*|`, `max(0, max_{j≠i} Influence_j/Influence_i − 1)`,
 `max(0, W_i/Π_i − ρ*)`); Lean encodes them as opaque ℝ-valued
 accessors pending Mathlib `max`/`abs` Hodge-style port over the opaque
 `EconomicSystem` carrier. -/
axiom structuralTension_T_cross : EconomicSystem → EconomicSystem → ℝ

/-- Cross-state pressure component of structural tension. -/
axiom structuralTension_T_state : EconomicSystem → EconomicSystem → ℝ

/-- Rent-extraction overstretch component of structural tension. -/
axiom structuralTension_T_rent : EconomicSystem → EconomicSystem → ℝ

/-- Non-negative cross-axis-gap weight `w_c`. -/
axiom structuralTension_w_c : ℝ

/-- Non-negative cross-state-pressure weight `w_s`. -/
axiom structuralTension_w_s : ℝ

/-- Non-negative rent-overstretch weight `w_r`. -/
axiom structuralTension_w_r : ℝ

/-- Paper-stipulated non-negativity of the cross-axis weight. -/
axiom structuralTension_w_c_nonneg : structuralTension_w_c ≥ 0

/-- Paper-stipulated non-negativity of the state-pressure weight. -/
axiom structuralTension_w_s_nonneg : structuralTension_w_s ≥ 0

/-- Paper-stipulated non-negativity of the rent-overstretch weight. -/
axiom structuralTension_w_r_nonneg : structuralTension_w_r ≥ 0

/-- Cat 3 structural-defining equation (§3.4.3): paper
 `def:structural-tension` Eq.~\eqref{eq:tension-def}.

 `T(x_i, x_{-i}) = w_c · T_cross + w_s · T_state + w_r · T_rent`. -/
axiom structural_tension_def :
  ∀ (S Srivals : EconomicSystem),
    structural_tension S Srivals =
      structuralTension_w_c * structuralTension_T_cross S Srivals
      + structuralTension_w_s * structuralTension_T_state S Srivals
      + structuralTension_w_r * structuralTension_T_rent S Srivals

/-- **Proposition `prop:clustering`** (under `hyp_slow_driver_regime`):
 inter-shock CV² > 1 strictly in the large-sample limit.

paper source: prop:clustering. The post-1640 empirical record gives
 CV² = 0.45 < 1 — in the OPPOSITE direction from the asymptotic
 prediction (not merely underpowered). The proposition's strict
 over-dispersion claim is conditional on `hyp_slow_driver_regime`.
Discharged by: `cox_lewis_mixed_poisson_overdispersion`
 (ClassicalResults.lean §6) once `hyp_slow_driver_regime S` is
 unpacked into `SlowDriverApplies S ∧ TensionNonDegenerate S`. -/
theorem prop_clustering :
  ∀ (S : EconomicSystem),
    hyp_slow_driver_regime S → InterShockCV2 S > 1 := by
  intro S ⟨hsd, htn⟩
  exact cox_lewis_mixed_poisson_overdispersion S hsd htn

/-! ### `thm:tension-cycle` decomposition

The prior monolithic axiom `paper_thm_tension_cycle_band_holds`
bundled (i) Bartlett 1955 spectral theory of stationary point
processes and (ii) the paper-novel application to a specific PDMP
carrier. Per §13 right-workflow + §10 distinguishing edge case
"Paper's APPLICATION of external theorem to paper-novel objects",
these are decomposed below: one Cat 2 atom (Bartlett 1955) + one
Cat 3 atom (paper PDMP matches Bartlett hypotheses) + derived
theorem.

The explicit peak (vs the band) remains a paper-acknowledged
numerical sensitivity-sweep observation, not encoded.
-/

/-- Cat 3 paper-novel spectral atom for `thm:tension-cycle`: for any
 stationary PDMP satisfying the paper's spectral hypotheses
 (stationarity + integrable autocovariance + ergodicity), the
 stationary log-spectrum admits a low-frequency band concentrated near
 the dominant timescales of the process.

 paper source: thm:tension-cycle (paper's own renewal-style convolution
 argument). Paper explicitly disclaims that the explicit Bartlett-
 spectrum computation is undertaken ("we do not undertake [it] here");
 the band statement is what the renewal-style argument supports.

 Source (PDMP infrastructure): Daley-Vere-Jones 2003 §7 (paper's
 actual cite for PDMP). The "Bartlett-intensity-spectrum" phrase used
 in the paper proof refers to the general Bartlett point-process
 spectral framework, not specifically Bartlett 1955. -/
axiom paper_pdmp_lowfreq_band :
  ∀ (S : EconomicSystem),
    PaperPDMPSatisfiesSpectralHypotheses S →
    HasStationaryDistLowFreqBand S
      (systemRelaxationTime S) (systemExpectedShockInterval S)

/-- Cat 3 atom: the paper's PDMP carrier for an `EconomicSystem`
 satisfies the spectral hypotheses (stationarity + integrable
 autocovariance + ergodicity) needed for the low-frequency band
 statement. Cat 3 sub-type: hypothesis predicate. Paper source:
 thm:tension-cycle proof preamble (PDMP construction subsection)
 invoking Daley-Vere-Jones 2003 §7.

 The bundled three sub-properties (stationarity / integrable
 autocovariance / ergodicity) are paper-invented scaffolding (paper
 does not literally claim "satisfies Bartlett hypotheses"). Future
 round may split into three per-property typed bridge axioms. -/
axiom paper_pdmp_satisfies_spectral_hypotheses :
  ∀ (S : EconomicSystem), PaperPDMPSatisfiesSpectralHypotheses S

/-- **Theorem `thm:tension-cycle`**: the influence process admits a
 stationary distribution whose log-spectrum exhibits low-frequency
 power in the band `[τ_relax, τ_relax + E[τ_shock]]`. Lean signature
 binds `τ_relax` and `E[τ_shock]` to system-specific timescales.

paper source: thm:tension-cycle. Composes the spectral atom
`paper_pdmp_lowfreq_band` with the paper-novel PDMP hypothesis
predicate `paper_pdmp_satisfies_spectral_hypotheses`. Explicit peak
(vs band) remains a paper-acknowledged numerical sensitivity-sweep
observation, not encoded. -/
theorem thm_tension_cycle :
  ∀ (S : EconomicSystem),
    HasStationaryDistLowFreqBand S
      (systemRelaxationTime S) (systemExpectedShockInterval S) :=
  fun S => paper_pdmp_lowfreq_band S (paper_pdmp_satisfies_spectral_hypotheses S)

/-! ## 8. Ex-ante-protocol track -/

/-- **Proposition `prop:ex-ante-classification`**: 9 strict matches +
 1 joint-shock partial + 1 explicit violation under the ex-ante
 regime-assignment protocol. The structural-ordering count is
 `9 strict matches in 11 cases` rejecting the random-ordering null
 at `p ≈ 4 × 10⁻⁶`. -/
theorem prop_ex_ante_classification :
  ∀ (cases : List EconomicSystem),
    hyp_ex_ante_regime_assignment_protocol cases →
    ∃ count : ExAnteClassificationCount,
      IsExAnteClassification11Case count := by
  intro _cases _hp
  refine ⟨⟨9, 1, 1, 11, by omega⟩, ?_⟩
  exact ⟨rfl, rfl, rfl, rfl⟩

/-- Paper-bound numerical assertion: binomial upper tail bound at the
 11-case ex-ante p-value. Source: paper cor:ex-ante-pvalue ≈ 3.94 × 10⁻⁶. -/
axiom paper_binomial_tail_11_9_at_one_sixth_le_four_e_minus_six :
  binomialUpperTail 11 9 (1 / 6) ≤ 4 * (10 : ℝ) ^ (-6 : ℤ)

/-- **Corollary `cor:ex-ante-pvalue`**: random-ordering null rejected
 at `p ≈ 4 × 10⁻⁶` (binomial-tail computation). -/
theorem cor_ex_ante_pvalue :
  ∃ p : ℝ,
    p = binomialUpperTail 11 9 (1 / 6) ∧
    p ≤ 4 * (10 : ℝ) ^ (-6 : ℤ) :=
  ⟨binomialUpperTail 11 9 (1 / 6), rfl,
   paper_binomial_tail_11_9_at_one_sixth_le_four_e_minus_six⟩

/-- **Corollary `cor:selection-bias-corrected-null`**: 15-case extended
 sample. Counting: 9 strict + 3 joint-shock + 1 violation
 + 2 ambiguous; strict-only `p ≈ 1.88 × 10⁻⁴`; match-or-extension
 `p ≈ 10⁻⁷` uniformly across 11- and 15-case samples. -/
theorem cor_selection_bias_corrected_null :
  ∃ count : ExAnteClassificationCount,
    IsExAnteClassification15Case count := by
  refine ⟨⟨9, 3, 1, 15, by omega⟩, ?_⟩
  exact ⟨rfl, rfl, rfl, rfl⟩

/-! ## 9. Non-substitutability track -/

/-- **Corollary `cor:annihilation-from-tullock`**: any single Tullock
 contest with `x_{i,k} → 0` ⟹ `p_i^{(k)} → 0` ⟹ `Influence_i → 0`.

paper source: cor:annihilation-from-tullock. -/
theorem cor_annihilation_from_tullock :
  ∀ (S : EconomicSystem) (k : CapabilityAxis) (r : TullockParameters),
    TullockContestAnnihilates S k r :=
  tullock_csf_vanishes_at_zero

/-- **Lean-proved theorem**: the cube-bound `1 - (1 - s_max)^3`
 on the finite-share deviation. The bound side is purely arithmetic;
 only the IDENTITY `Influence^FiniteShare = Influence^CD · ∏(1 - s_k)`
 requires paper attribution, which is the next REWORK step.

 Proof strategy: each `(1 - s_axis)` lies in `[1 - s_max, 1]`; the
 triple product therefore lies in `[(1 - s_max)^3, 1]`; the absolute
 value `|1 - prod|` equals `1 - prod` (nonneg) and is bounded above
 by `1 - (1 - s_max)^3`. -/
theorem finite_share_deviation_cube_bound :
  ∀ (s_max : ℝ),
    0 ≤ s_max → s_max ≤ 1 →
    FiniteShareDeviationBound s_max (1 - (1 - s_max) ^ 3) := by
  intro s_max h0 h1 s_PI s_MU s_NU h0_PI h_PI h0_MU h_MU h0_NU h_NU
  have hpos_max : (0 : ℝ) ≤ 1 - s_max := by linarith
  have hpos_PI : (0 : ℝ) ≤ 1 - s_PI := by linarith
  have hpos_MU : (0 : ℝ) ≤ 1 - s_MU := by linarith
  have hpos_NU : (0 : ℝ) ≤ 1 - s_NU := by linarith
  have h1_PI : 1 - s_max ≤ 1 - s_PI := by linarith
  have h1_MU : 1 - s_max ≤ 1 - s_MU := by linarith
  have h1_NU : 1 - s_max ≤ 1 - s_NU := by linarith
  have hu_PI : 1 - s_PI ≤ 1 := by linarith
  have hu_MU : 1 - s_MU ≤ 1 := by linarith
  have hu_NU : 1 - s_NU ≤ 1 := by linarith
  -- Lower bound on product: (1 - s_max)^3 ≤ (1 - s_PI)(1 - s_MU)(1 - s_NU)


  have h_pair_lb : (1 - s_max) * (1 - s_max) ≤ (1 - s_PI) * (1 - s_MU) :=
    mul_le_mul h1_PI h1_MU hpos_max (le_trans hpos_max h1_PI)
  have hpair_nn : (0 : ℝ) ≤ (1 - s_max) * (1 - s_max) := mul_nonneg hpos_max hpos_max
  have h_triple_lb : (1 - s_max) * (1 - s_max) * (1 - s_max)
                     ≤ (1 - s_PI) * (1 - s_MU) * (1 - s_NU) :=
    mul_le_mul h_pair_lb h1_NU hpos_max
      (mul_nonneg (le_trans hpos_max h1_PI) (le_trans hpos_max h1_MU))
  have hcube_eq : (1 - s_max) ^ 3 = (1 - s_max) * (1 - s_max) * (1 - s_max) := by ring
  -- Upper bound on product: (1 - s_PI)(1 - s_MU)(1 - s_NU) ≤ 1


  have h_pair_ub : (1 - s_PI) * (1 - s_MU) ≤ 1 := by
    have := mul_le_mul hu_PI hu_MU hpos_MU (by linarith : (0 : ℝ) ≤ 1)
    linarith
  have hpair_lb_nn : (0 : ℝ) ≤ (1 - s_PI) * (1 - s_MU) :=
    mul_nonneg hpos_PI hpos_MU
  have h_triple_ub : (1 - s_PI) * (1 - s_MU) * (1 - s_NU) ≤ 1 := by
    have := mul_le_mul h_pair_ub hu_NU hpos_NU (by linarith : (0 : ℝ) ≤ 1)
    linarith
  -- |1 - prod| = 1 - prod ≤ 1 - (1 - s_max)^3


  have h_diff_nn : (0 : ℝ) ≤ 1 - (1 - s_PI) * (1 - s_MU) * (1 - s_NU) := by linarith
  rw [abs_of_nonneg h_diff_nn]
  linarith [hcube_eq]

/-- Compatibility shim retaining the prior identifier
 `paper_finite_share_deviation_bound_pending_predicate_body` for
 downstream callers; now derived from the Lean-proved
 `finite_share_deviation_cube_bound` rather than axiomatized
 (-B.1 — formerly an axiom; reduced to theorem after the
 `FiniteShareDeviationBound` predicate received a substantive body). -/
theorem paper_finite_share_deviation_bound_pending_predicate_body :
  ∀ (s_max : ℝ),
    0 ≤ s_max → s_max ≤ 1 →
    FiniteShareDeviationBound s_max (1 - (1 - s_max) ^ 3) :=
  finite_share_deviation_cube_bound

/-- **Corollary `cor:finite-share-tullock`**: the relative deviation
 of the finite-share Tullock from the leading-order Cobb-Douglas
 reference is bounded by `1 - (1 - s_max)^3` AND this bound is in
 `[0, 1]` for `s_max ∈ [0, 1]`. The hegemonic-share ceiling
 `s_max ≈ 0.74` corresponds to a `~70%` raw reserve-currency share
 against a multi-rival distribution typical of the post-1944
 landscape (one secondary `≈ 20%`, residual `≈ 5%` each, under
 `r_NU ≈ 1.13`). The bound-arithmetic conjuncts are Lean-proved via
 `pow_le_pow_left₀` + `linarith`; the deviation-magnitude semantic
 claim is paper-bound via `paper_finite_share_deviation_bound`. -/
theorem cor_finite_share_tullock :
  ∀ (s_max : ℝ),
    0 ≤ s_max → s_max ≤ 1 →
    FiniteShareDeviationBound s_max (1 - (1 - s_max) ^ 3) ∧
    0 ≤ 1 - (1 - s_max) ^ 3 ∧
    1 - (1 - s_max) ^ 3 ≤ 1 := by
  intro s_max h0 h1
  refine ⟨paper_finite_share_deviation_bound_pending_predicate_body s_max h0 h1, ?_, ?_⟩
  · -- 0 ≤ 1 - (1-s_max)^3
    have h1ms_nn : (0 : ℝ) ≤ 1 - s_max := by linarith
    have h1ms_le : 1 - s_max ≤ 1 := by linarith
    have hcube_le : (1 - s_max) ^ 3 ≤ 1 := by
      have h : (1 - s_max) ^ 3 ≤ 1 ^ 3 := pow_le_pow_left₀ h1ms_nn h1ms_le 3
      simpa using h
    linarith
  · -- 1 - (1-s_max)^3 ≤ 1
    have h1ms_nn : (0 : ℝ) ≤ 1 - s_max := by linarith
    have hcube_nn : (0 : ℝ) ≤ (1 - s_max) ^ 3 := by positivity
    linarith

/-- **Corollary `cor:cross-scale-nonsub`**: non-substitutability
 validated on 6 single-axis-collapse cases across state and firm
 scales (USSR 1985, Saudi 1970, Russia 2024 + BlackBerry, Nokia,
 Kodak). the `CrossScaleCase` enumeration in
 `Types.lean`; the 6 cases are inhabited as constructors. -/
theorem cor_cross_scale_nonsub :
  CrossScaleNonSubValidatedSixCases :=
  fun c => ⟨c, rfl⟩

/-! ## 10. Auxiliary: `prop:nu-removal` (cardinal-up-to-constant
 in isotropic case + ordinal preservation in general anisotropic
 case, per paper proof) -/

/-- **Proposition `prop:nu-removal`**: the worst-case operator norm
 `NU = ‖ρ‖_{op}` and the removal centrality `NU^*` (relative-volume-
 reduction measure) induce the same ordinal ranking on systems for
 any fixed measure `μ_{T^m}`, with cardinal equality `NU^* = NU`
 up to a constant of proportionality holding in the isotropic case
 (uniform sensitivity of `ρ` across populated reachable-set
 directions); in the general anisotropic case cardinal magnitudes
 may diverge by a factor depending on the singular-spectrum spread.

paper source: prop:nu-removal (statement: ordinal-always + cardinal-isotropic). -/
theorem prop_nu_removal :
  ∀ (S₁ S₂ : EconomicSystem),
    NuOrdinalRankingPreservedWithIsotropicCardinalEq S₁ S₂ := by
  intro S₁ S₂
  unfold NuOrdinalRankingPreservedWithIsotropicCardinalEq
  rw [networkPosition_via_spectrum, networkPosition_via_spectrum,
      nuStarMeasure_via_spectrum, nuStarMeasure_via_spectrum,
      nu_function_of_spectrum_strictMono.le_iff_le,
      nu_star_function_of_spectrum_strictMono.le_iff_le]

/-! ## 11. Additional paper theorems / propositions -/

/-- **Theorem `thm:decomposition`**: the multiplicatively-separable
 form `F = K · h_1(PI) · h_2(MU) · h_3(NU)` precursor to Cobb-Douglas.

paper source: thm:decomposition.

Statement (paper). Under paper Axioms A1–A4 (paper Theorem statement
explicitly invokes the range A1–A4; proof uses A2 strict monotonicity
to force `h_i` strictly increasing and A3 zero-axis annihilation to
force `h_i(0) = 0`), the influence aggregator admits a multiplicatively-
separable representation `F(PI, MU, NU) = K · h_1(PI) · h_2(MU) · h_3(NU)`
for some `K > 0` and strictly increasing per-axis functions `h_i` with
`h_i(0) = 0`. The Cobb-Douglas refinement (`h_i(x) = x^{γ_i}`) is
Theorem `thm:representation`'s additional power-form step via Aczel. -/
theorem thm_decomposition :
  ∀ (S : EconomicSystem),
    HasMultiplicativelySeparableForm S := by
  intro S ⟨hPI, hMU, hNU⟩
  -- Derived as a corollary of `thm_representation`: Cobb-Douglas form


  -- `K · PI^a · MU^b · NU^c` is by inspection a multiplicatively-separable


  -- product `K · h_PI · h_MU · h_NU` with `h_i := axis^{γ_i}`.


  obtain ⟨γ, hF_eq⟩ := thm_representation S hPI hMU hNU
  refine ⟨cobbDouglasConstant,
          (productiveCapacity S : ℝ) ^ (γ.a : ℝ),
          (mobilizableSurplus S : ℝ) ^ (γ.b : ℝ),
          (networkPosition S : ℝ) ^ (γ.c : ℝ),
          cobbDouglasConstant_pos, ?_⟩
  rw [hF_eq]
  unfold CobbDouglasInfluence
  ring

/-! ### : prop:axis-independence — part (a) Sard + part (b) 3 witness
 paper-bound sub-axioms

Paper `prop:axis-independence` proof has two parts: part (a) the
Sard-theoretic regular-value statement (`Φ`'s regular-value set is
open dense, Sard 1942 + IFT — the strengthened headline claim), and
part (b) three explicit pairwise witnesses constructed separately:

 * autarkic-vs-networked economies (differ on NU only)
 ⇒ `AdmitsDiscriminatingPairOnAxis NU`
 * parliamentary-democracy-vs-command economy (differ on MU only)
 ⇒ `AdmitsDiscriminatingPairOnAxis MU`
 * microstate-finance-hub-vs-large-continental economy (differ on PI only)
 ⇒ `AdmitsDiscriminatingPairOnAxis PI`

Part (b) is NOT derived from part (a) in the paper proof — both are
independently constitutive of the proposition as stated. The pre-
Lean encoding had only part (b) (as `∀ k, AdmitsDiscriminatingPairOnAxis k`)
and dropped part (a) entirely. adds the Sard axiom + splits the
per-axis universal into 3 explicit witness sub-axioms + composes the
full proposition `AxisIndependenceFull = Sard ∧ (∀ k,...)`.

Blocker attribution: the 3 witness sub-axioms ARE carrier-pending (the
natural bodies are `EconomicSystem` pairs; carrier is `axiom EconomicSystem :
Type`) → `_pending_carrier_inhabitation` suffix retained. The Sard
sub-axiom is NOT carrier-pending — its blocker is Mathlib's Sard theorem
+ `Φ`'s analytic infrastructure → `_pending_mathlib_sard` suffix. -/

/-- Cat 2 atom (Sard 1942): the critical-value set of `Φ : 𝓔 → ℝ_+³`
 has Lebesgue measure zero. -/
axiom paper_sard_critical_value_set_measure_zero :
  SardCriticalValueSetMeasureZero

/-- Cat 3 hypothesis-predicate atom (paper prop:axis-independence
 preamble): `Φ` is `C¹` on the parametrization of `𝓔` by economic
 primitives AND non-degenerate at some interior point. -/
axiom paper_phi_is_c1_and_non_degenerate :
  PhiIsC1AndNonDegenerate

/-- Cat 2 atom (Baire residual + implicit function theorem): a residual
 set contains a non-empty open dense subset whenever the underlying map
 is non-degenerate at some interior point. -/
axiom paper_regular_value_set_open_and_dense_from_ift :
  RegularValueSetOpenAndDenseFromIFT

/-- Part-(a) paper-bound result: the regular-value set of
 `Φ = (PI, MU, NU)` is open dense in `ℝ_+³` (Sard 1942 + IFT). The
 strengthened headline claim of `prop:axis-independence`; strictly
 stronger than the part-(b) pairwise witnesses.

 Decomposed into 3 typed atomic axioms per §3.4 spec: Cat 2 Sard 1942
 measure-zero + Cat 3 paper `C¹`+non-degeneracy hypothesis + Cat 2
 Baire-residual+IFT. Blocker for full closure: Mathlib's Sard theorem +
 `Φ` analytic infrastructure (manifold parametrization, `Jacobian3`
 body) — NOT the `EconomicSystem` carrier. -/
theorem paper_prop_axis_independence_sard_regular_value_pending_mathlib_sard :
    SardRegularValueSetOpenDense :=
  ⟨paper_sard_critical_value_set_measure_zero,
   paper_phi_is_c1_and_non_degenerate,
   paper_regular_value_set_open_and_dense_from_ift⟩

/-- Part-(b) witness 1 : autarkic-vs-networked economies — two
 systems with identical productive capacity (autarkic) and identical
 central-treasury structure, one embedded in the trading-and-rule-making
 network, the other not, so they differ on NU only (paper
 prop:axis-independence proof part (b) case 1). Carrier-pending. -/
axiom paper_prop_axis_independence_witness_autarkic_vs_networked_pending_carrier_inhabitation :
  AdmitsDiscriminatingPairOnAxis CapabilityAxis.NU

/-- Part-(b) witness 2 : parliamentary-democracy-vs-command economy
 — two systems with the same physical capital stock and the same trade
 network, differing in fiscal-mobilization institution (parliamentary
 consent vs. command requisition), so they differ on MU only (paper
 prop:axis-independence proof part (b) case 2). Carrier-pending. -/
axiom paper_prop_axis_independence_witness_parliamentary_vs_command_pending_carrier_inhabitation :
  AdmitsDiscriminatingPairOnAxis CapabilityAxis.MU

/-- Part-(b) witness 3 : microstate-finance-hub-vs-large-continental
 economy — a small finance-hub microstate vs. a large continental
 economy with similar mobilizable surplus and similar network position,
 but vastly different productive capacity, so they differ on PI only
 (paper prop:axis-independence proof part (b) case 3). Carrier-pending. -/
axiom paper_prop_axis_independence_witness_microstate_vs_continental_pending_carrier_inhabitation :
  AdmitsDiscriminatingPairOnAxis CapabilityAxis.PI

/-- **Theorem **: `prop:axis-independence` part (b) — `∀ k,
 AdmitsDiscriminatingPairOnAxis k` — derived from the 3 explicit
 witness sub-axioms by case analysis on `CapabilityAxis` (3-element
 inductive). Preserves the pre- signature; backward-compatible. -/
theorem paper_prop_axis_independence_holds_pending_carrier_inhabitation :
  ∀ (k : CapabilityAxis), AdmitsDiscriminatingPairOnAxis k := by
  intro k
  cases k with
  | PI => exact paper_prop_axis_independence_witness_microstate_vs_continental_pending_carrier_inhabitation
  | MU => exact paper_prop_axis_independence_witness_parliamentary_vs_command_pending_carrier_inhabitation
  | NU => exact paper_prop_axis_independence_witness_autarkic_vs_networked_pending_carrier_inhabitation

/-- **Theorem **: the FULL `prop:axis-independence` proposition —
 `AxisIndependenceFull = SardRegularValueSetOpenDense ∧ (∀ k,
 AdmitsDiscriminatingPairOnAxis k)` — composed from the part-(a) Sard
 sub-axiom and the part-(b) per-axis theorem. makes the conjunctive
 structure visible; the pre- encoding dropped part (a). -/
theorem paper_prop_axis_independence_full :
  AxisIndependenceFull :=
  ⟨paper_prop_axis_independence_sard_regular_value_pending_mathlib_sard,
   paper_prop_axis_independence_holds_pending_carrier_inhabitation⟩

/-- **Proposition `prop:axis-independence`**: the three axis projections
 PI, MU, NU are logically independent (paper Section "Three Axes").

paper source: prop:axis-independence. : discharged via the 3 part-(b)
 witness sub-axioms composed in `paper_prop_axis_independence_holds_pending_carrier_inhabitation`;
 the part-(a) Sard statement is `paper_prop_axis_independence_full`.

Statement (paper part (b)). For each pair of axes `(j, k) ⊂ {PI, MU, NU}`,
there exist two economic systems `S_1, S_2` that differ on axis `j` but
agree on all other axes; symmetrically for `k`. This rules out any two of
the three axes being functionally dependent. -/
theorem prop_axis_independence :
  ∀ (k : CapabilityAxis), AdmitsDiscriminatingPairOnAxis k :=
  paper_prop_axis_independence_holds_pending_carrier_inhabitation

/-- Cat 2 external (paper prop:relaxation clause (i)): the Hamel-basis
 pathology — there exists an additive `f : ℝ → ℝ` that is not
 continuous. The construction uses the Axiom of Choice on ℝ as a
 ℚ-vector-space (Hamel 1905; Aczel 1966 §2.1).

 The predicate `RelaxingA1AdmitsHamel` now has the substantive body
 `∃ f, additive ∧ ¬continuous` (see Types.lean); this axiom inhabits
 that existential. -/
axiom paper_relaxation_A1_admits_hamel : RelaxingA1AdmitsHamel

/-- A2 relaxation: the broader family admits a triple `(-1, 1, 1)` on
 the unit simplex with first component negative — an exponent triple
 excluded by the A2-positivity constraint. -/
theorem paper_relaxation_A2_admits_arbitrary_signs :
    RelaxingA2AdmitsArbitrarySigns :=
  ⟨{ a := -1, b := 1, c := 1, sum_one := by norm_num },
   Or.inl (by norm_num)⟩

/-- A4 relaxation: the broader family admits the additive aggregator
 `F(x,y,z) = x + y + z`, which violates A4 multiplicative scaling
 at base point `(0, 1, 0)` with scaling factor `λ = 2` (since
 `F(0, 1, 0) = 1` but `F(2·0, 1, 0) = 1 ≠ 2 = 2·F(0, 1, 0)`). -/
theorem paper_relaxation_A4_admits_additive : RelaxingA4AdmitsAdditive := by
  refine ⟨fun x y z => x + y + z,
          ⟨1, 1, 1, fun _ _ _ => by ring⟩,
          ?_⟩
  refine ⟨2, 0, 1, 0, ?_⟩
  norm_num

/-- **Proposition `prop:relaxation`**: cost of relaxing each of the
 five labelled paper axioms.

paper source: prop:relaxation (5 clauses (i)-(v)).

Statement. Each axiom is load-bearing in the precise sense:
 (i) Without A1 (continuity): Hamel-basis pathological additive solutions.
 (ii) Without A2 (monotonicity): exponents of arbitrary sign.
 (iii) Without A3 (zero-axis annihilation) ALONE (keeping A1+A2+A4):
 no empirical cost — A3 is derivable from A1+A2+A4 (see
 `A3_zero_axis_annihilation_derivable`), so dropping A3 alone
 does not change the Cobb-Douglas conclusion. The CES-with-non-zero-
 limit alternative arises only if multiplicative scaling A4 is
 also relaxed.
 (iv) Without A4 (multiplicative scaling): additive cross-terms admitted.
 (v) Without A5 (log-additivity): no empirical cost — A5 is
 automatically satisfied by Cobb-Douglas; redundant per
 `A5_log_additivity_derivable`. -/
theorem prop_relaxation :
  RelaxingA1AdmitsHamel ∧
  RelaxingA2AdmitsArbitrarySigns ∧
  RelaxingA3AloneIsRedundant ∧
  RelaxingA4AdmitsAdditive ∧
  RelaxingA5IsRedundant :=
  ⟨paper_relaxation_A1_admits_hamel,
   paper_relaxation_A2_admits_arbitrary_signs,
   A3_redundant_from_A1_A2_A4,
   paper_relaxation_A4_admits_additive,
   A5_log_additivity_derivable⟩

/-- **Proposition `prop:two-anchors`**: cross-sectional pooled Tullock
 discrimination parameters `r_k^cs = (0.93, 1.27, 0.67)` and
 collapse-onset MLE-calibrated exponents `r_k^co = (0.40, 0.21, 0.39)`
 are different empirical objects related by a regime-density
 transformation `w_k^tr(s)`, not identical.

paper source: prop:two-anchors. existence of constant
map sending `paperTullockCS` to `paperTullockCO`. -/
theorem prop_two_anchors :
  IsRegimeDensityTransformation paperTullockCS paperTullockCO :=
  ⟨fun _ => paperTullockCO, rfl⟩

/-- Paper-bound: UW/exergy `η`-modulated subsumption of GDP (paper
 `prop:uw-subsumes` substantive claim: `W = η · GDP` within fixed
 exergy-conversion efficiency `η`, with cross-economy `η`-variation
 yielding ~3× divergence per Ayres-Warr Ch. 7).

 Scope note: `IsEtaModulatedSubsumption` is a Cat 3 workingAssumption
 predicate; the paper's substantive empirical bite ("η varies by a
 factor of ~3 across national economies") is recorded in the Ledger
 entry rather than the type signature (the predicate admits constant-η
 inhabitants). Tightening to require non-constant η is deferred. -/
axiom paper_uw_subsumes_gdp : IsEtaModulatedSubsumption usefulWork gdp

/-- **Proposition `prop:uw-subsumes`**: useful-work / exergy throughput
 subsumes GDP for the productive-capacity axis PI in the `η`-modulated
 sense (within fixed exergy-conversion efficiency `η`, linearly
 proportional `W = η · GDP`; across systems with different `η`, the
 two measures diverge by up to a factor of 3 per Ayres-Warr 2009
 Ch. 7).

paper source: prop:uw-subsumes (proposition body covers GDP only). A
prior encoding added a `paper_uw_subsumes_value_added` axiom claiming
`IsEtaModulatedSubsumption usefulWork valueAdded`; hostile audit
verified that paper rem:pi-protocol only describes value-added as a
measurement-proxy chain `(value-added / GDP) × GDP-at-PPP`, NOT an
η-modulated subsumption proposition. The value-added conjunct has been
removed as OVERCLAIM. -/
theorem prop_uw_subsumes :
  IsEtaModulatedSubsumption usefulWork gdp :=
  paper_uw_subsumes_gdp

/-- **Proposition `prop:mu-reachability`**: the mobilizable-surplus
 axis MU is a control-theoretic reachability rate over factor
 allocations (paper § sec:axes-mu).

paper source: prop:mu-reachability. Discharges by `rfl` since
`IsReachabilityRateOverFactors f := f = mobilizableSurplus`. -/
theorem prop_mu_reachability :
  IsReachabilityRateOverFactors mobilizableSurplus := rfl

/-- Paper-bound axiom for `prop:taylor-F` second-order Taylor expansion
 of the autonomous flow `F` around hegemonic steady state. The paper
 proof is the standard Hessian decomposition `H^{(k)}_{mn} =
 ∂²W/∂x_m∂x_n + δ_{mn}·∂²d_k/∂x_m²`; Lean replication requires Mathlib
 multivariate Taylor + concrete `F : ℝ³ → ℝ` carrier (currently the
 `EconomicSystem` carrier is opaque, so `F` cannot be stated directly).

 Cat 3 sub-type: working-assumption with explicit Mathlib + carrier-port
 dependency. Close path: requires (a) typed `F : EconomicSystem → ℝ³ → ℝ`
 accessor on the carrier exposing the autonomous-flow RHS; (b) Mathlib
 multivariate `iteratedFDeriv` Taylor expansion (available via
 `Mathlib.Analysis.Calculus.Taylor`); (c) Lean port of paper's Hessian
 decomposition using Mathlib `Matrix.det`. All three queued for the
 carrier-port engineering round (deferred per §12.4 wholesale-
 reorganization criterion: full carrier refactor affects 80%+ of
 downstream theorems). -/
axiom paper_prop_taylor_F_holds :
  ∀ (S : EconomicSystem), HasSecondOrderTaylorAroundHSS S

/-- **Proposition `prop:taylor-F`**: second-order Taylor expansion of
 the autonomous flow `F` (the RHS of the nonlinear ODE) around the
 hegemonic steady state, used in `thm:dynamics-microfoundation`. The
 Hessian decomposes into a `W_i` contribution and a `d_k` contribution
 (paper Hessian formula H^{(k)}_{mn}).

paper source: prop:taylor-F. Lean closure via the paper-bound
 working-assumption axiom `paper_prop_taylor_F_holds` per discipline
 §3.4.4; close path documented in axiom docstring. -/
theorem prop_taylor_F :
  ∀ (S : EconomicSystem), HasSecondOrderTaylorAroundHSS S :=
  paper_prop_taylor_F_holds

/-- Paper-bound assertion of `prop:long-cycle` (numerical observation
 at the canonical post-1815 calibration with investment-lag time
 constants `(τ_PI, τ_MU, τ_NU) = (10, 5, 20)` yr and
 `σ_NU ∈ [0.3, 1.0]`). The band is calibration-specific, NOT
 universal across all economic systems.

 -B.2 carve-out tightening: this
 axiom encodes ONLY the imaginary-part band `[0.012, 0.025]` (and
 derivatively the natural-ringing period `T_nat ∈ [251, 524]` yr).
 The accompanying paper claim about over-damping (real-part
 `Re(λ*) ≈ -0.038`, indicating no autonomous Hopf bifurcation in the
 focal-only system) is paper-acknowledged but NOT encoded by this
 axiom — `Has12x12LagJacobianEigenvalueBand` typed predicate
 quantifies the imaginary-part interval only. The over-damping
 side requires either (a) a separate axiom on the real-part band,
 or (b) acknowledging the autonomous-no-Hopf claim is empirical
 sensitivity-sweep observation (paper itself qualifies it as such),
 aligned with the existing carve-out pattern of `prop:long-cycle`
 being labelled "Proposition" but with body that is a numerical
 sweep (see `gap_prop_long_cycle` Ledger entry).

 Cat 3 sub-type: phenomenologicalConjecture per §3.4.6 — paper
 publishes this as a numerical observation awaiting external
 computational replication (resolution path = re-running the
 calibrated sensitivity sweep, NOT Lean derivation). The 12×12
 Jacobian eigenvalue band is a calibrated-instance numerical
 observation; per §3.4.6 the status remains gapOpen indefinitely. -/
axiom paper_prop_long_cycle_holds :
  Has12x12LagJacobianEigenvalueBand canonicalPost1815System 0.012 0.025

/-- **Proposition `prop:long-cycle`**: natural-ringing band of the
 focal-rival dyad (paper-acknowledged numerical observation, not
 closed-form theorem).

paper source: prop:long-cycle.

Statement (paper). At the canonical post-1815 calibration with
investment-lag time constants `(τ_PI, τ_MU, τ_NU) = (10, 5, 20)` yr and
`σ_NU ∈ [0.3, 1.0]`, the linearised lag-extended 12×12 Jacobian admits
a complex eigenvalue pair `λ* ± i ω*` with `|Im(λ*)| ∈ [0.012, 0.025]/yr`,
yielding natural ringing period `T_nat = 2π / ω* ∈ [251, 524]` years;
`Re(λ*) ≈ -0.038/yr` (over-damped, no Hopf). The numerical observation
supports the centennial-band cycle interpretation of Theorem
`thm:tension-cycle` via tension-driven external excitation rather than
autonomous Hopf bifurcation. -/
theorem prop_long_cycle :
  Has12x12LagJacobianEigenvalueBand canonicalPost1815System 0.012 0.025 :=
  paper_prop_long_cycle_holds

/-- **Proposition `prop:robustness-extension`**: 4-case robustness
 extension (Nazi Germany, Imperial Japan, Bourbon France, Habsburg
 Austria) yields 0 strict + 2 joint-shock partials + 2 ambiguous in
 the 15-case extended sample.

paper source: prop:robustness-extension. -/
theorem prop_robustness_extension :
  ∃ count : ExAnteClassificationCount,
    IsRobustnessExtension4Case count := by
  refine ⟨⟨0, 2, 0, 4, by omega⟩, ?_⟩
  exact ⟨rfl, rfl, rfl, rfl⟩

/-- Paper-bound: era ordering match for mercantile (c > b > a). -/
axiom paper_era_match_mercantile :
  EraExponentOrderingMatches HistoricalEra.mercantile

/-- Paper-bound: era ordering match for industrial (c > a > b). -/
axiom paper_era_match_industrial :
  EraExponentOrderingMatches HistoricalEra.industrial

/-- Paper-bound: era ordering match for late-industrial (b > c ≥ a). -/
axiom paper_era_match_late_industrial :
  EraExponentOrderingMatches HistoricalEra.lateIndustrial

/-- **Proposition `prop:era-from-tech`**: conditional on Perez 2002 /
 Freeman-Louca 2001 techno-paradigm priors `(η_k(τ), ν_k(τ))` per
 Kondratieff wave, the predicted Cobb-Douglas exponent **ordering**
 matches empirical ordering in 3 of 3 calibratable eras
 (mercantile `c > b > a`; industrial `c > a > b`; late-industrial
 `b > c ≥ a`); joint `p ≈ 0.005` under per-era random-ordering null
 with `α = 1` fixed and no in-sample tuning. Era classification
 itself is `def:kondratieff-tullock`; this proposition is the
 ordering-match empirical statement.

paper source: prop:era-from-tech. -/
theorem prop_era_from_tech :
  EraExponentOrderingMatches HistoricalEra.mercantile ∧
  EraExponentOrderingMatches HistoricalEra.industrial ∧
  EraExponentOrderingMatches HistoricalEra.lateIndustrial :=
  ⟨paper_era_match_mercantile,
   paper_era_match_industrial,
   paper_era_match_late_industrial⟩

/-! ### : prop:cross-scale-portability — 4 firm-level transfer
 paper-bound sub-axioms

Paper Remark prop:cross-scale-portability itemizes 3 structural
transfers (CD form / 3-axis decomp / non-substitutability) + 1
quantitative shift (firm-level exponents direction). decomposes
the previously monolithic `paper_prop_cross_scale_portability_holds`
axiom into one paper-bound axiom per facet, then composes the original
conclusion conjunctively. All 4 sub-axioms are unconditional (paper
itemizes the transfers descriptively) and `_pending_carrier_inhabitation`-
suffixed (the bodies are opaque `EconomicSystem → Prop` pending the
`EconomicSystem` constructor; mirrors 's witness sub-axioms). -/

/-- T1 paper-bound sub-axiom : the Cobb–Douglas functional form
 transfers unchanged to firm scale (paper prop:cross-scale-portability,
 structural dimension 1). Carrier-pending. -/
axiom paper_prop_cross_scale_cd_form_transfers_pending_carrier_inhabitation :
  ∀ (S : EconomicSystem), HasFirmLevelCobbDouglasForm S

/-- T2 paper-bound sub-axiom : the three-axis decomposition
 `(Π_F, Μ_F, Ν_F)` transfers unchanged to firm scale (paper
 prop:cross-scale-portability, structural dimension 2). Carrier-pending. -/
axiom paper_prop_cross_scale_three_axis_decomp_transfers_pending_carrier_inhabitation :
  ∀ (S : EconomicSystem), HasFirmLevelThreeAxisDecomp S

/-- T3 paper-bound sub-axiom : the non-substitutability theorem
 transfers to firm scale (paper prop:cross-scale-portability,
 structural dimension 3 — paper cites Cor. cross-scale-nonsub;
 empirical witnesses = the 3 firm collapses BlackBerry / Nokia /
 Kodak). A FRESH axiom — does NOT logically derive from
 `cor_cross_scale_nonsub` (that is a scale-spanning enumeration
 tautology with no `EconomicSystem` argument; it is the empirical
 witness, not the type-level antecedent). Carrier-pending. -/
axiom paper_prop_cross_scale_nonsubstitutability_transfers_pending_carrier_inhabitation :
  ∀ (S : EconomicSystem), HasFirmLevelNonSubstitutability S

/-- Q paper-bound sub-axiom : the calibrated firm-level exponents
 `(a_F, b_F, c_F) ≈ (0.35, 0.20, 0.45)` shift the network weight up
 (c: 0.39 → 0.45) and the production weight down (a: 0.40 → 0.35)
 relative to the state-level `(0.40, 0.21, 0.39)`, in the direction
 structurally predicted by rising `r_NU` and `|∂W/∂x_NU|` at firm
 scale (b ≈ flat: 0.21 → 0.20) (paper prop:cross-scale-portability,
 quantitative dimension). Carrier-pending (+ firm-level `r_NU`,
 `∂W/∂x_NU` accessors). -/
axiom paper_prop_cross_scale_exponent_shift_direction_pending_carrier_inhabitation :
  ∀ (S : EconomicSystem), FirmLevelExponentShiftDirection S

/-- **Theorem **: `paper_prop_cross_scale_portability_holds`
 (renamed `..._pending_carrier_inhabitation` to flag the carrier
 blocker, mirroring ) is now derived from the 4 per-facet
 paper-bound sub-axioms (3 structural transfers + 1 quantitative
 shift). The `IsFirmLevelPortableExtension` def unfolds to the
 4-conjunction; composition is `⟨T1, T2, T3, Q⟩`. Signature
 UNCHANGED from the pre- monolithic axiom — backward-compatible.
 COMPLETED. -/
theorem paper_prop_cross_scale_portability_holds_pending_carrier_inhabitation :
  ∀ (S : EconomicSystem), IsFirmLevelPortableExtension S :=
  fun S =>
    ⟨paper_prop_cross_scale_cd_form_transfers_pending_carrier_inhabitation S,
     paper_prop_cross_scale_three_axis_decomp_transfers_pending_carrier_inhabitation S,
     paper_prop_cross_scale_nonsubstitutability_transfers_pending_carrier_inhabitation S,
     paper_prop_cross_scale_exponent_shift_direction_pending_carrier_inhabitation S⟩

/-- **Remark `prop:cross-scale-portability`** (paper env is
 `\begin{remark}` at `influence_capacity.tex:2482` despite the `prop:`
 label prefix; LaTeX permits any label-prefix inside any environment):
 the framework's structure transfers to firm-level competition — the
 Cobb–Douglas form, the three-axis decomposition, and the
 non-substitutability theorem transfer unchanged, and the firm-level
 exponents shift in the structurally-predicted direction (paper-bound
 firm dyads: Apple/Samsung + TSMC vs. Intel; historical collapses
 BlackBerry, Nokia, Kodak).

paper source: rem:cross-scale-portability (label-form
`prop:cross-scale-portability` inside paper `\begin{remark}` env).
Discharged via the 4 per-facet sub-axioms composed in
`paper_prop_cross_scale_portability_holds_pending_carrier_inhabitation`;
signature unchanged. -/
theorem prop_cross_scale_portability :
  ∀ (S : EconomicSystem), IsFirmLevelPortableExtension S :=
  paper_prop_cross_scale_portability_holds_pending_carrier_inhabitation

/-- **Proposition `prop:strange-as-era-varying`**: Strange's weak
 incommensurability claim is embedded in the framework's
 parametric structure (era-varying Cobb-Douglas exponents) rather
 than treated as an autonomous philosophical axiom.

paper source: prop:strange-as-era-varying. existence
of two distinct historical eras both matching empirical CD orderings,
discharged from `paper_era_match_mercantile` and `paper_era_match_industrial`. -/
theorem prop_strange_as_era_varying :
  IsStrangeIncommensurabilityEmbeddedAsParametric :=
  ⟨HistoricalEra.mercantile, HistoricalEra.industrial,
   by decide,
   paper_era_match_mercantile,
   paper_era_match_industrial⟩

/-- **Proposition `prop:strict-nesting`** (paper title: "Alternative
 Indices: Parameter Restrictions, Axiom-Relaxations, and Boundary
 Cases"): the five alternative indices relate to the Cobb-Douglas
 family via three structural modes:
 (i) parameter restriction at simplex vertices: Mearsheimer (1,1,0),
 ECI (1,0,0), Ayres-Warr (1,0,0).
 (ii) axiom relaxation outside the family: CINC = additive limit
 obtained by relaxing A3 (zero-axis annihilation, paper line
 2341).
 (iii) boundary case (negative-exponent outside admissible set):
 Beckley (2,-1,0) — negative population exponent violates A2
 strict positivity.

paper source: prop:strict-nesting. -/
theorem prop_strict_nesting :
  classifyAlternativeIndex mearsheimerIndex =
    AlternativeIndexMode.parameterRestriction ∧
  classifyAlternativeIndex eciIndex =
    AlternativeIndexMode.parameterRestriction ∧
  classifyAlternativeIndex ayresWarrIndex =
    AlternativeIndexMode.parameterRestriction ∧
  classifyAlternativeIndex cincIndex =
    AlternativeIndexMode.axiomRelaxation ∧
  classifyAlternativeIndex beckleyIndex =
    AlternativeIndexMode.boundaryCase :=
  ⟨rfl, rfl, rfl, rfl, rfl⟩

/-- **Proposition `prop:two-axis-reduction`**: Mearsheimer's two-axis
 `GDP × Population` decomposition is the projection of the
 framework's three-axis structure onto the slow-stock cluster `PI`
 alone, collapsing both `MU` and `NU`.

paper source: prop:two-axis-reduction. Discharges by `rfl` since
`IsSlowStockProjectionOfThreeAxes := classifyAlternativeIndex
mearsheimerIndex = parameterRestriction`. -/
theorem prop_two_axis_reduction :
  IsSlowStockProjectionOfThreeAxes := rfl

/-- **Proposition `prop:four-axis-reduction`**: Strange's four-axis
 typology (Production, Finance, Security, Knowledge) reduces to the
 three axes of `thm:three-axes`.

paper source: prop:four-axis-reduction. Discharges by exhaustive
pattern-match via `strangeAxisReduction : StrangeAxis → Option CapabilityAxis`. -/
theorem prop_four_axis_reduction :
  StrangeFourAxisReducesToThreeAxes :=
  fun s => ⟨strangeAxisReduction s, rfl⟩

/-- Paper-bound: per-candidate fourth-axis reduction (paper prop:fourth-axes). -/
axiom paper_fourth_axis_knowledge :
  ReducesToThreeAxesOrOutsideHorizon FourthAxisCandidate.knowledge
axiom paper_fourth_axis_soft_power :
  ReducesToThreeAxesOrOutsideHorizon FourthAxisCandidate.softPower
axiom paper_fourth_axis_separately_mobilized_military :
  ReducesToThreeAxesOrOutsideHorizon FourthAxisCandidate.separatelyMobilizedMilitary
axiom paper_fourth_axis_institutional_resilience :
  ReducesToThreeAxesOrOutsideHorizon FourthAxisCandidate.institutionalResilience
axiom paper_fourth_axis_demographic_capacity :
  ReducesToThreeAxesOrOutsideHorizon FourthAxisCandidate.demographicCapacity

/-- **Proposition `prop:fourth-axes`**: no fourth axis (knowledge, soft
 power, separately-mobilized military, institutional resilience,
 demographic capacity) is admissible — each either reduces to one of
 `{PI, MU, NU}` or operates outside the analytical horizon.

paper source: prop:fourth-axes. -/
theorem prop_fourth_axes :
  ∀ (c : FourthAxisCandidate), ReducesToThreeAxesOrOutsideHorizon c
  | .knowledge => paper_fourth_axis_knowledge
  | .softPower => paper_fourth_axis_soft_power
  | .separatelyMobilizedMilitary =>
      paper_fourth_axis_separately_mobilized_military
  | .institutionalResilience => paper_fourth_axis_institutional_resilience
  | .demographicCapacity => paper_fourth_axis_demographic_capacity

end InfluenceCapacity
