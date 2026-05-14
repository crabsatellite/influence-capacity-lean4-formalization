# InfluenceCapacity Lean 4 Formalisation

Companion Lean 4 formalisation to the paper:

> Li, A. C. (2026). *Influence Capacity Beyond GDP: An Axiomatic Three-Axis
> Decomposition*. SSRN Working Paper 6716498.
> v2.8 math-converged 2026-05-11 after R1-R10 D3 hostile review (0 factual
> issues at convergence, 24 fresh agents + 2 verifiers, ~45 patches).

## Structure

| File | Role |
|---|---|
| `lakefile.lean` | Lake project definition (Mathlib v4.16.0) |
| `InfluenceCapacity.lean` | Top-level re-export |
| `InfluenceCapacity/Types.lean` | Opaque types: `EconomicSystem`, `CapabilityAxis`, `Influence`, `Jacobian3`, `TullockParameters`, `HistoricalEra`, `IsHegemonicSteadyState`, `SmallShareRegime`, `IsAEBTopology`, `IsSelfProductiveTopology`, etc. |
| `InfluenceCapacity/ClassicalResults.lean` | Axiomatised classical theorems: Aczel 1966 multiplicative-Cauchy continuous-solution, Hartman-Grobman, Routh-Hurwitz 3×3, Bauer-Fike, finite-dim norm equivalence, Cox-Lewis mixed-Poisson dispersion, Topkis lattice decomposition, Cover-Thomas chain rule, Tikhonov slow-manifold, Tullock CSF small-share limit |
| `InfluenceCapacity/OpenHypotheses.lean` | Paper axioms (A0, A1, A2, A4) + 5 conditional hypotheses (slow-driver-regime, special-rank-1 fungibility, ex-ante regime-assignment protocol, small-share Tullock asymptotic, time-invariant cross-couplings) + inhabitation witnesses |
| `InfluenceCapacity/MainTheorem.lean` | Paper theorems as sorry-free Lean declarations: representation, A3+A5 redundancy, Tullock microfoundation, dynamics, threshold, meta-collapse, regime-(i)/(ii)/(iii) collapse-sequence, AEB, exponent-derivation, three-axes, hegemonic-margin, ex-ante-protocol corollaries, non-substitutability + cor:finite-share-tullock |
| `InfluenceCapacity/Ledger.lean` | Typed gap ledger per `feedback_gap_ledger_in_lean4.md`: every axiom + theorem + sub-clause with status (`gapOpen` / `gapPartial` / `gapBlocked` / `gapDeadEnd` / `gapClosed` / `gapClosedConditional` / `gapDefinitional`), input category (Cat 0/1/2/3), Cat 3 subtype where applicable, and attack history |

## Ledger state — strict trust discipline

| Status | Count | Group |
|---|---|---|
| `gapOpen` | dynamic | Load-bearing axioms, conditional hypotheses, external-method placeholders, and working assumptions still awaiting derivation |
| `gapClosed` | dynamic | Lean-closed via classical-axiom discharge / real Mathlib proof / inductive-type + rfl / explicit witness / discharge to paper-novel primitive axiom |
| `gapPartial` | dynamic | Structurally decomposed; substantive bodies / per-case witnesses still pending |
| `gapBlocked` | dynamic | Entries blocked by missing carrier construction or absent calibration data |
| `gapDeadEnd` | dynamic | Falsified or no-go routes preserved for planning |
| `gapClosedConditional` | dynamic | Sorry-free theorems that depend on explicit `Hyp_*` broken-link predicates |
| `gapDefinitional` | dynamic | Paper definitions / scope remarks that are starting commitments rather than closure targets |

Counts are tracked dynamically (`countByStatus`, `countByInputCategory`, and
`countByStatusAndInputCategory` in `Ledger.lean`); the table above is
qualitative. Current sources are **sorry-free**; `lake build` should not report
Lean `sorry` warnings.

### Taylor-F working assumption

R12-A converted two prior sorrys (`thm:threshold`, `thm:tension-cycle`) to
paper-bound axioms (`paper_thm_threshold_static_inequality_holds`,
`paper_thm_tension_cycle_band_holds`). They encode **closed algebraic /
spectral facts** the paper proves outright; the Lean axiom is honest because
Mathlib just lacks the specific PDMP / spectral lemma — the *statement* is
expressible over the existing opaque `EconomicSystem` carrier. R45 then
decomposed those monolithic axioms into smaller Cat 2/Cat 3 atoms where
possible.

