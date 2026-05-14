/-
# Classical results invoked by the Three-Axis Influence-Capacity paper.

The paper invokes a number of classical theorems (Aczel 1966 Cauchy
multiplicative-equation continuous-solution theorem, Hartman-Grobman
linearisation, Routh-Hurwitz stability criterion, Bauer-Fike eigenvalue
perturbation bound, finite-dimensional norm equivalence, mixed-Poisson
dispersion / Cox-Lewis test). Each axiomatised here with an explicit
`paper source:` and the original-literature `Source:` citation. Lean
proofs are deferred to Mathlib (where most of these have not yet landed
in the form needed by the paper's reduction).

In this file we record only the classical results whose statement can
be expressed at a reasonable level of abstraction, without a `def := True`
trick. Each axiom below has a mathematically non-trivial conclusion.
-/

import InfluenceCapacity.Types
import Mathlib.Data.Real.Basic
import Mathlib.Topology.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Continuity
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace InfluenceCapacity

/-! ## 1. Aczel 1966 — continuous solutions of Cauchy's ADDITIVE
        functional equation (used by `thm:representation` Step 2 after
        log-transform, NOT the multiplicative form directly).

Paper Theorem `thm:representation` Step 1 first defines `φ_i(t) := log h_i(e^t)`
to transform the multiplicative equation `h_i(xy) = h_i(x) h_i(y)` into
the additive Cauchy equation `φ_i(t + s) = φ_i(t) + φ_i(s)`. Step 2 then
invokes Aczel 1966 Theorem 2.1.2 (continuous solutions of additive
Cauchy on ℝ are linear). The multiplicative-form power-function
conclusion `h_i(x) = x^γ` is recovered after exp-back.

Source: J. Aczel, *Lectures on Functional Equations and their
        Applications*, Academic Press (1966), Theorem 2.1.2 (continuous
        solutions of Cauchy's additive equation are linear).
-/

/-- **Aczel 1966 Theorem 2.1.2 (additive-Cauchy continuous-solution)**.

paper source: thm:representation Step 2 (via log-transform of
    multiplicative Cauchy from A4).
Source: Aczel 1966 Theorem 2.1.2 / Hamel 1905.

Statement. Every continuous solution `φ : ℝ → ℝ` of the additive Cauchy
equation `φ(t + s) = φ(t) + φ(s)` for all `t, s ∈ ℝ` has the linear form
`φ(t) = γ · t` for some constant `γ ∈ ℝ`. Without continuity, pathological
non-Lebesgue-measurable solutions exist (Hamel basis); A1's continuity
hypothesis rules these out. -/
axiom aczel_additive_cauchy_continuous_linear :
  ∀ (φ : ℝ → ℝ),
    Continuous φ →
    (∀ t s : ℝ, φ (t + s) = φ t + φ s) →
    ∃ γ : ℝ, ∀ t : ℝ, φ t = γ * t

/-- **Multiplicative-form corollary** (paper `thm:representation` Step 3).

paper source: thm:representation Step 3 (recovery of power form via exp).
Reduces to: `aczel_additive_cauchy_continuous_linear` after log/exp.

Statement. Every continuous, strictly monotone solution
`h : ℝ_{>0} → ℝ_{>0}` of the multiplicative Cauchy equation
`h(xy) = h(x) · h(y)` for `x, y > 0` has the power form `h(x) = x^γ`
for some `γ ∈ ℝ`. Strict monotonicity (A2) additionally forces `γ > 0`. -/
theorem aczel_multiplicative_cauchy_power_form :
    ∀ (h : ℝ → ℝ),
      Continuous h →
      StrictMono h →
      (∀ x y : ℝ, x > 0 → y > 0 → h (x * y) = h x * h y) →
      ∃ γ : ℝ, γ > 0 ∧ ∀ x : ℝ, x > 0 → h x = x ^ γ := by
  intro h hcont hmono hmult
  -- Step 1: h(1) * h(1) = h(1)
  have h1_sq : h 1 * h 1 = h 1 := by
    have := hmult 1 1 one_pos one_pos
    rw [one_mul] at this
    exact this.symm
  -- Rule out h(1) = 0 via StrictMono
  have h1_ne_zero : h 1 ≠ 0 := by
    intro h1z
    have h2_eq_zero : h 2 = 0 := by
      have := hmult 2 1 (by norm_num : (0:ℝ) < 2) one_pos
      rw [mul_one] at this
      rw [this, h1z, mul_zero]
    have : h 1 < h 2 := hmono (by norm_num : (1:ℝ) < 2)
    rw [h1z, h2_eq_zero] at this
    exact lt_irrefl _ this
  -- So h(1) = 1
  have h1_eq_one : h 1 = 1 := by
    have factored : h 1 * (h 1 - 1) = 0 := by linarith
    rcases mul_eq_zero.mp factored with hcase | hcase
    · exact absurd hcase h1_ne_zero
    · linarith
  -- Step 2: h(x) > 0 for x > 0
  have h_pos : ∀ x : ℝ, x > 0 → h x > 0 := by
    intro x hx
    have inv_pos : (0:ℝ) < 1/x := by positivity
    have prod : h x * h (1/x) = 1 := by
      have e : x * (1/x) = 1 := by field_simp
      have := hmult x (1/x) hx inv_pos
      rw [e] at this
      rw [← this, h1_eq_one]
    have hx_ne : h x ≠ 0 := by
      intro hz
      rw [hz, zero_mul] at prod
      exact zero_ne_one prod
    have sqrt_pos : (0:ℝ) < Real.sqrt x := Real.sqrt_pos.mpr hx
    have sqrt_sq : Real.sqrt x * Real.sqrt x = x := Real.mul_self_sqrt (le_of_lt hx)
    have h_sqr_eq : h x = h (Real.sqrt x) * h (Real.sqrt x) := by
      have := hmult (Real.sqrt x) (Real.sqrt x) sqrt_pos sqrt_pos
      rw [sqrt_sq] at this
      exact this
    have h_sqr_nn : (0:ℝ) ≤ h x := by
      rw [h_sqr_eq]
      exact mul_self_nonneg _
    exact lt_of_le_of_ne h_sqr_nn (Ne.symm hx_ne)
  -- Step 3: φ(t) := log h(exp t) is continuous + additive Cauchy.
  -- Inline definition (no let-binding) to avoid unification issues with
  -- `ContinuousAt.comp`'s decomposition.
  have aczel : ∃ γ : ℝ, ∀ t : ℝ,
      Real.log (h (Real.exp t)) = γ * t := by
    apply aczel_additive_cauchy_continuous_linear
      (fun t => Real.log (h (Real.exp t)))
    · -- continuity of φ using ContinuousAt.log dot notation
      refine continuous_iff_continuousAt.mpr fun t => ?_
      have h_exp_cont_at : ContinuousAt (fun s : ℝ => h (Real.exp s)) t :=
        (hcont.comp Real.continuous_exp).continuousAt
      have h_exp_t_ne : h (Real.exp t) ≠ 0 :=
        ne_of_gt (h_pos _ (Real.exp_pos t))
      exact h_exp_cont_at.log h_exp_t_ne
    · -- additivity of φ
      intro t s
      show Real.log (h (Real.exp (t + s))) =
        Real.log (h (Real.exp t)) + Real.log (h (Real.exp s))
      rw [Real.exp_add]
      rw [hmult _ _ (Real.exp_pos t) (Real.exp_pos s)]
      exact Real.log_mul (ne_of_gt (h_pos _ (Real.exp_pos t)))
                         (ne_of_gt (h_pos _ (Real.exp_pos s)))
  obtain ⟨γ, hγ⟩ := aczel
  refine ⟨γ, ?_, ?_⟩
  · -- Step 6: γ > 0 from StrictMono of h
    have h_at_2 : h 2 > 1 := by
      have := hmono (by norm_num : (1:ℝ) < 2)
      rw [h1_eq_one] at this
      exact this
    have log_h2_pos : Real.log (h 2) > 0 := Real.log_pos h_at_2
    have e_log_2 : Real.exp (Real.log 2) = 2 :=
      Real.exp_log (by norm_num : (0:ℝ) < 2)
    have hγ_at_log2 :
        Real.log (h (Real.exp (Real.log 2))) = γ * Real.log 2 := hγ _
    rw [e_log_2] at hγ_at_log2
    have prod_pos : γ * Real.log 2 > 0 := by linarith
    have log_2_pos : Real.log 2 > 0 := Real.log_pos (by norm_num)
    exact (mul_pos_iff_of_pos_right log_2_pos).mp prod_pos
  · -- Step 5: h(x) = x^γ via Real.exp_log + Real.rpow_def_of_pos
    intro x hx
    have ex : Real.exp (Real.log x) = x := Real.exp_log hx
    have hγ_at_logx :
        Real.log (h (Real.exp (Real.log x))) = γ * Real.log x := hγ _
    rw [ex] at hγ_at_logx
    have hx_pos : h x > 0 := h_pos x hx
    rw [show h x = Real.exp (Real.log (h x)) from (Real.exp_log hx_pos).symm,
        hγ_at_logx, mul_comm γ (Real.log x)]
    exact (Real.rpow_def_of_pos hx γ).symm

/-- **A3 (zero-axis annihilation) follows from A1+A2+A4** —
    structural consequence used by Theorem `thm:representation` Step 5.

paper source: thm:representation Step 5 (acknowledging A3 redundancy
    alongside A5; both derivable from A1+A2+A4).

Statement: Under multiplicative Cauchy `h(xy) = h(x) h(y)` (A4) plus
continuity at 0 (A1) plus strict monotonicity (A2), `h(0) = 0`.

Proof sketch: Take `y → 0^+`; by continuity `lim h(x · y) = h(0)`; by
Cauchy `h(0) = h(x) · h(0)` for all `x > 0`. If `h(0) ≠ 0` (in
particular `h(0) > 0` since `h` is real-valued and `StrictMono` from
A2 forces non-negativity at 0), divide to get `h(x) ≡ 1` constant on
`ℝ_{>0}`, contradicting strict A2 (`x_1 < x_2 → h(x_1) < h(x_2)` fails
for constants). Hence `h(0) = 0`. -/
theorem A3_redundant_from_A1_A2_A4 :
    ∀ (h : ℝ → ℝ),
      Continuous h →
      StrictMono h →
      (∀ x y : ℝ, x > 0 → y > 0 → h (x * y) = h x * h y) →
      h 0 = 0 := by
  intro h hcont hmono hmult
  -- From `aczel_multiplicative_cauchy_power_form`: γ > 0 with h(x) = x^γ
  -- on positives. Then by continuity at 0: h(0) = lim_{x→0+} x^γ = 0.
  obtain ⟨γ, hγ_pos, hpow⟩ :=
    aczel_multiplicative_cauchy_power_form h hcont hmono hmult
  -- Real.rpow with positive exponent is continuous on ℝ
  have rpow_cont : Continuous (fun x : ℝ => x ^ γ) :=
    Real.continuous_rpow_const (le_of_lt hγ_pos)
  have rpow_0_eq_0 : (0 : ℝ) ^ γ = 0 := Real.zero_rpow (ne_of_gt hγ_pos)
  -- rpow → 0 as x → 0
  have rpow_tendsto : Filter.Tendsto (fun x : ℝ => x ^ γ)
      (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) := by
    have step : Filter.Tendsto (fun x : ℝ => x ^ γ) (nhds (0:ℝ))
        (nhds ((0:ℝ) ^ γ)) := rpow_cont.tendsto 0
    rw [rpow_0_eq_0] at step
    exact step.mono_left nhdsWithin_le_nhds
  -- h = rpow on Ioi 0 (eventually with respect to nhdsWithin 0 (Ioi 0))
  have h_eq_rpow_eventually : (fun x : ℝ => x ^ γ) =ᶠ[nhdsWithin 0 (Set.Ioi 0)] h := by
    rw [Filter.eventuallyEq_iff_exists_mem]
    exact ⟨Set.Ioi 0, self_mem_nhdsWithin, fun x hx => (hpow x hx).symm⟩
  -- So h has the same limit at nhdsWithin 0 (Ioi 0)
  have h_tendsto_right : Filter.Tendsto h (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) :=
    rpow_tendsto.congr' h_eq_rpow_eventually
  -- But h continuous at 0 gives the limit equals h(0)
  have h_tendsto_right_to_h0 :
      Filter.Tendsto h (nhdsWithin 0 (Set.Ioi 0)) (nhds (h 0)) :=
    (hcont.continuousAt.tendsto).mono_left nhdsWithin_le_nhds
  -- Uniqueness of limit ⟹ h 0 = 0
  exact tendsto_nhds_unique h_tendsto_right_to_h0 h_tendsto_right

/-! ## 2. Lyapunov indirect method (Hurwitz ⟹ local exponential stability)

Used by paper Proposition `prop:nonlinear-stability` to conclude local
exponential stability of the nonlinear flow at a hegemonic steady state
with Hurwitz Jacobian. The classical operative source for Hurwitz ⟹
local exponential stability is the **Lyapunov indirect method** (Khalil
2002 Thm 4.7); pure Hartman-Grobman gives only topological conjugacy,
not exponential rates.

Source: H. K. Khalil, *Nonlinear Systems*, 3rd ed., Prentice Hall (2002),
        Theorem 4.7 (Lyapunov's first / indirect method).
        P. Hartman, Proc. Amer. Math. Soc. 11 (1960), 610-620;
        D. M. Grobman, Doklady Akad. Nauk SSSR 128 (1959), 880-881
        (topological-conjugacy precursor).
-/

/-- Opaque predicate: the Jacobian `J` is Hurwitz (all eigenvalues
    have strictly negative real parts). Used as hypothesis of
    `lyapunov_indirect_local_exp_stability` and `routh_hurwitz_3x3`. -/
axiom IsHurwitz : Jacobian3 → Prop

/-- Opaque predicate: the linearised flow is locally exponentially
    stable around the hegemonic steady state (conclusion of Lyapunov's
    indirect method applied to a Hurwitz Jacobian). -/
axiom LocallyExponentiallyStable : Jacobian3 → Prop

/-- **Lyapunov indirect method** (axiomatised, smooth-flow form): a
    Hurwitz Jacobian implies the nonlinear flow is locally exponentially
    stable around the fixed point.

paper source: prop:nonlinear-stability.
Source: Khalil 2002 Thm 4.7 (Lyapunov indirect method).

Statement. If the Jacobian `J` of a smooth flow at a fixed point `x*`
is Hurwitz (all eigenvalues with strictly negative real parts), then
the nonlinear flow is locally exponentially stable at `x*`. -/
axiom lyapunov_indirect_local_exp_stability :
  ∀ (J : Jacobian3), IsHurwitz J → LocallyExponentiallyStable J

/-! ## 3. Routh-Hurwitz stability criterion (3×3 form)

Used by paper Proposition `prop:nonlinear-stability` to translate the
abstract eigenvalue condition into a determinant + trace + RH-inequality
test.

Source: A. Hurwitz, "Über die Bedingungen, unter welchen eine Gleichung
        nur Wurzeln mit negativen reellen Theilen besitzt", Math. Ann. 46
        (1895), 273-284.
        E. J. Routh, *A Treatise on the Stability of a Given State of
        Motion*, Macmillan (1877).
-/

/-- Characteristic-polynomial coefficient triple `(a₂, a₁, a₀)` of a
    3×3 Jacobian's characteristic polynomial `λ³ + a₂ λ² + a₁ λ + a₀`.
    Opaque pending Mathlib's `Matrix.charpoly` infrastructure. -/
axiom CharPolyCoeffs : Jacobian3 → ℝ × ℝ × ℝ

/-- **Routh-Hurwitz 3×3 criterion** (Hurwitz iff coefficient inequalities).

paper source: prop:nonlinear-stability.
Source: Hurwitz 1895 / Routh 1877. Strang LinAlg Ch. 6 modern form.

Statement. The 3×3 real matrix `J` is Hurwitz iff its characteristic
polynomial `λ³ + a₂ λ² + a₁ λ + a₀` satisfies the four inequalities:
`a₀ > 0`, `a₁ > 0`, `a₂ > 0`, and `a₂ · a₁ > a₀`. -/
axiom routh_hurwitz_3x3 :
  ∀ (J : Jacobian3),
    IsHurwitz J ↔
      let ⟨a₂, a₁, a₀⟩ := CharPolyCoeffs J
      a₀ > 0 ∧ a₁ > 0 ∧ a₂ > 0 ∧ a₂ * a₁ > a₀

/-! ## 4. Mixed-Poisson over-dispersion theorem (slow-driver regime)

Used by paper Proposition `prop:clustering`: under the slow-driver regime,
mixed-Poisson inter-event times have `Var/E² > 1` strictly. Paper's own
proof uses the law of total variance + the conditional exponential
identity `Var[τ|Λ] = E[τ|Λ]²`. Paper's only `\citet` in the proof is
Karlin-Taylor 1975 for the conditional exponential identity; the
over-dispersion result is then a corollary via Jensen /
variance-decomposition (textbook mixed-Poisson folklore).

Source (primary, only paper-cited author in `prop:clustering` proof):
    S. Karlin and H. M. Taylor, *A First Course in Stochastic Processes*,
        2nd ed., Academic Press (1975) (conditional-exponential identity
        `Var[τ|Λ] = E[τ|Λ]² = 1/Λ²`).

The "Cox-Lewis test" appears in paper as a phrase naming the empirical
test procedure for detecting non-Poissonness; paper provides no
`\citet`/`\bibitem` for it. The legacy Lean axiom name `cox_lewis_*`
is the standard test name, retained for backward compatibility but the
theorem-level attribution is Karlin-Taylor (paper-cited) + law of total
variance.
-/

/-- Opaque "inter-shock squared coefficient of variation" of a Cox
    process / mixed-Poisson process. -/
axiom InterShockCV2 : EconomicSystem → ℝ

/-- Opaque "tension non-degeneracy" predicate: `Λ = λ(T(t))` has
    non-degenerate stationary distribution under the slow-driver regime. -/
axiom TensionNonDegenerate : EconomicSystem → Prop

/-- Opaque "slow-driver-regime applies" predicate. -/
axiom SlowDriverApplies : EconomicSystem → Prop

/-- **Mixed-Poisson over-dispersion theorem (slow-driver regime)**.

paper source: prop:clustering (under slow-driver regime).
Source (paper-cited): Karlin-Taylor 1975 conditional-exponential
    identity `Var[τ|Λ] = E[τ|Λ]² = 1/Λ²`. The over-dispersion `CV² > 1`
    is then derived via the law of total variance (textbook).

The "Cox-Lewis test" is a test procedure (Cox-Lewis 1966) for empirical
detection of non-Poissonness; paper provides no `\citet` for it. The
legacy Lean axiom name `cox_lewis_*` is retained for downstream
compatibility, but the theorem-level attribution is Karlin-Taylor +
law of total variance.

Statement. Under the slow-driver regime plus non-degenerate tension,
the inter-shock squared coefficient of variation strictly exceeds 1
in the large-sample limit. -/
axiom cox_lewis_mixed_poisson_overdispersion :
  ∀ (S : EconomicSystem),
    SlowDriverApplies S → TensionNonDegenerate S → InterShockCV2 S > 1

/-! ## 5. Topkis lattice-theoretic argument (action-algebra decomposition)

Used by paper Theorem `thm:three-axes` Step 1 — specifically the
UPPER-BOUND clause "no further irreducible components arise from
reachable-set actions because additional candidates act as endomorphisms
of the existing three". Paper text: "By the lattice-theoretic argument
of \citet{topkis1998}, any further decomposition of A must respect the
sublattice structure generated by these three". The paper does NOT
attribute the lower bound (≥3, paper-novel stock/flow/rule construction)
to Topkis.

Source: D. M. Topkis, *Supermodularity and Complementarity*, Princeton
        University Press (1998), Ch. 2 (lattice-theoretic comparative
        statics; paper invokes the supermodular-sublattice machinery
        for the upper-bound endomorphism argument — paper itself does
        NOT pin a specific theorem number).
-/

/-- Opaque "action-algebra irreducible-component count" for an economic
    system. Used by the upper-bound argument referencing Topkis 1998. -/
axiom ActionAlgebraIrreducibleCount : EconomicSystem → Nat

/-- **Action-algebra-count-three lower bound axiom**: every economic
    system has an action algebra with at least three irreducible
    components (stock, flow, rule).

paper source: thm:three-axes Step 1 (paper-novel stock+flow+rule
    construction). Paper Step 1 establishes the lower bound by
    EXPLICITLY constructing three functorially-distinct group actions on
    the reachable-set carrier (additive ℝ^d_+ action = stock, GL action
    = flow, technology-poset morphisms = rule); Topkis is NOT used for
    the lower bound (paper invokes Topkis only for the upper-bound "no
    further" clause, see `action_algebra_irreducible_count_le_three`).
    This is paper-NOVEL Cat 3 construction encoded as Cat 2 packaging
    only because the carrier `EconomicSystem` is opaque pending Mathlib
    constructor port.

Statement. The action algebra of an economic system has at least three
irreducible components (stock, flow, rule). -/
axiom action_algebra_irreducible_count_ge_three :
  ∀ (S : EconomicSystem), ActionAlgebraIrreducibleCount S ≥ 3

/-- **Action-algebra-count-three upper bound** (paper additional claim).

paper source: thm:three-axes Step 1: "no further irreducible component
    arises from reachable-set actions". Paper-bound axiom complementing
    the Topkis ≥ 3 lower bound, jointly forcing exactly = 3. -/
axiom action_algebra_irreducible_count_le_three :
  ∀ (S : EconomicSystem), ActionAlgebraIrreducibleCount S ≤ 3

/-! ## 6. Cover-Thomas chain rule for mutual information

Used by paper Theorem `thm:three-axes` Step 2 (information-geometric
matching `m ≥ 3`).

Source: T. M. Cover and J. A. Thomas, *Elements of Information Theory*,
        2nd ed., Wiley (2006), Theorem 2.6.4 (chain rule for mutual
        information; §2.5 leading-order independence).
-/

/-- Opaque "mutual information" between joint capability inputs and
    global outcomes (paper § thm:three-axes Step 2). -/
axiom MutualInformation : EconomicSystem → ℝ

/-- Opaque "per-channel mutual information" (paper's `I(X_j; Y_j)`
    decomposition). -/
axiom ChannelMutualInformation : EconomicSystem → Nat → ℝ

/-- Opaque predicate: information-geometric independence (paper's
    `P(Y | X) = ∏ P(Y_j | X_j)` factorisation). -/
axiom InformationGeometricIndependence : EconomicSystem → Nat → Prop

/-- **Cover-Thomas mutual-information independence decomposition**
    (the corollary of the chain rule that applies under conditional
    independence; NOT the full chain rule with conditioning).

paper source: thm:three-axes Step 2 (paper itself uses "chain rule"
    wording, but the statement applied is the independence corollary
    `I(X; Y) = Σ I(X_j; Y_j)` not the full chain rule
    `I(X_1, ..., X_n; Y) = Σ_i I(X_i; Y | X_1...X_{i-1})`).
Source: Cover-Thomas 2006 Thm. 2.6.4 (chain rule) + §2.5 (corollary
    under independence).

Statement. Under information-geometric independence with `m` channels,
the total mutual information decomposes as the sum of per-channel
mutual informations. -/
axiom cover_thomas_independence_decomposition :
  ∀ (S : EconomicSystem) (m : Nat),
    InformationGeometricIndependence S m →
    MutualInformation S = (List.range m).foldr
      (fun j acc => acc + ChannelMutualInformation S j) 0

/-! ## 7. Tikhonov-Fenichel singular-perturbation theorem

Used by paper Theorem `thm:three-axes` Step 3 (slaving of fast modes).
The classical result is the **Tikhonov-Fenichel singular-perturbation
theorem**: under normal hyperbolicity of a compact critical manifold,
an O(ε)-close slow invariant manifold persists. The numeric form
"slow-manifold dimension equals spectral-cluster count" used by paper
is the Fenichel-style modal-decomposition consequence under spectral
separation, not the original Tikhonov 1952 statement.

Source: A. N. Tikhonov, Mat. Sb. 31 (1952), 575-586.
        N. Fenichel, J. Diff. Eqs. 31 (1979), 53-98 (geometric singular
        perturbation theory).
        C. Kuehn, *Multiple Time Scale Dynamics*, Springer (2015), §11.1.
-/

/-- Opaque "slow-manifold dimension" of a capability process at a given
    analytical horizon `τ`. -/
axiom SlowManifoldDimension : EconomicSystem → ℝ → Nat

/-- Opaque "spectral-cluster count resolved at horizon `τ`". -/
axiom SpectralClusterCount : EconomicSystem → ℝ → Nat

/-- **Tikhonov-Fenichel singular-perturbation slow-manifold reduction**.

paper source: thm:three-axes Step 3 (fast modes slaved).
Source: Tikhonov 1952 / Fenichel 1979 / Kuehn 2015 §11.1. Mathlib lacks
    Fenichel infrastructure so the axiom is provided opaque.

Statement. Under spectral separation, the slow-manifold dimension
equals the number of resolved spectral clusters. -/
axiom tikhonov_fenichel_slow_manifold :
  ∀ (S : EconomicSystem) (τ : ℝ),
    SpectralSeparation S τ →
    SlowManifoldDimension S τ = SpectralClusterCount S τ

/-- **Paper-novel Step 2-3 link** — info-geometric / spectral-cluster
    correspondence (paper-novel, NOT a classical theorem of Cover-Thomas
    or Tikhonov-Fenichel individually).

paper source: thm:three-axes Steps 2-3 link. Under info-geometric
    independence with `m` channels + spectral separation, the count of
    resolved spectral clusters equals the count of info-geometric
    channels — each independent info-geometric channel corresponds to
    one resolved slow timescale at the analytical horizon. -/
axiom paper_info_geometric_eq_spectral_cluster_step2to3_link :
  ∀ (S : EconomicSystem) (τ : ℝ) (m : ℕ),
    InformationGeometricIndependence S m →
    SpectralSeparation S τ →
    SpectralClusterCount S τ = m

/-! ## 8. Tullock contest-success function (classical Tullock 1980 boundary
        behavior + paper-novel small-share three-contest construction)

The classical Tullock 1980 result is the contest-success function
`p_i = x_i^r / Σ_j x_j^r` and its boundary behavior. The "small-share
asymptotic three-contest factorisation yielding Cobb-Douglas" is a
**paper construction** (paper Theorem `thm:tullock-microfoundation`)
that uses Tullock CSF as a building block but is not itself stated by
Tullock 1980 / Skaperdas 1996 / Konrad 2009; those references provide
the CSF axiomatisation but not the cross-contest Cobb-Douglas
factorisation. The Lean axioms reflect this split.

Source (CSF only): G. Tullock, "Efficient rent-seeking", in J. M.
        Buchanan, R. D. Tollison, and G. Tullock (eds.), *Toward a
        Theory of the Rent-Seeking Society*, Texas A&M Press (1980).
        S. Skaperdas, "Contest success functions", Economic Theory 7
        (1996), 283-290.
        K. A. Konrad, *Strategy and Dynamics in Contests*, Oxford UP
        (2009).
Source (small-share three-contest factorisation): paper Theorem
        `thm:tullock-microfoundation` (paper-novel construction).
-/

/-- Opaque "log-influence factorises as Cobb-Douglas" predicate. -/
axiom LogInfluenceFactorisesAsCobbDouglas :
  EconomicSystem → TullockParameters → Prop

/-- **Paper-novel small-share three-contest CSF factorisation**: paper's
    `thm:tullock-microfoundation` construction (uses Tullock CSF as
    building block; the cross-contest Cobb-Douglas factorisation is
    paper's own contribution, not classical Tullock / Skaperdas /
    Konrad).

paper source: thm:tullock-microfoundation.

Statement. In the small-share asymptotic regime, the log-influence
factorises across three independent Tullock contests, yielding the
Cobb-Douglas form. -/
axiom paper_csf_small_share_limit_construction :
  ∀ (S : EconomicSystem) (r : TullockParameters),
    SmallShareRegime S r → LogInfluenceFactorisesAsCobbDouglas S r

/-- **Tullock contest-success function vanishes at zero own-input**.

paper source: cor:annihilation-from-tullock + Tullock 1980 CSF formula.
Source: Tullock 1980 contest-success function `p_i = x_i^r / Σ x_j^r`
    evaluated at `x_i = 0` with `r > 0`; specialized boundary behavior.

Statement. If the own-axis input of system `S` is zero, then the
contest-success probability for that axis (with any positive
discrimination parameter triple `r`) is zero. -/
axiom tullock_csf_vanishes_at_zero :
  ∀ (S : EconomicSystem) (k : CapabilityAxis) (r : TullockParameters),
    (axisValue S k : ℝ) = 0 →
    (TullockContestProbability S k r : ℝ) = 0

end InfluenceCapacity