`prop:taylor-F` is **categorically different**: its real blocker is the
`EconomicSystem` carrier port itself, because a concrete `F : ℝ³ → ℝ` is needed
to state the Hessian decomposition directly. The current encoding uses the
explicit working-assumption axiom `paper_prop_taylor_F_holds`, tracked as
`gap_axiom_paper_prop_taylor_F`, so `#print axioms` surfaces the dependency
instead of hiding it behind a raw `sorry`.

| Theorem | Status | Real blocker | Why this encoding |
|---|---|---|---|
| `thm:threshold` (static-inequality half) | decomposed Cat 3 atoms | Mathlib PDMP / ODE-trajectory lemmas for dynamic half | Static half derives from focal/non-focal/product atoms; dynamic persistence-time formula remains a carve-out |
| `thm:tension-cycle` (band statement) | Cat 2 Bartlett + Cat 3 paper-PDMP atom | Mathlib PDMP + Bartlett spectrum | Derived from explicit typed atoms rather than a monolithic paper axiom |
| `prop:taylor-F` | working-assumption axiom, `gapOpen` | The `EconomicSystem` carrier port itself | Dependency is explicit and ledgered; closure requires carrier-level `F` plus Mathlib multivariate Taylor/Hessian port |

### Lean closures

**Via classical-axiom discharge** (4):
- `thm:tullock-microfoundation` ← `tullock_csf_small_share_limit`
- `prop:nonlinear-stability` ← `hartman_grobman_local_stability`
- `prop:clustering` ← `cox_lewis_mixed_poisson_overdispersion`
- `cor:annihilation-from-tullock` ← `tullock_csf_vanishes_at_zero` (paper-bound axiom for CSF zero-input behavior)

**Via real algebraic / structural proof** (4):
- `A5_log_additivity_derivable` ← `Real.log_mul` + `Real.log_rpow` chain (with positivity hyp)
- `cor:finite-share-tullock` ← explicit witness + `pow_le_pow_left` + linarith
- `prop:strict-nesting` ← refactor `AlternativeCompositeIndex` to inductive + 5 rfls
- `thm:nonsubstitutability` ← `AnnihilatesAsAxisVanishes` def + `Real.zero_rpow`

**Via paper-bound axiom combination** (1):
- `thm:three-axes` ← Topkis ≥3 + paper-bound ≤3 + info-geometric/spectral-cluster correspondence + Tikhonov

**Via explicit count witness** (3, trivial-existential):
- `prop:ex-ante-classification` ← ⟨9, 1, 1, 11⟩ count tuple
- `cor:selection-bias-corrected-null` ← ⟨9, 3, 1, 15⟩ count tuple
- `prop:robustness-extension` ← ⟨0, 2, 0, 4⟩ count tuple

**`aczel_multiplicative_cauchy_power_form`** (ClassicalResults.lean) now has
a complete Lean proof (~80 lines) reducing via log/exp substitution to
`aczel_additive_cauchy_continuous_linear` axiom. Steps:
1. h(1) = 1 from StrictMono + h(1*1) = h(1)^2
2. h > 0 on positives via sqrt trick + StrictMono
3. φ(t) := log h(exp t) continuous (via `ContinuousAt.log`) + additive Cauchy
4. Aczel additive Cauchy → ∃ γ, ∀ t, φ(t) = γ * t
5. h(x) = exp(γ * log x) = x^γ via `Real.exp_log` + `Real.rpow_def_of_pos`
6. γ > 0 from h(2) > h(1) = 1

**`A3_redundant_from_A1_A2_A4`** (ClassicalResults.lean) now has a complete
Lean proof (~30 lines) via `aczel_multiplicative_cauchy_power_form` +
`Real.zero_rpow` + continuity at 0 from the right (`tendsto_nhds_unique`).

**`A5_log_additivity_derivable`** (MainTheorem.lean) now has a complete
algebraic proof (no sorry) using `Real.log_mul` + `Real.log_rpow`, under
positivity hypothesis on the three axis values. The boundary case
(any axis = 0) genuinely violates the unconditional equality, so
positivity is necessary, not restrictive.

### Paper-bound axioms added (R9)

Two new paper-bound axioms supporting `thm:three-axes` closure:
- `action_algebra_irreducible_count_le_three`: paper's claim that no
  4th irreducible component arises from reachable-set actions
  (complementing Topkis ≥3 lower bound).
- `info_geometric_eq_spectral_cluster`: paper's Step 2-3 link asserting
  that under `InformationGeometricIndependence m` + `SpectralSeparation`,
  the spectral cluster count equals m.

One new paper-bound axiom supporting `cor:annihilation-from-tullock`:
- `tullock_csf_vanishes_at_zero`: Tullock 1980 CSF formula
  `p_i = x_i^r / Σ x_j^r` evaluated at `x_i = 0` (with r > 0) gives 0.

**Paper-label coverage**:
- Ledger-explicit entries now cover all `thm/prop/lem/cor/def/ax/rem`
  labels found in `paper/influence_capacity.tex` by the R46 label diff
  audit.
- Paper definitions and protocol/scope remarks that are starting commitments
  are tracked as `gapDefinitional` instead of being counted as theorem
  closures.
- Remaining debt is mathematical, not coverage: several definitions still
  point to opaque carriers or external-method placeholders, but every labelled
  object is now searchable in `Ledger.lean`.

**Statement-level mathematical content**:
- 9 typed `ClassicalResults` axioms with typed Hypothesis → Conclusion
  forms (Hartman-Grobman, Routh-Hurwitz 3×3, Bauer-Fike, Cox-Lewis
  over-dispersion, Topkis lattice decomposition, Cover-Thomas
  independence-corollary, Tikhonov slow-manifold, Tullock small-share
  Cobb-Douglas, finite-dim norm equivalence).
- 4 typed Cobb-Douglas-related theorems (`thm_representation`,
  `A3_redundant_from_A1_A2_A4`, `A5_log_additivity_derivable`,
  `aczel_multiplicative_cauchy_power_form`).
- 3 typed collapse-sequence theorems (`thm_collapse_sequence`,
  `thm_collapse_sequence_info`, `thm_collapse_aeb`) — conclusions use
  `HasCollapseOrdering` predicate from `Types.lean`.
- **3 theorems CLOSED in Lean via direct discharge** to a classical
  axiom (no `sorry`):
  - `thm:tullock-microfoundation` ← `tullock_csf_small_share_limit`
  - `prop:nonlinear-stability` ← `hartman_grobman_local_stability`
  - `prop:clustering` ← `cox_lewis_mixed_poisson_overdispersion`
- All remaining ~38 paper theorems / propositions carry **typed
  conclusions** (no `True` placeholders) using either:
  - Existing classical / Mathlib predicates (e.g.,
    `InterShockCV2`, `LocallyExponentiallyStable`,
    `LogInfluenceFactorisesAsCobbDouglas`).
  - 50+ new opaque `Prop` predicates in `Types.lean` Section 14, each
    paper-source-bound (e.g., `MetaCollapseSlowestFirstHolds`,
    `IsLinearizedCoupledODE`, `Has12x12LagJacobianEigenvalueBand`).
  - Existential / equation forms for direct numerical claims
    (`prop_theta_bar_derived`, `thm_threshold_case_specific`,
    `cor_finite_share_tullock`, `cor_ex_ante_pvalue`).

**Known residuals** (deferred for future rounds):
- Several typed-conclusion theorems still close by explicit paper-source-bound
  opaque predicates or working assumptions. These are surfaced through
  `#print axioms` and `LedgerEntry` records rather than raw `sorry`.
- 13 opaque `Prop` predicates in `Types.lean` Section 14 are
  parameterless or thinly-parameterized (e.g., `RelaxingA*` siblings,
  `CrossScaleNonSubValidatedSixCases`, `IsStrangeIncommensurabilityEmbeddedAsParametric`,
  `IsSlowStockProjectionOfThreeAxes`) — Phase 4 hostile audit flagged
  these as content-light; future rounds should parameterize them on
  the relevant paper objects.
- A0/A1/A2/A4 holding-predicates in `Types.lean` are bare Props (not
  parameterized on the aggregator F) — Phase 4 hostile audit flagged
  this; should be `(EconomicSystem → NNReal × NNReal × NNReal → ℝ) → Prop`
  in a future rewrite.

## Build instructions

```bash
cd lean4-formalization
lake update           # fetch Mathlib v4.16.0
lake exe cache get    # download pre-built cache (don't rebuild Mathlib!)
lake build            # builds InfluenceCapacity in O(seconds) given cache
```

`lake build` builds the InfluenceCapacity library. The current source should be
sorry-free; remaining debt is represented by explicit opaque axioms and ledger
entries, not hidden proof placeholders.

## Round naming convention

Two distinct R-N round sequences are tracked:

1. **Paper hostile-review rounds (R1-R10)** — the D3 mathematical-correctness
   audit cycle of the source paper (`influence_capacity.tex`,
   v2.8 math-converged 2026-05-11; 24 fresh agents + 2 verifiers; ~45
   factual patches; 0 issues at R10 convergence). These are recorded
   in `Ledger.attackHistory` field entries dated `2026-05-11` (e.g.,
   `"R5-patch-2026-05-11-clarified-..."`).
2. **Lean formalisation rounds (R0, R1, R2, R3, ...)** — fresh-agent
   hostile-review iteration of this Lean scaffold itself. These are
   tracked in commit messages, not in attackHistory entries. R0 was
   the initial scaffold; each subsequent R-N is an iterative refinement
   after fresh-agent review.

Per `feedback_gap_ledger_in_lean4.md` Phase 5: round-specific bookkeeping
annotations in Lean docstrings have lost reference value once committed.
The Ledger `attackHistory` field is the canonical round-trace location
for paper-R rounds; commit messages track Lean-R rounds.

## Hostile review protocol (per `feedback_gap_ledger_in_lean4.md`)

Each round dispatches:

1. **Phase 0** (pre-Lean-design): hostile literature verification of cited
   theorem(s). Does the literature contain the SPECIFIC sub-claim asserted?
   Are antecedents preserved in the Lean signature?
2. **Phase 1**: independent triple-source agents confirming math statement.
3. **Phase 2** (Lean writer): write closure with attribution honest to
   Phase 0 findings. Citation-sweep across sibling entries if Phase 0
   caught a citation defect.
4. **Phase 3**: build verify (`lake build`) + commit.
5. **Phase 4** (post-closure hostile re-audit): fresh hostile reviewer
   checks the LEAN ENCODING faithfully represents the literature
   (no overclaim, no dropped antecedents).
6. **Phase 5** (comment cleanup): once round committed, strip
   round-specific bookkeeping annotations from docstrings.

## References

Paper-cited classical results in `ClassicalResults.lean`:

- J. Aczel, *Lectures on Functional Equations and their Applications*,
  Academic Press (1966).
- P. Hartman, Proc. Amer. Math. Soc. 11 (1960). D. M. Grobman, Mat. Sb. 56
  (1962). H. K. Khalil, *Nonlinear Systems* 3rd ed., Prentice Hall (2002).
- A. Hurwitz, Math. Ann. 46 (1895). E. J. Routh, *Treatise on Stability*,
  Macmillan (1877).
- F. L. Bauer and C. T. Fike, Numer. Math. 2 (1960). G. H. Golub and C. F.
  Van Loan, *Matrix Computations*, 4th ed., Johns Hopkins (2013).
- D. R. Cox and P. A. W. Lewis, *Statistical Analysis of Series of Events*,
  Methuen (1966). D. J. Daley and D. Vere-Jones, *Theory of Point
  Processes*, 2nd ed., Springer (2003).
- D. M. Topkis, *Supermodularity and Complementarity*, Princeton (1998).
- T. M. Cover and J. A. Thomas, *Elements of Information Theory*, 2nd ed.,
  Wiley (2006).
- A. N. Tikhonov, Mat. Sb. 31 (1952). C. Kuehn, *Multiple Time Scale
  Dynamics*, Springer (2015).
- G. Tullock, in *Toward a Theory of the Rent-Seeking Society*, Texas A&M
  Press (1980). S. Skaperdas, Econ. Theory 7 (1996). K. A. Konrad,
  *Strategy and Dynamics in Contests*, Oxford UP (2009).
