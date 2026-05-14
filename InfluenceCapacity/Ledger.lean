/-
# Gap Ledger for InfluenceCapacity formalisation.

Per the gap-ledger-in-Lean4 methodology, every gap in the Three-Axis
Influence-Capacity formalisation is recorded here as a typed metadata
declaration with explicit status, closure-distance to published
literature, decomposability into sub-clauses, computability classification,
attack vector, attack history, and obstacle citation (mandatory for
gapBlocked / gapDeadEnd entries).

Failure cases (gapBlocked routes) and dead-end attempts are preserved with
their cited obstacles, not deleted. Pre-attack check: orchestrator
confirms target is `gapOpen` or `gapPartial` before launching attack;
re-attempting `gapBlocked` or `gapDeadEnd` is a context-drift failure mode
and must be flagged.

## Ledger status

 * 4 load-bearing paper axioms (A0, A1, A2, A4) — all `gapOpen` (paper
 explicitly conditional inputs).
 * 5 conditional hypotheses (slow-driver-regime, special-rank-1
 fungibility, ex-ante regime-assignment protocol, small-share Tullock
 asymptotic, time-invariant cross-couplings) — all `gapOpen`.
 * Paper theorems / propositions / corollaries / definitions encoded as
 `gapClosed` in Lean (current live count via `#eval countByStatus
 GapStatus.gapClosed`; not pinned to a static number to avoid drift —
 the authoritative count is the `#eval` result, not this prose). Every
 invoked axiom belongs to exactly one of:
 (a) classical-literature theorem — Aczel, Lyapunov indirect method,
 Routh-Hurwitz, Cox-Lewis, Topkis, Cover-Thomas independence-
 decomposition, Tikhonov-Fenichel, Tullock CSF boundary behavior;
 (b) Mathlib standard library;
 (c) paper-NOVEL primitive — A0/A1/A2/A4 + 5 conditional hypotheses
 + calibration numerics + paper-claim primitives (Hamel basis,
 fourth-axis per-candidate, structural posit
 `thm:exponent-derivation`, uw-subsumes, cross-scale-portability,
 two-regimes empirical dichotomy, aggregator multi-base-point A4
 + γ-calibration, NU/NU* spectrum parameterization, meta-collapse
 principle with 3 antecedents, AEB two-channel decomposition,
 `baselineForcingsOf`).
 Closure techniques: discharge to classical axiom; real algebraic
 Lean proof using Mathlib; inductive-type + rfl chain; explicit
 existential witness; discharge to paper-novel primitive axiom.
 * Theorem-discharge status:
 - Current Lean sources are sorry-free. Earlier raw proof placeholders
 have either been closed, decomposed into smaller typed atoms, or surfaced
 as explicit working-assumption axioms.
 - `prop:taylor-F` is still mathematically open as a carrier-port debt,
 but no longer hides behind a raw `sorry`: theorem `prop_taylor_F`
 depends on the explicit Cat 3 working-assumption axiom
 `paper_prop_taylor_F_holds`, with companion ledger entry
 `gap_axiom_paper_prop_taylor_F`.
 - `cor:finite-share-tullock` — bound arithmetic Lean-PROVED
 (`finite_share_deviation_cube_bound`, -B.1); the
 `FiniteShareDeviationBound` predicate now has a substantive body
 over the 3-axis-share form.
 - `prop:axis-independence` — `AdmitsDiscriminatingPairOnAxis` now
 has a substantive body (: `∃ S₁ S₂, axisValue S₁ k ≠
 axisValue S₂ k ∧ ∀ k' ≠ k, axisValue S₁ k' = axisValue S₂ k'`);
 the 3 part-(b) witness existence claims remain carrier-pending
 sub-axioms, the part-(a) Sard claim remains Mathlib-Sard-pending.
 - + P-3g (axiom-hygiene refactor, COMPLETE): converted
 `axiom EconomicSystem : Type` to `structure EconomicSystem` and
 folded ALL 19 projected accessor axioms into structure projection
 fields. Phases A+B (3 capability + 8 plain
 NNReal/ℝ = 11 fields, −11 axioms); the unblock
 via mechanical file reorder — moved the 5 forward-referenced type
 declarations (`CapabilityAxis` + `DecayRates` + `CrossCouplings` +
 `BaselineForcings` + `Jacobian3`) to BEFORE the `EconomicSystem`
 structure declaration, then folded in the remaining 8 accessors
 (`jacobianOf`, `baselineForcingsOf`, `SurvivalWeight`,
 `discriminationParameter`, `fungibilityMatrix`, `rentLoading`,
 `leakageFactor`, `slowEnvelopeAmplitude`). Cumulative net axiom
 delta: −19, matching the original projection. The 3
 derived-equality axioms (`influence_via_aggregator`,
 `networkPosition_via_spectrum`, `nuStarMeasure_via_spectrum`) +
 the 3 constraint axioms (`discriminationParameter_pos`,
 `slowEnvelopeAmplitude_nonneg`, `SurvivalWeight_nonneg`) all
 retained as `∀ S` axioms per the scoped plan (NOT lifted to
 structure fields). Caller impact: ZERO (all 19 names exported, so
 existing `f S` call sites continue to work). NOT a gap-closer per
 — the canonical instances `canonicalPost1815System` /
 `canonicalAEBMongolSystem` remain `axiom : EconomicSystem` because
 the paper lacks numerical values for several mandatory fields
 (`fungibilityMatrix`, `leakageFactor`, `slowEnvelopeAmplitude`,
 absolute capability/output values).
 - thm:exponent-derivation cluster: all of
 Step-1/2/3's predicates (`SmallCouplingRegime`,
 `HasSlowEnvelopeAmplitudeFormula`, `HasSurvivalWeightBoxedFormula`,
 `IsUniformDiscriminationLoading`, `IsSpecialRank1FungibilityForm`)
 have substantive bodies. `SmallCouplingRegime` and `decayRate`
 are `def`s over the pre-existing `jacobianOf` (no new opacity).
 5 accessors remain opaque axioms: `discriminationParameter`,
 `fungibilityMatrix`, `rentLoading`, `leakageFactor`,
 `slowEnvelopeAmplitude`.

 * SCOPING FINDING — the `EconomicSystem` structure refactor
 (turn `axiom EconomicSystem : Type` into a `structure` so the 5
 opaque accessors become projections and `canonicalPost1815System` /
 `canonicalAEBMongolSystem` become concrete literals) was scoped by a
 hostile pre-audit and is **NOT a gap-closer**. Reason: the canonical
 instances cannot be completed honestly — the paper does NOT give
 numerical values for `fungibilityMatrix` `φ_{k,ℓ}` (given only
 structurally: `φ_{kk}=1` and the form `φ_{k,ℓ}=u·β_ℓ`, never
 numerically pinned — the `α_{MU,*}=0.02` "calibrated A" is a
 different object the paper explicitly flags as a phenomenological
 fit, not the rank-1 microfoundation), nor for `leakageFactor` `L_k`
 (= `(1/R)∑φ_{k,ℓ}r_ℓ`, no `φ` ⇒ no `L`), nor `slowEnvelopeAmplitude`
 `ρ_k`, nor the absolute `productiveCapacity` / `mobilizableSurplus`
 / `networkPosition` / `Influence` / `usefulWork` / `gdp` /
 `valueAdded` / `nuStarMeasure` / `singularSpectrumScale` /
 `systemRelaxationTime` / `systemExpectedShockInterval` values
 (the paper normalizes peaks to a common value but never gives
 absolutes). So the TRUE terminal blocker for the accessor
 bodies and for the carrier-pending witnesses (`prop:axis-independence`
 part-(b), the firm-level facets, the `LocatedIn*` residual bodies)
 is the paper's CALIBRATION SCOPE, not Lean engineering. The structure
 refactor, if done, is pure axiom-hygiene (≈ −19 accessor axioms,
 medium risk, +3-4 mandatory derived-equality fields like
 `influence_eq`/`*_via_spectrum`); it must be billed as hygiene, NOT
 as closure. The * `obstacleCitation`s that say "give X a body
 by turning `EconomicSystem` into a structure" are over-optimistic in
 this respect — read them together with this note.

Entry count is tracked dynamically (`allEntries.length`); the
status-distribution counts via `countByStatus`/`filterByStatus`.

Round-by-round status promotions live in each entry's `attackHistory`
field; status-distribution counts are tracked dynamically via
`countByStatus` and `filterByStatus` (defined below).

## status × inputCategory cross-table

The discipline update introduces a SECOND mandatory
classification orthogonal to status: the 4-input-category (Cat 0
kernel / Cat 1 Mathlib-derivable / Cat 2 external published / Cat 3
our paper novel).

`inputCategory` is a typed field on `LedgerEntry`; current counts are
read from `countByInputCategory` / `countByStatusAndInputCategory`.
Static tables below are historical audit notes.

Cross-table for the **- + + + incremental work**
(the new entries introduced in this session — full re-classification
of the inherited ~84 older entries is a separate audit round queued):

| | Cat 1 (Mathlib) | Cat 2 (external) | Cat 3 (paper-novel) |
|--------------|-----------------|------------------|---------------------|
| gapClosed | 5 | 2 | 0 |
| gapPartial | 0 | 1 ( IGCDF) | 3 |
| gapBlocked | 0 | 0 | 0 |
| gapDeadEnd | 0 | 0 | 0 |
| gapOpen | 0 | 0 | 5 |
| **subtotal** | **5** | **3** | **8** |

 progress: 3 new Cat 2 ports closed/partially closed the -flagged
Cat 2 ↔ Cat 3 disconnects:
* `gap_def_IGDensity` (gapClosed Cat 2 — Schrödinger 1915 / Tweedie 1957
 closed form via Mathlib `Real.sqrt` + `Real.exp` + `Real.pi`).
* `gap_axiom_IGCDF` (gapPartial Cat 2 — Borodin-Salminen 2002 closed
 form, opaque axiom pending Mathlib standard normal CDF).
* `gap_def_NickellBiasFormula` (gapClosed Cat 2 — Nickell 1981 Eq. 18
 closed form, direct).

Net Cat 3 axiom delta over - = 0 (5 endomorphism axioms removed
in refactor + 5 isComplement axioms introduced); but the 5
endomorphism CONCLUSIONS are now CLOSED theorems composing Cat 1
bridge `complement_isEndomorphism` (Mathlib `ne_of_gt`) + Cat 3
`paper_K_X_isComplement` premises. Per discipline goal: closure via
composition of Cat 1+2+3 inputs is the standard close path.

Notes:
* The 3 Cat 3 gapPartial entries are `gap_rem_ig_first_passage_mle`
 (++ reductionism), `gap_rem_var_spectral_test_info_era`
 (+++++), and `gap_rem_fourth_axes_info_era`.
 Each has documented Cat 2 dependencies (Schrödinger 1915 / Tweedie
 1957 / Borodin-Salminen 2002 for IG; Nickell 1981 for VAR bias;
 Topkis 1978/1998 Ch. 2 for endomorphism); reductionism review
 classified each as Cat 3-with-Cat-2-disconnect (Cat 2 in docstring,
 not in Lean signature).
* The 5 Cat 3 gapOpen entries are the sibling endomorphism axioms
 (`gap_predicate_K_AI_compute_isEndomorphism` etc.); each shares the
 same Cat 2-disconnect status against Topkis 1978/1998 Ch. 2.
* The Lean theorems for +++ are Cat 1 themselves (rational-
 arithmetic witnesses via norm_num/decide); they witness Cat 3 paper
 claims with the indicated Cat 2 dependencies. The Cat 1 theorem
 count is tracked separately from the Cat 3 paper-claim count.

** + + LEGACY classification** (84 inherited pre-
entries; classified by hostile-review agent + reclassifications +
 Cat 3 → Cat 1 reductions for theorems with zero paper_* axioms):

| | Cat 1 (Mathlib) | Cat 2 (external) | Cat 3 (paper-novel) |
|--------------|-----------------|------------------|---------------------|
| **subtotal** | **17** (+7) | **16** (+2) | **51** (−2,−7) |

 executed reclassifications:
* `gap_lem_budget_feedback` Cat 3 → Cat 2 (Cobb-Douglas FOC, MWG Ch. 3)
* `gap_cor_ex_ante_pvalue` Cat 3 → Cat 2 (binomial-tail bound; standard
 probability theory once Mathlib binomial wired)
* `gap_prop_nu_removal` stays Cat 3 (the cardinal-up-to-constant claim
 is genuinely paper-novel; the ordinal half is a sub-claim that could
 be split out but is not currently a separate Ledger entry).

 executed reclassifications (per scientific principle 能推就要全推):
Theorem-encoding scan revealed 7 Cat-3-tagged entries are actually Cat 1
Lean closures (proofs use ZERO paper_* axioms, no sorry — pure Mathlib
+ composition of earlier theorems):
* `gap_prop_theta_bar_case` Cat 3 → Cat 1
* `gap_cor_composite_margin` Cat 3 → Cat 1
* `gap_cor_cross_scale_nonsub` Cat 3 → Cat 1
* `gap_prop_two_anchors` Cat 3 → Cat 1
* `gap_prop_mu_reachability` Cat 3 → Cat 1
* `gap_prop_two_axis_reduction` Cat 3 → Cat 1
* `gap_prop_four_axis_reduction` Cat 3 → Cat 1
Verified each via Python regex scan: `theorem X := body` with body
containing no `paper_*_axiom` reference and no `sorry`.

**Historical total across the legacy 100 ledger entries** (16 incremental + 84 legacy):

| | Cat 1 (Mathlib) | Cat 2 (external) | Cat 3 (paper-novel) |
|--------------|-----------------|------------------|---------------------|
| **GRAND** | **22** | **19** | **59** |

**Cat 3 budget**: 59 / ~80 paper novel-claim slots = **74%** (down
from 82.5% pre- — meaningful reduction via discipline-strict
reductionism review).

** also corrected** the finding that 5 sibling axioms have
"Cat 2 dependency on Topkis 1998 Ch. 2" — this was folkloric inflation
(Topkis Ch. 2 supplies vocabulary, not the absorption theorem). The 5
sibling isComplement axioms are now classified as **pure Cat 3** (no
Cat 2 chained dependency); the count stays the same since they were
already Cat 3 in the totals.

**Cat 3 budget check (current)**: 103 Cat 3 entries against paper claim
inventory comprising ~12 main results + ~50 secondary theorems / props /
corollaries + ~10 model-extension remarks + ~30 component-predicate
decompositions (3 residual predicates for cor:exponent-sensitivity, 4
firm-level predicates for prop:cross-scale-portability, 5 sibling
isComplement entries for rem:fourth-axes-info-era, 5 fourth-axis-candidate
predicates for prop:fourth-axes, 7 model-extension materialisations, 3
Sard decomposition sub-atoms, 6 structural-tension carriers + weights).
Current Cat 3 / total ratio = 103/153 = 67%, above the §3.4.7 50%
threshold and so the §5 mandatory ≥2-round hostile reduction was
triggered and executed (see two reductionism rounds documented in the
following paragraphs). Component-predicate decomposition is the
discipline-prescribed pattern (§13 right-workflow), not bloat — each
Cat 3 entry traces to a paper-stated `\label{...}` (rem/prop/thm/cor/def)
or paper-stated structural sub-claim.

**Cat 3 reductionism Round 2 (Cat 3 → Cat 2 sweep)** — discipline §5
mandates ≥2 hostile review rounds per Cat 3 declaration; Round 1
(Cat 3 → Cat 1) executed 7 reductions; Round 2 (Cat 3 → Cat 2)
findings:
* `gap_cor_ex_ante_pvalue` — RECLASSIFIED Cat 3 → Cat 2 (binomial-tail
 bound, textbook probability theory).
* `gap_lem_budget_feedback` — RECLASSIFIED Cat 3 → Cat 2 (Cobb-Douglas
 demand FOC, MWG Ch. 3 textbook microeconomics).
* `gap_prop_nu_removal` — STAYS Cat 3 (cardinal-up-to-constant is the
 paper-novel content; ordinal-preservation half could be split out as
 Cat 2 functional analysis but is not a separate Ledger entry currently;
 split deferred to a follow-on entry-level refactor).
* Remaining 50 Cat 3 entries surveyed: paper meta-principles, paper-
 novel predicates/structural-eq, working-assumptions for paper
 theorem conclusions — all genuinely paper-novel (no further Cat 2
 attribution found in Round 2).
Both rounds satisfied per §5 mandatory-≥2-rounds discipline.

**Per-entry classification table** stored in commit message of 
(rather than inline; expanding this file would pass 50 KB and slow the
build). Top-3 candidates above are inline-flagged for follow-up.

Paper-label coverage audit: every TeX label matching
`thm/prop/lem/cor/def/ax/rem:*` in `paper/influence_capacity.tex` has
a corresponding searchable `LedgerEntry`. Legacy category comments were
promoted to typed `inputCategory` fields; paper definitions and protocol
remarks that are starting commitments use `gapDefinitional`.
-/

import InfluenceCapacity.Types
import InfluenceCapacity.ClassicalResults
import InfluenceCapacity.OpenHypotheses
import InfluenceCapacity.MainTheorem

namespace InfluenceCapacity.Ledger

/-! ## Status and source-of-truth taxonomies -/

/-- Status of a gap. Six canonical tiers per discipline (2026-05-13 update
 added `gapClosedConditional`), plus the discipline's proposed
 `gapDefinitional` tier for Cat 3 paper-novel atoms that are starting
 commitments rather than closure targets. Reserved Lean keywords `open` and
 `partial` are avoided by the `gap` prefix. -/
inductive GapStatus where
  | gapOpen
  | gapPartial
  | gapBlocked
  | gapDeadEnd
  | gapClosed
  | gapClosedConditional
  | gapDefinitional
deriving Repr, DecidableEq

/-- Orthogonal source-of-truth classification for every ledger entry. Cat 0 is
 retained for kernel baselines even though it is not counted in paper-side
 statistics. -/
inductive InputCategory where
  | cat0Kernel
  | cat1Mathlib
  | cat2External
  | cat3PaperNovel
deriving Repr, DecidableEq

/-- Sub-classification required for Cat 3 entries, per `feedback_gap_ledger_in_lean4.md`
 §3.4 (six canonical sub-types). `notCat3` is used for Cat 0/1/2 entries and for
 legacy entries whose Cat 3 subtype still needs a follow-up narrowing pass.

 Canonical 6 sub-types:
   * `carrier` — paper primitive type (永不 close)
   * `hypothesisPredicate` — paper scope/regime predicate (永不 close)
   * `structuralDefiningEquation` — paper definitional equation on its primitives
     (永不 close)
   * `workingAssumption` — temporarily axiomatized higher-level claim pending
     derivation (必须 close before publication)
   * `conditionalHypothesis` — paper conclusion conditional on external open
     problem (永不 close, encoded as theorem antecedent not axiom)
   * `phenomenologicalConjecture` — framework paper's substantive claim about a
     phenomenon awaiting external validation (永不 Lean-close)
 -/
inductive Cat3SubType where
  | notCat3
  | carrier
  | hypothesisPredicate
  | structuralDefiningEquation
  | workingAssumption
  | conditionalHypothesis
  | phenomenologicalConjecture
deriving Repr, DecidableEq

/-- Metadata record for one gap. The Lean `Prop` statement of the gap
 itself lives in `OpenHypotheses.lean` or `MainTheorem.lean` (or in
 this file for memory-derived gaps).

 Invariant: `conditionalOn ≠ [] ↔ status = gapClosedConditional`.
 Each name in `conditionalOn` references a separate `Hyp_*` broken-link
 predicate that has its own ledger entry (typically `gapOpen` pending
 repair).

 `inputCategory` is deliberately a field rather than a comment: the ledger can
 now compute status × source-of-truth tables and `#eval` them without relying
 on docstring parsing. -/
structure LedgerEntry where
  identifier        : String
  paperLabel        : String
  status            : GapStatus
  inputCategory     : InputCategory
  cat3SubType       : Cat3SubType := Cat3SubType.notCat3
  closureDistance   : String
  decomposability   : String
  computability     : String
  attackVector      : String
  attackHistory     : List String
  obstacleCitation  : Option String
  conditionalOn     : List String := []
deriving Repr

/-! ## Group A: 4 load-bearing axioms -/

/-- paper source: ax:commensurability; Lean: `OpenHypotheses.A0_commensurability`
 (Lean-derived conjunction of A0a + A0b axioms). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_A0_commensurability : LedgerEntry := {
  identifier := "ax:commensurability"
  paperLabel := "A0 = A0a ∧ A0b"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Two load-bearing clauses (paper Axiom A0 split into A0a + A0b per hostile-audit recommendation): A0a (existence of relabeling-invariant σ-finite measure μ, weak Carathéodory-extension prior) + A0b (product decomposition μ = μ_R ⊗ μ_T, Fubini-style independence, substantively stronger and load-bearing for `thm:decomposition`'s per-axis sectional decomposition). Cross-era commensurability is NOT asserted (paper `prop:strange-as-era-varying`); rejecting A0b is the substantive empirical position of the structural-power tradition. The conjunction A0_commensurability is Lean-derived from the two clause axioms."
  decomposability := "2 sub-clauses: A0a (existence) + A0b (product decomposition). A0b carries the load-bearing role; A0a is the weak prior."
  computability := "philosophical-prior; not a computational claim."
  attackVector := "Keep A0a + A0b as labelled hypothesis pair; conjunction is Lean-derived theorem."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: ax:continuity; Lean: `OpenHypotheses.A1_continuity`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_A1_continuity : LedgerEntry := {
  identifier := "ax:continuity"
  paperLabel := "A1"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Standard regularity hypothesis. Used in tandem with A4 (multiplicative Cauchy) to invoke Aczel 1966 §2.1 and rule out pathological non-Lebesgue-measurable additive solutions."
  decomposability := "1 atomic claim: per-axis function h_i continuous on ℝ_{>0}."
  computability := "regularity hypothesis."
  attackVector := "Keep as labelled axiom; not derivable from substantive content."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: ax:monotonicity; Lean: `OpenHypotheses.A2_monotonicity`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_A2_monotonicity : LedgerEntry := {
  identifier := "ax:monotonicity"
  paperLabel := "A2"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Substantive claim: more useful work / mobilization / network centrality each weakly increase influence. Supported by every historical case in §sec:experiments."
  decomposability := "1 atomic claim: per-axis function h_i strictly increasing on ℝ_{>0}."
  computability := "empirical claim; defended on every case."
  attackVector := "Keep as labelled axiom; defended empirically."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: ax:multiplicative-scaling; Lean:
 `OpenHypotheses.A4_multiplicative_scaling`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_A4_multiplicative_scaling : LedgerEntry := {
  identifier := "ax:multiplicative-scaling"
  paperLabel := "A4"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Structural choice. Combined with A1+A2 forces power form via Aczel 1966 (multiplicative Cauchy continuous-solution theorem). Without A4, additive cross-terms allowed; comparative-statics predictions across hegemonic transitions become inconsistent (paper Prop relaxation)."
  decomposability := "1 atomic claim: per-axis multiplicative Cauchy functional equation h_i(xy) = h_i(x) h_i(y) for x, y > 0."
  computability := "structural choice; load-bearing for representation theorem."
  attackVector := "Keep as labelled axiom; load-bearing for Cobb-Douglas."
  attackHistory := []
  obstacleCitation := none
}

/-! ## Group B: 2 derivable redundancies (A3, A5 follow from A1+A2+A4) -/

/-- **gapClosed**: derived from A1+A2+A4 via Aczel chain. paper source:
 ax:annihilation (A3);
 Lean: `MainTheorem.A3_zero_axis_annihilation_derivable` (theorem,
 not axiom; reduces to `aczel_multiplicative_cauchy`). -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_A3_zero_axis_annihilation : LedgerEntry := {
  identifier := "ax:annihilation"
  paperLabel := "A3"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "PUBLISHED. Direct consequence of A1+A2+A4 via Aczel 1966 multiplicative-Cauchy continuous-solution theorem: continuous multiplicative monotone solutions h on ℝ_{>0} are h(x) = x^γ with γ > 0; all such satisfy h(0) = 0."
  decomposability := "1 atomic claim, derived as theorem (not axiom)."
  computability := "PUBLISHED (Aczel 1966 §2.1)."
  attackVector := "CLOSED in Lean. `A3_zero_axis_annihilation_derivable` (MainTheorem.lean) := `A3_redundant_from_A1_A2_A4` (ClassicalResults.lean), which has a complete proof via `aczel_multiplicative_cauchy_power_form` + `Real.zero_rpow` + `Real.continuous_rpow_const` + `tendsto_nhds_unique`."
  attackHistory := ["-patch--acknowledged-A3-redundancy-alongside-A5-via-h(0)=h(x)h(0)-A2..."]
  obstacleCitation := none
}

/-- **gapClosed**: derived from A1+A2+A4 via Aczel chain. paper source:
 ax:log-additivity (A5);
 Lean: `MainTheorem.A5_log_additivity_derivable` (theorem,
 not axiom; direct algebraic computation on Cobb-Douglas form). -/
-- inputCat: Cat 1


def gap_A5_log_additivity : LedgerEntry := {
  identifier := "ax:log-additivity"
  paperLabel := "A5"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED (paper Step 5). Cobb-Douglas form (derived from A1+A2+A4 via Aczel) automatically satisfies log F = log K + a log PI + b log MU + c log NU; cross-partials zero by direct computation."
  decomposability := "1 atomic claim, derived as theorem (not axiom)."
  computability := "PUBLISHED (paper Step 5 of `thm:representation` proof)."
  attackVector := "CLOSED. Theorem `A5_log_additivity_derivable` in `MainTheorem.lean`."
  attackHistory := ["paper-Step-5-acknowledgment-of-A5-redundancy-since-v1.0", "-patch--strengthened-A3+A5-jointly-derivable-framing"]
  obstacleCitation := none
}

/-! ## Group C: 5 conditional hypotheses -/

/-- paper source: prop:clustering proof slow-driver caveat; Lean:
 `OpenHypotheses.hyp_slow_driver_regime`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_hyp_slow_driver_regime : LedgerEntry := {
  identifier := "hyp:slow-driver-regime"
  paperLabel := "prop:clustering (slow-driver hypothesis)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Structural restriction. Paper-acknowledged necessary condition for the strict CV² > 1 claim (mixed-Poisson identity). Outside the slow-driver regime, only weaker law-of-total-variance bound survives."
  decomposability := "1 atomic claim: T(s) varies on a timescale long compared to inter-shock gaps."
  computability := "regime restriction; not derivable."
  attackVector := "Keep as labelled hypothesis; restricting Prop `prop:clustering` strict claim to slow-driver regime is the honest framing."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: thm:exponent-derivation Step 2 (special-rank-1 form);
 Lean: `OpenHypotheses.hyp_special_rank_1_fungibility`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_hyp_special_rank_1_fungibility : LedgerEntry := {
  identifier := "hyp:special-rank-1-fungibility"
  paperLabel := "thm:exponent-derivation Step 2"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Structural assumption (disjunctive). Either uniform r_ℓ across ℓ (under calibration r ∈ [0.21, 0.40] holds to within factor 2) OR special-rank-1 phi_kℓ = u · β_ℓ with axis-independent u. The more-general rank-1 phi_kℓ = α_k β_ℓ leaves α_k axis-dependent residual; not enough to make L_k axis-independent. the disjunction is now TYPE-LEVEL visible — `IsSpecialRank1Fungibility` is a definitional alias of canonical `IsLeakageAxisIndependent` (Types.lean Section 14), which is `def`-defined as `IsUniformDiscriminationLoading S ∨ IsSpecialRank1FungibilityForm S`. A Lean proof using `hyp_special_rank_1_fungibility S` hypothesis can `cases`-destruct the disjunction to access either branch independently."
  decomposability := "2 typed alternatives via Or: (a) `IsUniformDiscriminationLoading` (uniform r_ℓ); (b) `IsSpecialRank1FungibilityForm` (φ_{k,ℓ} = u · β_ℓ with u axis-independent). Each component is currently a separate opaque axiom pending typed `r_ℓ` / `φ_{k,ℓ}` accessors."
  computability := "structural assumption."
  attackVector := "Keep as labelled hypothesis; substantive content is the disjunction. disjunction elevated to type level; component-predicate typed bodies queued."
  attackHistory := ["-patch--tightened-rank-1-to-special-rank-1-with-axis-independent-coefficient...", "-patch---audit-confirmed-disjunction-elevated-to-type-level-via..."]
  obstacleCitation := some "(queued): give the 2 component predicates substantive bodies. `IsUniformDiscriminationLoading` requires typing `r_ℓ : EconomicSystem → CapabilityAxis → ℝ` accessor. `IsSpecialRank1FungibilityForm` requires typing `φ_{k,ℓ} : EconomicSystem → CapabilityAxis → CapabilityAxis → ℝ` accessor."
}

/-- paper source: prop:ex-ante-classification preamble; Lean:
 `OpenHypotheses.hyp_ex_ante_regime_assignment_protocol`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_hyp_ex_ante_regime_assignment_protocol : LedgerEntry := {
  identifier := "hyp:ex-ante-regime-assignment-protocol"
  paperLabel := "prop:ex-ante-classification preamble (regime-assignment protocol stipulation)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "PROCEDURAL stipulation. Regime classification + measurement convention locked from primitives observable at the latest pre-crossing date; no post-hoc reclassification (Mughal central-treasury MU stays as lock-date choice)."
  decomposability := "1 atomic procedural stipulation."
  computability := "procedural; not derivable."
  attackVector := "Keep as labelled hypothesis; the protocol is what makes the binomial null calculation honest."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: thm:tullock-microfoundation hypothesis + Remark
 `rem:linearization-caveats` clause (iii); Lean:
 `OpenHypotheses.hyp_small_share_tullock`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_hyp_small_share_tullock : LedgerEntry := {
  identifier := "hyp:small-share-tullock"
  paperLabel := "thm:tullock-microfoundation + rem:linearization-caveats (iii)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Asymptotic regime. Holds strictly in small-share limit; hegemonic-state applications operate at the BOUNDARY (s_max ≈ 0.74 for raw 70% reserve-currency leader), with finite-share corrections of `cor:finite-share-tullock` carrying the cardinal load."
  decomposability := "1 atomic asymptotic regime restriction."
  computability := "regime restriction; not derivable."
  attackVector := "Keep as labelled hypothesis; cardinal claims subject to `cor:finite-share-tullock` correction; qualitative ordering theorem survives via slow-mode eigenvalue insensitivity to within-row reweighting (Remark linearization-caveats clause iii)."
  attackHistory := ["R1-patch--added-clause-(iii)-to-rem-linearization-caveats-acknowledging-small..."]
  obstacleCitation := none
}

/-- paper source: rem:linearization-caveats (ii); Lean:
 `OpenHypotheses.hyp_time_invariant_cross_couplings`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_hyp_time_invariant_cross_couplings : LedgerEntry := {
  identifier := "hyp:time-invariant-cross-couplings"
  paperLabel := "rem:linearization-caveats (ii)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Within-era restriction. Discrete regime changes (Bretton Woods 1971; 2018 chip export controls; 2022 sanctions cascade) violate constant-A across the change. Under time-varying A(t), Lemma `lem:hss-exists` and Theorem `thm:threshold` lose closed-form solutions; qualitative-ordering theorem survives if A(t) stays in Hurwitz neighbourhood."
  decomposability := "1 atomic within-era stipulation."
  computability := "regime restriction."
  attackVector := "Keep as labelled hypothesis; restrict closed-form claims to single-era windows."
  attackHistory := []
  obstacleCitation := none
}

/-! ## Group D: 17 main paper theorems / propositions / corollaries -/

/-- paper source: thm:representation; Lean: `MainTheorem.thm_representation`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_representation : LedgerEntry := {
  identifier := "thm:representation"
  paperLabel := "thm:representation"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Chain A0+A1+A2+A4 ⟹ multiplicative-Cauchy ⟹ Aczel ⟹ Cobb-Douglas. Lean: multi-base-point A4 + strict-positivity + units calibration as paper-novel axioms; multiplicativity Lean-derived; Aczel discharged via `aczel_multiplicative_cauchy_power_form` Lean theorem; only paper-novel residue is the numeric γ-calibration `γ_i = paperCDExponents.{a,b,c}`."
  decomposability := "5 sub-steps (paper Steps 1-5): (1) decomposition via multi-base-point A4; (2) multiplicative Cauchy via A4 + strict-positivity; (3) power-form via Aczel; (4) γ-calibration; (5) units calibration."
  computability := "PUBLISHED via Aczel 1966 §2.1; calibration paper-empirical."
  attackVector := "Lean: A4 axioms + strict-positivity axiom → Lean-proved multiplicativity → Aczel theorem → paper-novel γ-calibration; final `ring`."
  attackHistory := ["-patch--removed-LAZY-paper_aggregator_cobb_douglas-axiom-replaced-with-A4-chain...", "-patch--hostile-R2-strengthened-A4-to-multi-base-point-with-cont-and-strictMono..."]
  obstacleCitation := none
}

/-- paper source: thm:nonsubstitutability; Lean: `MainTheorem.thm_nonsubstitutability`. -/
-- inputCat: Cat 1


def gap_thm_nonsubstitutability : LedgerEntry := {
  identifier := "thm:nonsubstitutability"
  paperLabel := "thm:nonsubstitutability"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "CLOSED IN LEAN via `AnnihilatesAsAxisVanishes` def + `Real.zero_rpow` (since γ.a, γ.b, γ.c > 0). Proof case-splits on axis k ∈ {PI, MU, NU}, substitutes axisValue = 0, applies Real.zero_rpow + ring. Paper-side: PUBLISHED. Direct consequence of Cobb-Douglas form with γ.a, γ.b, γ.c > 0 (A2 monotonicity)."
  decomposability := "1 atomic claim, 3 axis cases."
  computability := "PUBLISHED (limit calculation on Cobb-Douglas form)."
  attackVector := "CLOSED in Lean (`MainTheorem.thm_nonsubstitutability`); no `sorry`."
  attackHistory := ["R9-Lean-close--AnnihilatesAsAxisVanishes-def-plus-Real.zero_rpow"]
  obstacleCitation := none
}

/-- paper source: thm:tullock-microfoundation; Lean:
 `MainTheorem.thm_tullock_microfoundation`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_tullock_microfoundation : LedgerEntry := {
  identifier := "thm:tullock-microfoundation"
  paperLabel := "thm:tullock-microfoundation"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PAPER REWRITTEN: theorem statement now EXACT form Influence_i = K · ∏ x_{i,k}^{r_k} · ∏ (1 - s_{i,k}) with new eq:corrected-elasticity ∂log Influence/∂log x_{i,k} = r_k · (1-s_{i,k}); small-share asymptotic Cobb-Douglas recovered as the s_{i,k} → 0 special case (Remark rem:small-share-recovers). Lean: discharge to `paper_csf_small_share_limit_construction` (ClassicalResults.lean §8 — paper-novel construction; classical Tullock / Skaperdas / Konrad supply only single-contest CSF). Companion typed bridges in Types.lean §16 encode the corrected elasticity (gap_eq_corrected_elasticity)."
  decomposability := "3 sub-steps: (1) classical Tullock CSF; (2) exact three-contest factorisation; (3) corrected elasticity formula r·(1-s)."
  computability := "PUBLISHED."
  attackVector := "Lean: discharge to `paper_csf_small_share_limit_construction`; corrected elasticity in companion typed bridges; no `sorry`."
  attackHistory := ["-patch--hostile-R4-renamed-tullock_csf_small_share_limit-to-paper_csf_small...", "R6-rewrite--paper-rewrite-thm-tullock-microfoundation-with-finite-share-exact..."]
  obstacleCitation := none
}

/-- paper source: lem:budget-feedback; Lean: `MainTheorem.lem_budget_feedback`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_lem_budget_feedback : LedgerEntry := {
  identifier := "lem:budget-feedback"
  paperLabel := "lem:budget-feedback"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "PUBLISHED. Direct Lagrangian derivation of constant-share identity s_ℓ^* = r_ℓ / R from ∂L/∂s = 0."
  decomposability := "2 sub-steps: (i) constant-share identity; (ii) cross-coupling formula α_km = L_k · ∂W/∂x_m."
  computability := "PUBLISHED (Cobb-Douglas demand standard)."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: thm:dynamics-microfoundation; Lean:
 `MainTheorem.thm_dynamics_microfoundation`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_thm_dynamics_microfoundation : LedgerEntry := {
  identifier := "thm:dynamics-microfoundation"
  paperLabel := "thm:dynamics-microfoundation"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "PUBLISHED (microfoundation) + caveat that calibrated A matrix is fit phenomenologically (rank-1 form `α_km = L_k · ∂W/∂x_m` of paper microfoundation does not exactly match calibrated entries within rows; documented in Remark linearization-caveats clause iv). First-order Taylor expansion of capability-evolution principle around hegemonic SS, using Lemma `lem:budget-feedback` constant-share identity, yields linear ODE."
  decomposability := "3 sub-steps: (1) Cobb-Douglas best-response identity (`lem_budget_feedback`); (2) Taylor linearisation; (3) absorption of constants into baseline forcings."
  computability := "PUBLISHED (linearisation standard)."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := ["R5-patch--added-rem-linearization-caveats-clause-iv-acknowledging-rank-1-vs..."]
  obstacleCitation := none
}

/-- paper source: lem:hss-exists; Lean: `MainTheorem.lem_hss_exists`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_lem_hss_exists : LedgerEntry := {
  identifier := "lem:hss-exists"
  paperLabel := "lem:hss-exists"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "PUBLISHED. Closed-form (PI*, NU*, MU*) from inversion of the (PI, NU) 2×2 block + substitution into MU equation, under D = δ_PI δ_NU - α_PI_NU α_NU_PI > 0. Per-case D > 0 verification at headline α=0.010 in companion gap_rem_hss_D_positivity (script `hss_d_check.py`); all 12 cases (11 historical + Saudi-static) interior except Russia 2014-2024 borderline."
  decomposability := "2 sub-steps: (1) (PI, NU) 2×2 inversion; (2) MU substitution."
  computability := "PUBLISHED (linear algebra)."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge; D > 0 condition verified per-case via script."
  attackHistory := ["R6-add--companion-script-hss_d_check-verifies-D-positive-per-case-at-headline..."]
  obstacleCitation := none
}

/-- paper source: thm:threshold; Lean: `MainTheorem.thm_threshold`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_threshold : LedgerEntry := {
  identifier := "thm:threshold"
  paperLabel := "thm:threshold"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. The paper theorem bundles TWO INDEPENDENT conclusions: (1) STATIC inequality `Influence(t) < Influence^*/θ̄` at the crossing instant — derived from Cobb-Douglas algebra under side condition β ≤ 1; (2) DYNAMIC persistence-time formula `T_k^* = (1/μ_min)·log(...)` — derived from Hurwitz exp-decay. R45 §13 decomposition: STATIC half now `gapClosed`-via-OPEN-input via 3 atomic Cat 3 stipulations (focal-factor + nonfocal-factor + composition); DYNAMIC half remains carve-out (no `PersistenceTimeFormula` typed predicate). Status `gapPartial` honestly reflects the dynamic-half carve-out, not a Lean closure failure."
  decomposability := "2 INDEPENDENT paper conclusions. STATIC half decomposed (R45) into 3 atoms: (A) `paper_thm_threshold_focal_factor_bound` (focal-axis Cobb-Douglas factor ≤ θ̄⁻¹ under MinimumAxisCondition); (B) `paper_thm_threshold_nonfocal_factor_bound` (non-focal axes' joint factor ≤ 1 under NonCompensatingNonCrossing); (C) `paper_thm_threshold_factors_combine` (composition rule applied via Cobb-Douglas product). DYNAMIC persistence-time half remains carved out."
  computability := "PUBLISHED (both conclusions)."
  attackVector := "STATIC half: 3-atom Lean derivation composes (A)+(B)+(C) (R45 §13 decomposition replacing prior monolithic `paper_thm_threshold_static_inequality_holds`); DYNAMIC half: paper-acknowledged carve-out (would need `PersistenceTimeFormula` typed predicate)."
  attackHistory := ["tightened side condition β ≤ 1", "aligned statement with proof conclusion", "scope clarification: static + dynamic are independent conclusions", "R45 §13 decomposition: monolithic axiom → 3 atomic stipulations + derived theorem"]
  obstacleCitation := some "Dynamic persistence-time `T_k^*` formula remains carve-out: requires `PersistenceTimeFormula` typed predicate + Hurwitz-to-formula axiom. Queued for follow-on round."
}

/-- paper source: thm:meta-collapse; Lean: `MainTheorem.thm_meta_collapse`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_meta_collapse : LedgerEntry := {
  identifier := "thm:meta-collapse"
  paperLabel := "thm:meta-collapse"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Slowest-decay axis crosses first under THREE jointly required antecedents (paper-faithful): (1) σ matches ascending decay-rate ordering, (2) strict small-coupling-product condition `α_{σ(1)σ(2)} α_{σ(2)σ(1)} < (δ_{σ(2)} - δ_{σ(1)})^2`, (3) secondary path-dominance `α_{σ(2)σ(1)} α_{σ(3)σ(2)} ≥ α_{σ(1)σ(2)} α_{σ(3)σ(1)}`. Asymmetric-coupling AEB cases (Mongol calibration is at the strict small-coupling boundary) are covered separately by `thm:collapse-aeb` two-channel principle, NOT by this meta-principle."
  decomposability := "3 sub-claims: (1) slowest-eigenvalue identification; (2) eigenvector-dominance under regularity; (3) σ-permutation collapse-ordering transfer from regime-(i)/(ii)."
  computability := "PUBLISHED (linear-algebra perturbation)."
  attackVector := "CLOSED in Lean via discharge to `paper_slowest_first_meta_principle` (paper-novel meta-principle axiom; threads all three required antecedents)."
  attackHistory := ["R3-patch--added-symmetric-coupling-regularity-caveat-to-eigenvector-dominance...", "-patch--fixed-SCOPE-OVERCLAIM-restored-SmallCouplingProductCondition-and..."]
  obstacleCitation := none
}

/-- paper source: thm:collapse-sequence; Lean: `MainTheorem.thm_collapse_sequence`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_collapse_sequence : LedgerEntry := {
  identifier := "thm:collapse-sequence"
  paperLabel := "thm:collapse-sequence"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Regime-(i) industrial-era ordering δ_PI < δ_NU < δ_MU + arithmetic path-dominance + abstract `SmallCouplingProductCondition` + `SecondaryPathDominance` ⟹ PI → NU → MU. AEB is outside this theorem's parameter ordering scope (AEB satisfies neither the parameter ordering nor strict path-dominance and is covered separately by `thm:collapse-aeb`)."
  decomposability := "3 sub-steps: (1) slow-eigenvalue identification; (2) cross-coupling chain analysis; (3) threshold-spacing arithmetic for symmetric-coupling case."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via discharge to `paper_slowest_first_meta_principle` with all three required antecedents threaded through."
  attackHistory := ["R3-patch--removed-false-AEB-strict-path-dominance-claim", "-patch--added-explicit-SmallCouplingProductCondition-and-SecondaryPathDominance..."]
  obstacleCitation := none
}

/-- paper source: thm:collapse-sequence-info; Lean:
 `MainTheorem.thm_collapse_sequence_info`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_collapse_sequence_info : LedgerEntry := {
  identifier := "thm:collapse-sequence-info"
  paperLabel := "thm:collapse-sequence-info"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Regime-(ii) information-era ordering δ_NU < δ_PI < δ_MU + arithmetic path-dominance + abstract `SmallCouplingProductCondition` + `SecondaryPathDominance` ⟹ NU → PI → MU. Bona-fide special case of `thm:meta-collapse` small-coupling regime."
  decomposability := "3 sub-steps mirroring `thm:collapse-sequence`."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via discharge to `paper_slowest_first_meta_principle` with all three required antecedents threaded through."
  attackHistory := ["-patch--added-explicit-SmallCouplingProductCondition-and-SecondaryPathDominance..."]
  obstacleCitation := none
}

/-- paper source: thm:collapse-aeb; Lean: `MainTheorem.thm_collapse_aeb`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_collapse_aeb : LedgerEntry := {
  identifier := "thm:collapse-aeb"
  paperLabel := "thm:collapse-aeb"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Displayed J^AEB is block-triangular; literally upper-triangular form obtained after similarity transform (PI, NU, MU) → (PI, MU, NU). Two-channel sufficient condition: slowest eigenvalue -δ_NU + shock-loading asymmetry ∂W/∂x_NU ≫ ∂W/∂x_PI ≈ 0 ⟹ NU → PI → MU. Mongol historical-fit calibration sits at the strict-small-coupling boundary; covered by this AEB-specific two-channel argument, NOT by `thm:meta-collapse`. Lean derivation: composition of THREE paper-novel typed bridges — Channel-(i) `paper_aeb_yields_slowest_eigenvalue_NU`, Channel-(ii) `paper_aeb_yields_shock_loading_NU`, joining principle `paper_two_channel_collapse_principle` — making the final `thm_collapse_aeb` Lean-derived (not a single-axiom shortcut)."
  decomposability := "2 channels (paper-novel typed bridges): slowest-eigenvalue (Routh-Hurwitz / upper-triangular spectral structure) + shock-loading asymmetry (AEB definitional consequence). Joined by paper-novel two-channel principle."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean as a Lean-proved composition: `paper_aeb_yields_slowest_eigenvalue_NU ∘ paper_aeb_yields_shock_loading_NU ∘ paper_two_channel_collapse_principle`."
  attackHistory := ["R5-patch--clarified-block-triangular-vs-upper-triangular-permutation-and-Bauer...", "-patch--replaced-LAZY-reuse-of-meta-principle-with-paper-novel-paper_aeb_two...", "-patch--hostile-R2-decomposed-paper_aeb_two_channel_principle-into-3-paper..."]
  obstacleCitation := none
}

/-- paper source: cor:two-regimes; Lean: `MainTheorem.cor_two_regimes`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_cor_two_regimes : LedgerEntry := {
  identifier := "cor:two-regimes"
  paperLabel := "cor:two-regimes"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Regime-(ii) is bona-fide special case of `thm:meta-collapse`; AEB regime-(iii) covered by `thm:collapse-aeb` separately. σ-permutation classification: (NU, MU, PI) has δ_NU smallest (with δ_MU < δ_PI), distinct from (MU, *, *) permutations with δ_MU smallest."
  decomposability := "2 atomic claims (regime-(ii) ⊆ meta-theorem; regime-(iii) ⊆ AEB-theorem)."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := ["R4-patch--AEB-meta-theorem-coverage-clarification", "R5-patch--sigma-permutation-classification-fix-NU-MU-PI-has-deltaNU-smallest"]
  obstacleCitation := none
}

/-- paper source: thm:exponent-derivation; Lean:
 `MainTheorem.thm_exponent_derivation`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_exponent_derivation : LedgerEntry := {
  identifier := "thm:exponent-derivation"
  paperLabel := "thm:exponent-derivation"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "STRUCTURAL POSIT. The boxed formula `γ_k ∝ w_k = δ_k⁻¹ |∂W/∂x_k| r_k` is a structural posit linking Cobb-Douglas exponents to primitives outside the calibration set, NOT derived from MLE FOC (linear-in-γ loss on simplex would yield corner solution). Empirical content = whether MLE-fitted (a, b, c) matches posited (a, b, c) ∝ w. COMPLETED: full decomposition of `paper_thm_exponent_derivation_holds` into 3 paper-bound sub-axioms matching paper's explicit `\\emph{Step 1:}` / `\\emph{Step 2:}` / `\\emph{Step 3:}` proof structure. Step 1 = `paper_thm_exponent_step1_slow_envelope_amplitude` (under `SmallCouplingRegime` antecedent — - CRITICAL: this hypothesis was previously HIDDEN by the monolithic axiom; decomposition surfaces it). Step 2 = `paper_thm_exponent_step2_discrimination_loading` (chains Step-1 conclusion + disjunction `IsLeakageAxisIndependent`). Step 3 = `paper_thm_exponent_step3_structural_posit` (the actual structural posit `γ_k ∝ w_k`). The composite `paper_thm_exponent_derivation_holds` is now a Lean-PROVED theorem (not an axiom) composing the 3 sub-axioms. Both `paper_thm_exponent_derivation_holds` and `thm_exponent_derivation` signatures EXPOSE the previously hidden `SmallCouplingRegime` antecedent — visible signature change is the unmasking consequence."
  decomposability := "3 paper-bound sub-axioms via explicit Step 1+2+3 chain. Step 1 (slow-envelope amplitude `ρ_k = δ_k⁻¹ |L_k ∂W/∂x_k|` under `SmallCouplingRegime`) PUBLISHED. Step 2 (boxed `w_k` formula under `IsLeakageAxisIndependent` disjunction) PUBLISHED. Step 3 (structural posit `γ_k ∝ w_k`) NOT derivable from MLE; structural closure. Each sub-axiom is single-step typed bridge per `feedback_lean_axiom_decomposition.md`."
  computability := "Step 1+2 PUBLISHED arithmetic (Neumann series / Tullock elasticity composition). Step 3 = STRUCTURAL POSIT (paper-explicit framing — not derivable, hence axiom)."
  attackVector := "FULLY DECOMPOSED in + theorem-derived in Lean from 3 step axioms + disjunction. Each step axiom is a single-step typed bridge. Hidden `SmallCouplingRegime` hypothesis surfaced + propagated to `thm_exponent_derivation` signature."
  attackHistory := ["R3-patch--reframed-Step-3-from-MLE-FOC-to-structural-posit-after-Agent-I...", "R6-add--KL-projection-MLE-script-cross-validated-tension-half-quantifies-posit...", "-B-audit--classified-as-DECOMPOSE-3-paper-Steps-currently-packaged-as-single...", "-B.4-patch---audit-on--MAJOR-disclosure-fix-axiom-docstring-now-explicitly...", "-patch--disjunction-elevated-to-type-level-via-IsLeakageAxisIndependent...", "-patch---CRITICAL-finding-paper-Step-1-line-667-requires-SmallCouplingRegime..."]
  obstacleCitation := some "(queued): give the 5 opaque component predicates introduced by + P-2 (`SmallCouplingRegime`, `HasSlowEnvelopeAmplitudeFormula`, `HasSurvivalWeightBoxedFormula`, `IsUniformDiscriminationLoading`, `IsSpecialRank1FungibilityForm`) substantive bodies. Each requires typed accessors on `EconomicSystem` (`A_S` + `Jacobian3` norm; `δ_k`, `L_k`, `∂W/∂x_k`, `r_k`, `φ_{k,ℓ}`). Per the 5 separate Group-M+N Ledger entries (`gap_predicate_*`)."
}

/-- paper source: thm:three-axes; Lean: `MainTheorem.thm_three_axes`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_thm_three_axes : LedgerEntry := {
  identifier := "thm:three-axes"
  paperLabel := "thm:three-axes"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED IN LEAN via combining classical-lit axioms (action_algebra_irreducible_count_ge_three [Topkis 1998 lower bound]; tikhonov_fenichel_slow_manifold [Tikhonov-Fenichel singular perturbation]) + paper-novel axioms (action_algebra_irreducible_count_le_three [paper upper bound]; paper_info_geometric_eq_spectral_cluster_step2to3_link [paper-novel Step 2-3 link]). Combination: count = 3 via Topkis ge + paper le; SlowManifoldDimension = SpectralClusterCount = 3 via Tikhonov-Fenichel + paper Step 2-3 link. Conditional on SpectralSeparation + InformationGeometricIndependence S 3 (era-conditional)."
  decomposability := "4 sub-steps: action-algebra dimension; information-geometric matching; spectral-cluster upper bound; bijection."
  computability := "PUBLISHED + ERA-CONDITIONAL."
  attackVector := "CLOSED in Lean (`MainTheorem.thm_three_axes`); no `sorry`. Closure via 2 ClassicalResults axioms (Topkis ge + Tikhonov-Fenichel) + 2 paper-novel axioms (paper upper bound + paper Step 2-3 link)."
  attackHistory := ["R1-patch--strengthened-theorem-statement-with-logical-structure-note...", "R9-Lean-close--2-new-paper-axioms-plus-combine-Topkis-Tikhonov", "-patch--hostile-R4-renamed-tikhonov_slow_manifold-to-tikhonov_fenichel_slow..."]
  obstacleCitation := none
}

/-- paper source: prop:nonlinear-stability; Lean:
 `MainTheorem.prop_nonlinear_stability`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_prop_nonlinear_stability : LedgerEntry := {
  identifier := "prop:nonlinear-stability"
  paperLabel := "prop:nonlinear-stability"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED IN LEAN via direct discharge to `lyapunov_indirect_local_exp_stability` (ClassicalResults.lean §2 — Hurwitz ⟹ local exp. stability is Lyapunov's indirect method, Khalil 2002 Thm 4.7; Hartman-Grobman supplies only topological-conjugacy precursor). Paper-side: PUBLISHED via Lyapunov indirect + Routh-Hurwitz."
  decomposability := "2 atomic claims: Routh-Hurwitz (eigenvalue real-parts < 0); Lyapunov indirect method (Hurwitz ⟹ local exponential stability)."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean (`MainTheorem.prop_nonlinear_stability := lyapunov_indirect_local_exp_stability`); no `sorry`."
  attackHistory := ["-patch--hostile-R4-renamed-hartman_grobman_local_stability-to-lyapunov_indirect..."]
  obstacleCitation := none
}

/-- paper source: prop:clustering; Lean: `MainTheorem.prop_clustering`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_prop_clustering : LedgerEntry := {
  identifier := "prop:clustering"
  paperLabel := "prop:clustering"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED IN LEAN via direct discharge to `cox_lewis_mixed_poisson_overdispersion` (ClassicalResults.lean §6), conditional on `hyp_slow_driver_regime S = SlowDriverApplies S ∧ TensionNonDegenerate S`. Paper-side: PUBLISHED (Cox-Lewis test). Empirical CV² = 0.45 < 1 in post-1640 record is OPPOSITE direction from prediction; paper acknowledges this explicitly."
  decomposability := "1 atomic claim under `hyp_slow_driver_regime`."
  computability := "PUBLISHED (Cox-Lewis test)."
  attackVector := "CLOSED in Lean (`MainTheorem.prop_clustering := exact cox_lewis_mixed_poisson_overdispersion S hsd htn`); no `sorry`."
  attackHistory := ["R1-patch--acknowledged-CV-squared-0.45-opposite-direction-not-merely...", "R6-demote--paper-text-explicit-framework-prediction-gap-not-sample-size-caveat..."]
  obstacleCitation := none
}

/-- paper source: prop:nu-removal; Lean: `MainTheorem.prop_nu_removal`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_nu_removal : LedgerEntry := {
  identifier := "prop:nu-removal"
  paperLabel := "prop:nu-removal"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED (statement: cardinal up to a constant of proportionality determined by the measure; proof gives ordinal preservation always, cardinal-up-to-constant in isotropic case). Dependency: bi-Lipschitz equivalence on bounded-rank linear maps + measure invariance (NOT Khalil 2002 Thm 4.4 norm-equivalence, which applies to operator norms on ℝⁿ, a different setting from `NU* = volume-reduction` vs `NU = operator-norm`)."
  decomposability := "2 sub-claims: ordinal preservation (always); cardinal-up-to-constant (isotropic case)."
  computability := "PUBLISHED (ordinal always; cardinal-up-to-constant in isotropic case)."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-! ## Group E: ex-ante-protocol corollaries -/

/-- paper source: prop:ex-ante-classification; Lean:
 `MainTheorem.prop_ex_ante_classification`. -/
-- inputCat: Cat 1


def gap_prop_ex_ante_classification : LedgerEntry := {
  identifier := "prop:ex-ante-classification"
  paperLabel := "prop:ex-ante-classification"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "CLOSED IN LEAN via explicit count-witness construction. The 11-case classification (9 strict + 1 joint-shock + 1 violation) is encoded as ExAnteClassificationCount struct; the existential is discharged by providing the count tuple ⟨9, 1, 1, 11, by omega⟩ and verifying IsExAnteClassification11Case (4 rfls). Content-limit: the proof verifies the count tuple is well-formed (numerics 9+1+1 ≤ 11 and matches paper claim), NOT that it corresponds to specific historical cases (per-case witness function out of scope). Paper-side: PUBLISHED case-by-case (Spain, Netherlands, Britain, Qing, Ottoman, Roman = regime-(i) SP; Tang = joint-shock; Mughal = violation; Mongol, USSR, Russia 2014-24 = regime-(iii) AEB)."
  decomposability := "11 case classifications encoded as count tuple; per-case witness function not in scope."
  computability := "PUBLISHED (case-by-case)."
  attackVector := "CLOSED in Lean via explicit witness ⟨⟨9, 1, 1, 11, _⟩, rfl, rfl, rfl, rfl⟩; no `sorry`. Trivial-existential closure; not tied to specific historical cases."
  attackHistory := ["R7-patch--stale-8-of-11-corrected-to-9-of-11", "R9-patch--USSR-1985-NU-value-reconciled-across-sec-5.4-and-sec-6.4", "R9-Lean-close--trivial-existential-witness-on-IsExAnteClassification11Case-def"]
  obstacleCitation := none
}

/-- paper source: cor:ex-ante-pvalue; Lean: `MainTheorem.cor_ex_ante_pvalue`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_cor_ex_ante_pvalue : LedgerEntry := {
  identifier := "cor:ex-ante-pvalue"
  paperLabel := "cor:ex-ante-pvalue"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED IN LEAN via discharge to paper-bound axiom `paper_binomial_tail_11_9_at_one_sixth_le_four_e_minus_six` (uninformed null `p_match=1/6`, p≈4×10⁻⁶). Paper now reports THREE reference distributions: uninformed (p≈4e-6 rejected), mild informed (p≈1.4e-3 rejected), STRONG informed (p≈0.234 NOT REJECTED). The headline 4e-6 is rejection of the UNINFORMED null only; permutation-test bootstrap + OSF pre-registration recommended for principled within-framework inference. Companion gap_rem_permutation_test (script `permutation_p_value.py`)."
  decomposability := "3 reference distributions: uninformed / mild / strong informed."
  computability := "PUBLISHED ARITHMETIC + bootstrap-verified."
  attackVector := "Lean: discharge to paper-bound axiom for uninformed-null bound; strong-informed-null bound in companion paperPermutationTest_strong_informed_null_p_value."
  attackHistory := ["R6-add--paper-now-reports-three-null-reference-distributions-strong-informed..."]
  obstacleCitation := none
}

/-- paper source: cor:selection-bias-corrected-null; Lean:
 `MainTheorem.cor_selection_bias_corrected_null`. -/
-- inputCat: Cat 1


def gap_cor_selection_bias_corrected_null : LedgerEntry := {
  identifier := "cor:selection-bias-corrected-null"
  paperLabel := "cor:selection-bias-corrected-null"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "CLOSED IN LEAN via explicit count-witness on 15-case extension (9 strict + 3 joint-shock + 1 violation + 2 ambiguous). Count tuple ⟨9, 3, 1, 15, by omega⟩ + IsExAnteClassification15Case (4 rfls). Content-limit: trivial-existential; not tied to specific historical cases or binomial-tail p-values. Paper-side: PUBLISHED ARITHMETIC."
  decomposability := "15-case count classification encoded as count tuple."
  computability := "PUBLISHED ARITHMETIC."
  attackVector := "CLOSED in Lean via explicit witness ⟨⟨9, 3, 1, 15, _⟩, rfl, rfl, rfl, rfl⟩; no `sorry`."
  attackHistory := ["R9-Lean-close--trivial-existential-witness-on-IsExAnteClassification15Case-def"]
  obstacleCitation := none
}

/-! ## Group F: hegemonic-margin / case-specific corollaries -/

/-- paper source: prop:theta-bar-derived; Lean:
 `MainTheorem.prop_theta_bar_derived`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_theta_bar_derived : LedgerEntry := {
  identifier := "prop:theta-bar-derived"
  paperLabel := "prop:theta-bar-derived"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Closed-form θ̄(χ, R) = ((1 - χ) / χ)^{1/R} from bargaining-game deterrence inequality."
  decomposability := "1 atomic algebraic claim."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:theta-bar-case; Lean:
 `MainTheorem.prop_theta_bar_case`. -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_prop_theta_bar_case : LedgerEntry := {
  identifier := "prop:theta-bar-case"
  paperLabel := "prop:theta-bar-case"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. Deterrence-inequality derivation of case-specific multilateral margin θ̄(t) = θ̄_req · K(t) from contemporaneous coalition aggregate (see also `gap_thm_threshold_case_specific` for the threshold-crossing application of this formula). Numerical: Spain 1700 6.00 = 2.33·2.57; Netherlands 1750 5.16 = 2.33·2.21; Britain 1956 5.07 = 2.33·2.17; USSR 1985 4.47 = 2.33·1.92; Russia 2024 5.62 = 2.33·2.41; US 2025 5.30 = 2.33·2.27."
  decomposability := "1 algebraic claim (formula derivation) + 6 case calibrations."
  computability := "PUBLISHED ARITHMETIC."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: cor:composite-margin; Lean: `MainTheorem.cor_composite_margin`. -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_cor_composite_margin : LedgerEntry := {
  identifier := "cor:composite-margin"
  paperLabel := "cor:composite-margin"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. Cardinal-margin-loss biconditional: focal hegemon loses cardinal hegemonic margin at time t iff `Influence_h(t) < θ̄_req · Influence_C(t)`, where `Influence_C(t)` is the coalition-aggregate functional (paper `def:coalition-aggregate`,)."
  decomposability := "1 atomic biconditional (iff) test."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: cor:annihilation-from-tullock; Lean:
 `MainTheorem.cor_annihilation_from_tullock`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_cor_annihilation_from_tullock : LedgerEntry := {
  identifier := "cor:annihilation-from-tullock"
  paperLabel := "cor:annihilation-from-tullock"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED IN LEAN via discharge to new paper-bound axiom `tullock_csf_vanishes_at_zero` (ClassicalResults.lean §10) encoding Tullock 1980 CSF formula `p_i = x_i^r / Σ x_j^r` evaluated at `x_i = 0` with `r > 0`. The downstream Influence consequence follows separately from `thm_nonsubstitutability`. Paper-side: PUBLISHED."
  decomposability := "1 atomic limit claim (Tullock CSF at zero input)."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean (`MainTheorem.cor_annihilation_from_tullock := tullock_csf_vanishes_at_zero`); no `sorry`."
  attackHistory := ["R9-Lean-close--discharge-to-paper-axiom-tullock_csf_vanishes_at_zero"]
  obstacleCitation := none
}

/-- paper source: cor:finite-share-tullock; Lean:
 `MainTheorem.cor_finite_share_tullock`. -/
-- inputCat: Cat 1


def gap_cor_finite_share_tullock : LedgerEntry := {
  identifier := "cor:finite-share-tullock"
  paperLabel := "cor:finite-share-tullock"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "axiom-reduction: `FiniteShareDeviationBound` predicate body is now substantively defined in Types.lean (was opaque `axiom : ℝ → ℝ → Prop`); the cube bound `1 - (1 - s_max)^3` is now Lean-PROVED (theorem `finite_share_deviation_cube_bound`) rather than axiomatized — proof via algebraic manipulation of (1 - s_axis) ∈ [1 - s_max, 1] for each axis + product monotonicity + |1 - prod| = 1 - prod. Backward-compat shim `paper_finite_share_deviation_bound_pending_predicate_body` retained as a derived theorem (no longer an axiom). REMAINING gap: the IDENTITY `Influence^FiniteShare = Influence^CD · ∏(1 - s_k)` is paper-substantive (cor:finite-share-tullock proof tex line ~513) and not yet typed — queued for next REWORK step (would require adding `InfluenceFiniteShare`/`InfluenceCD` typed predicates). Paper-side: PUBLISHED. The s_max ≈ 0.74 ceiling corresponds to ~70% reserve-currency leader against 1 secondary ≈ 20% + 2 minor ≈ 5%."
  decomposability := "2 paper sub-claims: (1) IDENTITY `Influence^FiniteShare = Influence^CD · ∏(1 - s_k)` — paper-substantive (queued); (2) BOUND `|1 - ∏(1 - s_k)| ≤ 1 - (1 - s_max)^3` — Lean-PROVED in -B.1."
  computability := "PUBLISHED arithmetic for both. Bound now Lean-derivable; identity remains paper-bound but typed-predicate scaffolding is the next REWORK step."
  attackVector := "Bound: Lean-PROVED via `finite_share_deviation_cube_bound`. Identity: queued for follow-on REWORK once `InfluenceFiniteShare` / `InfluenceCD` typed predicates are designed."
  attackHistory := ["R1-patch--tightened-multi-rival-Tullock-construction-for-s-max-0.74", "R8-Lean-close--explicit-witness-1-minus-(1-s_max)^3", "-patch--renamed-paper_finite_share_deviation_bound-to-_pending_predicate_body...", "-B.1-patch---audit-on--B-classified-as-REWORK-FiniteShareDeviationBound-given..."]
  obstacleCitation := some "Identity `Influence^FiniteShare = Influence^CD · ∏(1 - s_k)` requires typed `InfluenceFiniteShare` and `InfluenceCD` predicates in Types.lean before it can be encoded as a paper-bound axiom (queued for follow-on REWORK)."
}

/-- paper source: cor:exponent-sensitivity; Lean:
 `MainTheorem.cor_exponent_sensitivity`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_cor_exponent_sensitivity : LedgerEntry := {
  identifier := "cor:exponent-sensitivity"
  paperLabel := "cor:exponent-sensitivity"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Cardinal residuals between posited and empirical (a, b, c) mechanistically located in state-dependent δ_NU(NU) network hysteresis (on c) and era-varying rent-extraction loading (on a and b). COMPLETED: full decomposition of `paper_cor_exponent_sensitivity_holds` into 3 per-residual paper-bound sub-axioms matching paper's explicit 3-itemized residual structure (paper lines 693/694/695): `paper_cor_exponent_sensitivity_c_residual_from_delta_NU` (c ← δ_NU hysteresis), `_b_residual_from_rent_load_MU` (b ← era-varying |∂W/∂x_MU|), `_a_residual_from_rent_load_PI` (a ← era-varying |∂W/∂x_PI|). The opaque `ResidualsLocatedInMechanisms` axiom predicate is replaced by a canonical CONJUNCTION `def := LocatedInDeltaNUHysteresis ∧ LocatedInEraVaryingRentLoadMU ∧ LocatedInEraVaryingRentLoadPI` (Types.lean) — type-level visible (structurally analogous to 's disjunction pattern, with ∧ instead of ∨). The composite `paper_cor_exponent_sensitivity_holds` is now a Lean-PROVED theorem (not an axiom): `⟨c, b, a⟩`. Signature UNCHANGED (zero caller breakage)."
  decomposability := ": 3 paper-bound sub-axioms, one per paper-itemized residual location, composed conjunctively. (c) state-dep δ_NU hysteresis — closing ≈60% of c gap by δ_NU 0.05→0.014. (b) era-varying ∂W/∂x_MU rent loading — headline 0.10 stressed-hegemon estimate. (a) era-varying ∂W/∂x_PI rent loading — headline 0.30 post-1815 industrial anchor. Each sub-axiom is a single-step typed bridge per `feedback_lean_axiom_decomposition.md`; canonical predicate body is the 3-conjunction."
  computability := "PUBLISHED (each residual location is a paper-evidenced empirical claim with distinct citation per axis)."
  attackVector := "FULLY DECOMPOSED in + theorem-derived in Lean from 3 sub-axioms. ResidualsLocatedInMechanisms now non-opaque (conjunction def). Signature preserved."
  attackHistory := ["-B-audit--classified-as-DECOMPOSE-3-paper-itemised-residuals-currently-packaged...", "-patch---audit-confirmed-conjunction-not-disjunction-3-unconditional-sub-axioms..."]
  obstacleCitation := some "batch (queued): give the 3 new opaque `LocatedIn*` component predicates substantive bodies tying each residual location to a typed accessor threshold (`δ_NU : EconomicSystem → ℝ` for c-residual; `∂W/∂x_MU`, `∂W/∂x_PI : EconomicSystem → ℝ` for b/a-residuals). Per the 3 separate Group-O Ledger entries (`gap_predicate_residual_*`)."
}

/-- paper source: cor:cross-scale-nonsub; Lean:
 `MainTheorem.cor_cross_scale_nonsub`. -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_cor_cross_scale_nonsub : LedgerEntry := {
  identifier := "cor:cross-scale-nonsub"
  paperLabel := "cor:cross-scale-nonsub"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. 6 single-axis-collapse cases across state and firm scales (USSR 1985, Saudi 1970, Russia 2024 + BlackBerry, Nokia, Kodak)."
  decomposability := "6 case verifications."
  computability := "PUBLISHED ARITHMETIC."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-! ## Group G: 17 additional paper propositions / theorems for coverage -/

/-- paper source: thm:decomposition (separable form precursor). -/
-- inputCat: Cat 1


def gap_thm_decomposition : LedgerEntry := {
  identifier := "thm:decomposition"
  paperLabel := "thm:decomposition"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. Multiplicatively-separable form F = K · h_1(PI) · h_2(MU) · h_3(NU) under paper Axioms A1–A4. Precursor to thm:representation. Lean: corollary of `thm_representation` with witnesses `h_i := axis^{γ_i}`, closed by `ring`."
  decomposability := "1 atomic claim (existence of K + h_1, h_2, h_3)."
  computability := "PUBLISHED."
  attackVector := "Lean-proved corollary of `thm_representation`."
  attackHistory := ["-patch--removed-LAZY-paper_aggregator_separable_form-axiom-replaced-with-thm..."]
  obstacleCitation := none
}

/-- paper source: prop:axis-independence (Sard-theoretic restatement). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_axis_independence : LedgerEntry := {
  identifier := "prop:axis-independence"
  paperLabel := "prop:axis-independence"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PARTIAL (structurally decomposed; part-(b) predicate body added ). Paper proposition has two parts: (a) Sard-theoretic regular-value statement — `Φ = (PI, MU, NU)`'s regular-value set is open dense in ℝ_+³ (Sard 1942 + IFT), the strengthened headline claim, strictly stronger than (b); (b) 3 explicit pairwise witnesses (autarkic-vs-networked → NU varies; parliamentary-vs-command → MU varies; microstate-vs-continental → PI varies). : (i) ADDED part (a) to Lean — previously absent — as `axiom SardRegularValueSetOpenDense` + `paper_prop_axis_independence_sard_regular_value_pending_mathlib_sard` (blocker = Mathlib Sard theorem + Φ analytic infrastructure, NOT carrier); (ii) SPLIT part (b)'s per-axis universal into 3 explicit witness sub-axioms (`_witness_autarkic_vs_networked_`, `_witness_parliamentary_vs_command_`, `_witness_microstate_vs_continental_`, each `_pending_carrier_inhabitation`-suffixed since the natural bodies are concrete `EconomicSystem` pairs); (iii) `paper_prop_axis_independence_holds_pending_carrier_inhabitation` converted axiom→theorem (derives `∀ k, AdmitsDiscriminatingPairOnAxis k` by `cases k`); (iv) ADDED `def AxisIndependenceFull = Sard ∧ (∀ k,...)` + `paper_prop_axis_independence_full` theorem composing both parts. `AdmitsDiscriminatingPairOnAxis k` is now a substantive `def` — `∃ S₁ S₂ : EconomicSystem, axisValue S₁ k ≠ axisValue S₂ k ∧ ∀ k' ≠ k, axisValue S₁ k' = axisValue S₂ k'` (over the pre-existing `axisValue` per-axis capability projection; the DEF needs no `EconomicSystem` constructor — it merely quantifies over `EconomicSystem`; net axiom −1, no new opacity). `prop_axis_independence` signature unchanged (zero caller breakage). Status remains gapPartial: the part-(b) predicate now has a body, but the 3 part-(b) witness EXISTENCE claims remain carrier-pending sub-axioms (constructing concrete `EconomicSystem` witness pairs needs the `EconomicSystem` constructor), and the part-(a) Sard claim remains Mathlib-Sard-pending."
  decomposability := ": 4 paper-bound sub-axioms — 1 Sard (part a, `_pending_mathlib_sard`) + 3 per-pair witnesses (part b, `_pending_carrier_inhabitation` each); part (b) NOT derived from part (a) in the paper proof — both independently constitutive; `AxisIndependenceFull` def captures the conjunction. the part-(b) predicate `AdmitsDiscriminatingPairOnAxis` now has a substantive `def` body over `axisValue` (the 3 witnesses now assert a meaningful existential rather than an opaque blob)."
  computability := "PUBLISHED (part a: Sard 1942 + IFT; part b: 3 explicit constructions). Part-(b) predicate body computable-modulo-`axisValue` (= the pre-existing capability accessors); part-(b) witness existence still carrier-pending; part-(a) Sard still Mathlib-Sard-pending."
  attackVector := "STRUCTURALLY DECOMPOSED in + part-(b) theorem-derived in Lean (`cases k` over the 3 witnesses) + full proposition composed in `paper_prop_axis_independence_full` + part-(b) predicate body added. Remaining: 3 part-(b) witness EXISTENCE claims blocked on the `EconomicSystem` constructor; part-(a) Sard predicate blocked on Mathlib Sard (tracked in `gap_predicate_sard_regular_value_set_open_dense`)."
  attackHistory := ["-patch--renamed-paper_prop_axis_independence_holds-to-_pending_carrier...", "-B-audit--classified-as-DECOMPOSE-Sard-and-3-per-pair-witnesses-currently...", "-patch---audit-confirmed-paper-asserts-both-parts-part-b-not-derived-from-part...", "-patch---audit-AdmitsDiscriminatingPairOnAxis-given-substantive-def-body-exists..."]
  obstacleCitation := some "Two blockers (both at the EXISTENCE/proof level, not the predicate-body level): (1) `axiom EconomicSystem : Type` carrier — blocks PROVING the 3 part-(b) witness existence claims (need explicit `EconomicSystem` inhabitants for the discriminating pairs; the `EconomicSystem` structure refactor). (2) Mathlib's Sard theorem + `Φ` analytic infrastructure (manifold parametrization, `Jacobian3` body) — blocks the part-(a) `SardRegularValueSetOpenDense` substantive body; tracked in `gap_predicate_sard_regular_value_set_open_dense`."
}

/-- paper source: prop:relaxation (5 clauses (i)-(v)). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_relaxation : LedgerEntry := {
  identifier := "prop:relaxation"
  paperLabel := "prop:relaxation"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. 5 sub-clauses: (i) without A1: Hamel-basis pathology (paper-source-bound predicate); (ii) without A2: arbitrary-sign exponents (paper-source-bound predicate); (iii) without A3 alone (keeping A1+A2+A4): no empirical cost — A3 derivable from A1+A2+A4 via Cauchy multiplicative equation [CLOSED via `A3_redundant_from_A1_A2_A4`]; (iv) without A4: additive cross-terms admitted (paper-source-bound predicate); (v) without A5: no cost — A5 automatically satisfied by Cobb-Douglas [FULLY CLOSED via `A5_log_additivity_derivable` using Real.log_mul + Real.log_rpow]. Raw `sorry` placeholders are no longer present; residual clauses are explicit predicates/axioms."
  decomposability := "5 sub-clauses (one per axiom)."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean. (i) via paper-bound axiom paper_relaxation_A1_admits_hamel; (ii)/(iv) via Lean-proved theorems with explicit witnesses; (iii)/(v) via A3/A5 derivability theorems."
  attackHistory := ["R8-Lean-partial-close--clauses-iii-and-v-discharged-via-A3-A5-derivability"]
  obstacleCitation := none
}

/-- paper source: prop:two-anchors. -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_prop_two_anchors : LedgerEntry := {
  identifier := "prop:two-anchors"
  paperLabel := "prop:two-anchors"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. Cross-sectional pooled r_k^cs = (0.93, 1.27, 0.67) vs collapse-onset MLE r_k^co = (0.40, 0.21, 0.39) are different empirical objects related by regime-density transformation w_k^tr(s); identification gap acknowledged."
  decomposability := "2 atomic claims (two anchors distinct; relation via regime-density)."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:uw-subsumes (useful work η-modulated subsumption
 of GDP / value-added for PI). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_uw_subsumes : LedgerEntry := {
  identifier := "prop:uw-subsumes"
  paperLabel := "prop:uw-subsumes"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Within an economy at fixed exergy-conversion efficiency η, useful-work output and real GDP are linearly proportional W = η·GDP; across economies with different η, the two diverge (η empirically varies by factor ≈ 3, Ayres-Warr Ch. 7). Lean encoding uses the `IsEtaModulatedSubsumption` predicate (∃ η > 0, m_fundamental S = η S · m_derived S) — paper-faithful for the η-modulated proportionality including the cross-η divergence."
  decomposability := "2 atomic claims: η-modulated proportionality for GDP; same for value-added."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom `paper_uw_subsumes_gdp` typed as `IsEtaModulatedSubsumption usefulWork gdp`. Value-added conjunct was removed as OVERCLAIM (paper prop:uw-subsumes proposition body covers GDP only; rem:pi-protocol's value-added mention is a measurement-proxy chain, not an η-modulated subsumption proposition)."
  attackHistory := ["-patch--hostile-R4-replaced-IsCoarserMetric-rank-preservation-predicate-with..."]
  obstacleCitation := none
}

/-- paper source: prop:mu-reachability (MU control-theoretic). -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_prop_mu_reachability : LedgerEntry := {
  identifier := "prop:mu-reachability"
  paperLabel := "prop:mu-reachability"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. MU is control-theoretic reachability rate over factor allocations; operationalised via WWII-equivalent mobilization stratification and COVID-19 vaccine-and-lockdown response rate."
  decomposability := "1 atomic claim."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:taylor-F (second-order Taylor of W). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_taylor_F : LedgerEntry := {
  identifier := "prop:taylor-F"
  paperLabel := "prop:taylor-F"
  status := GapStatus.gapBlocked
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED on paper side: second-order Taylor expansion of F (RHS of eq:nonlinear-ODE) around x* yielding linear Jacobian J + quadratic Hessian H^(k) terms decomposing into Hess(W_i) contribution and ∂²d_k contribution. Lean side: no raw `sorry` remains; theorem `prop_taylor_F` is discharged by explicit Cat 3 working-assumption axiom `paper_prop_taylor_F_holds` (tracked separately as `gap_axiom_paper_prop_taylor_F`). The real obstacle is NOT Mathlib infrastructure — Mathlib has all needed pieces once the carrier is concrete. The PRIMARY blocker is the opaque `EconomicSystem` carrier: closure requires constructor-level Lean port of `EconomicSystem` to specialize F : ℝ³ → ℝ as a concrete function with derivatives, after which the Mathlib Hessian-decomposition pieces can compose."
  decomposability := "1 atomic algebraic claim (paper side); Lean discharge requires 2 sub-bridges in order: (b1) `EconomicSystem` constructor inhabitation specializing F : ℝ³ → ℝ; (b2) Hess(F) = Hess(W) + diag(∂²d) decomposition (composes existing Mathlib pieces once carrier is concrete)."
  computability := "PUBLISHED (Taylor's theorem). Mathlib infrastructure SUFFICIENT for multivariate Hessian decomposition once constructor is concrete; the gap is the constructor, NOT Mathlib."
  attackVector := "R46 update: raw `sorry` no longer present. The theorem is intentionally not counted as an unconditional closure: it depends on the explicit working-assumption axiom surfaced by R45, so `#print axioms` exposes the debt. Status remains `gapBlocked` at the paper-theorem level because the blocker is constructor-carrier engineering, not a missing named Mathlib theorem."
  attackHistory := ["-A--audit-A3-obstacle-citation-corrected-real-blocker-is-EconomicSystem...", "R45: raw sorry replaced by explicit working-assumption axiom `paper_prop_taylor_F_holds`", "R46: entry text updated to reflect sorry-free source and surfaced axiom dependency"]
  obstacleCitation := some "PRIMARY blocker is opaque `EconomicSystem` carrier preventing F : ℝ³ → ℝ specialization. SECONDARY (downstream): Mathlib's multivariate Taylor pieces (`iteratedFDeriv` + `FDeriv.Symmetric`) compose into the Hessian decomposition once F is concrete; no missing Mathlib named theorem. The `EconomicSystem` structure refactor that would unblock this is NOT a quick win — it cannot complete the canonical instances honestly (paper lacks numerical `φ_{k,ℓ}` / `L_k` / `ρ_k` / absolute-capability values; see the module-header scoping finding)."
}

/-- paper source: prop:long-cycle (autonomous Hopf absent). -/
-- inputCat: Cat 3
-- subType: phenomenologicalConjecture


def gap_prop_long_cycle : LedgerEntry := {
  identifier := "prop:long-cycle"
  paperLabel := "prop:long-cycle"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "Numerical observation. Paper acknowledges: 'a numerical observation, not a theoretical prediction within this theorem'. The 12×12 lag-extended Jacobian eigenvalue band is a calibrated-instance computational claim; resolution path is numerical-replication of the calibrated sensitivity sweep, NOT Lean derivation. Sub-type migrated to phenomenologicalConjecture per §3.4.6 (framework paper publishes substantive numerical-experimental claim awaiting external computational validation)."
  decomposability := "1 numerical observation claim awaiting computational replication at calibrated parameters."
  computability := "Numerical observation (computer sweep at canonical post-1815 industrial calibration). Paper acknowledges no closed-form derivation undertaken; falsifiability path = re-running the sensitivity sweep."
  attackVector := "Lean axiomatized as paper-bound numerical assertion `paper_prop_long_cycle_holds`; status gapOpen per §3.4.6 phenomenologicalConjecture spec (resolution external, not Lean-internal)."
  attackHistory := ["migrated cat3SubType workingAssumption → phenomenologicalConjecture; status gapClosed → gapOpen per §3.4.6 (paper publishes as numerical observation awaiting computational replication, not as a derivational target)"]
  obstacleCitation := none
}

/-- paper source: thm:tension-cycle (band-statement long cycle). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_tension_cycle : LedgerEntry := {
  identifier := "thm:tension-cycle"
  paperLabel := "thm:tension-cycle"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED (band statement). Influence process stationary distribution has low-frequency power in band [τ_relax, τ_relax + E[τ_shock]]; PDMP convolution argument. Decomposed into 1 spectral atom (`paper_pdmp_lowfreq_band`, paper-novel renewal-convolution argument citing Daley-Vere-Jones 2003 §7 for PDMP framework) + 1 hypothesis-predicate atom (`paper_pdmp_satisfies_spectral_hypotheses`, paper PDMP satisfies spectral hypotheses); `thm_tension_cycle` derives kernel-purely from these. Explicit peak (vs band) remains paper-acknowledged numerical observation, not encoded. Companion entries: gap_rem_hawkes_alternative + gap_rem_inhibitory_hawkes_specific_kernel."
  decomposability := "Band statement decomposed into 1 spectral atom + 1 hypothesis-predicate atom: (1) paper-novel renewal-convolution spectral atom (Cat 3 workingAssumption, paper proof construction citing Daley-Vere-Jones 2003 §7); (2) paper PDMP carrier satisfies spectral hypotheses (Cat 3 hypothesis predicate). Explicit peak remains carve-out (paper numerical observation, not theorem-level)."
  computability := "PUBLISHED (band); numerical (peak)."
  attackVector := "Band statement: 2-atom Lean derivation composes `paper_pdmp_lowfreq_band` + `paper_pdmp_satisfies_spectral_hypotheses`. Explicit peak: paper-acknowledged numerical observation, not encoded. Companion: Hawkes alternative + inhibitory-Hawkes simulation."
  attackHistory := ["Hawkes-Bartlett companion with honest low-pass finding", "audit: source-Ledger drift fixed (sorry → paper-bound axiom)", "R45 §13 decomposition: monolithic axiom → Cat 2 Bartlett 1955 + Cat 3 paper-PDMP-hypothesis-predicate + derived theorem"]
  obstacleCitation := none
}

/-- paper source: prop:robustness-extension. -/
-- inputCat: Cat 1


def gap_prop_robustness_extension : LedgerEntry := {
  identifier := "prop:robustness-extension"
  paperLabel := "prop:robustness-extension"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "CLOSED IN LEAN via explicit count-witness on 4-case extension (0 strict + 2 joint-shock partials + 0 violations + 2 ambiguous-implicit). Count tuple ⟨0, 2, 0, 4, by omega⟩ + IsRobustnessExtension4Case (4 rfls). Content-limit: trivial-existential. Paper-side: PUBLISHED ARITHMETIC."
  decomposability := "4-case extension count encoded as count tuple."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via explicit witness ⟨⟨0, 2, 0, 4, _⟩, rfl, rfl, rfl, rfl⟩; no `sorry`."
  attackHistory := ["R9-Lean-close--trivial-existential-witness-on-IsRobustnessExtension4Case-def"]
  obstacleCitation := none
}

/-- paper source: prop:era-from-tech. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_era_from_tech : LedgerEntry := {
  identifier := "prop:era-from-tech"
  paperLabel := "prop:era-from-tech"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Conditional on Perez 2002 / Freeman-Louca 2001 techno-paradigm priors (η_k(τ), ν_k(τ)) per Kondratieff wave, the predicted Cobb-Douglas exponent ordering matches empirical ordering in 3 of 3 calibratable eras (mercantile c>b>a; industrial c>a>b; late-industrial b>c≥a); joint p ≈ 0.005 under per-era random-ordering null. α=1 fixed throughout, no in-sample tuning. Era classification itself defined by `def:kondratieff-tullock`."
  decomposability := "4 era classifications."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:cross-scale-portability. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_cross_scale_portability : LedgerEntry := {
  identifier := "prop:cross-scale-portability"
  paperLabel := "prop:cross-scale-portability"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. The framework's structure transfers to firm-level competition (paper-bound firm dyads: Apple/Samsung + TSMC vs. Intel; historical NU_F-dominated collapses BlackBerry / Nokia / Kodak with Π_F, Μ_F materially positive at collapse). COMPLETED: full decomposition of `paper_prop_cross_scale_portability_holds` into 4 per-facet paper-bound sub-axioms matching paper's explicit 3-structural + 1-quantitative itemization: `paper_prop_cross_scale_cd_form_transfers_` (T1: Cobb-Douglas form), `_three_axis_decomp_transfers_` (T2: 3-axis decomp), `_nonsubstitutability_transfers_` (T3: non-substitutability — fresh axiom, does NOT logically derive from `cor_cross_scale_nonsub` which is a scale-spanning enumeration tautology with no EconomicSystem argument; `cor_cross_scale_nonsub` + the 3 firm collapses are the empirical WITNESS, not the type-level antecedent), `_exponent_shift_direction_` (Q: firm-level exponents (0.35, 0.20, 0.45) shift c up 0.39→0.45 and a down 0.40→0.35 vs state-level, b≈flat 0.21→0.20, direction structurally predicted by rising r_NU and |∂W/∂x_NU| at firm scale). All 4 `_pending_carrier_inhabitation`-suffixed (bodies opaque EconomicSystem→Prop pending the constructor). The opaque `IsFirmLevelPortableExtension` axiom predicate is replaced by a canonical CONJUNCTION `def := T1 ∧ T2 ∧ T3 ∧ Q` (Types.lean) — type-level visible. The composite `paper_prop_cross_scale_portability_holds_pending_carrier_inhabitation` is now a Lean-PROVED theorem: `⟨T1, T2, T3, Q⟩`. Signature UNCHANGED (zero caller breakage). NOTE: 'MS/Google' dyad sometimes seen in older Lean docstrings is NOT in the paper Remark — removed from paper-bound text."
  decomposability := ": 4 paper-bound sub-axioms, one per paper-itemized facet, composed conjunctively. T1 (CD form transfers), T2 (3-axis decomp transfers), T3 (non-substitutability transfers — fresh axiom, cor_cross_scale_nonsub is witness not antecedent), Q (firm-level exponent shift direction). Each is a single-step typed bridge per `feedback_lean_axiom_decomposition.md`; canonical predicate body is the 4-conjunction. All 4 carrier-pending (opaque EconomicSystem→Prop)."
  computability := "PUBLISHED (each facet is a paper-evidenced claim; structural-3 verified on firm dyads + collapses, quantitative-1 verified by firm-level calibration)."
  attackVector := "FULLY DECOMPOSED in + theorem-derived in Lean from 4 sub-axioms. IsFirmLevelPortableExtension now non-opaque (conjunction def). Signature preserved. Substantive bodies blocked on the `EconomicSystem` constructor + (for Q) firm-level r_NU / ∂W/∂x_NU accessors."
  attackHistory := ["-B-audit--classified-as-DECOMPOSE-3-structural-plus-1-quantitative-facets...", "-patch---audit-confirmed-4-facets-conjunctive-all-EconomicSystem-Prop-no..."]
  obstacleCitation := some "batch (queued): give the 4 new opaque `HasFirmLevel*` / `FirmLevelExponentShiftDirection` component predicates substantive bodies once the `EconomicSystem` constructor lands (+ for Q, firm-level `r_NU : EconomicSystem → ℝ` and `∂W/∂x_NU : EconomicSystem → ℝ` accessors). Per the 4 separate Group-Q Ledger entries (`gap_predicate_firmlevel_*`)."
}

/-- paper source: prop:strange-as-era-varying. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_strange_as_era_varying : LedgerEntry := {
  identifier := "prop:strange-as-era-varying"
  paperLabel := "prop:strange-as-era-varying"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Strange's weak incommensurability embedded in framework's era-varying substitution rate (~12× variation across mercantile/industrial/late-industrial via c/a from technology priors)."
  decomposability := "1 atomic claim + 3 era values."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:strict-nesting. -/
-- inputCat: Cat 1


def gap_prop_strict_nesting : LedgerEntry := {
  identifier := "prop:strict-nesting"
  paperLabel := "prop:strict-nesting"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "CLOSED IN LEAN by refactoring `AlternativeCompositeIndex` from opaque axiom to inductive type with 5 constructors and `classifyAlternativeIndex` from axiom to def with pattern matching; the 5-way conjunction discharges to ⟨rfl, rfl, rfl, rfl, rfl⟩. Paper-side: PUBLISHED. Alternative aggregators relate to the Cobb-Douglas family as follows: CINC (axiom-relaxation, additive limit relaxing A3); Mearsheimer/ECI/Ayres-Warr (parameter restrictions at simplex vertices); Beckley (boundary case, (2,-1,0) negative exponent violates A2 strict positivity)."
  decomposability := "5 atomic classifications (one per alternative index)."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean (`MainTheorem.prop_strict_nesting := ⟨rfl, rfl, rfl, rfl, rfl⟩`); no `sorry`."
  attackHistory := ["R8-Lean-close--inductive-AlternativeCompositeIndex-plus-def..."]
  obstacleCitation := none
}

/-- paper source: prop:two-axis-reduction (Mearsheimer reduction). -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_prop_two_axis_reduction : LedgerEntry := {
  identifier := "prop:two-axis-reduction"
  paperLabel := "prop:two-axis-reduction"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. Mearsheimer GDP × Population is projection onto slow-stock cluster PI alone; loses MU and NU. Misclassifies late-imperial Britain and late USSR (paper §sec:comparison)."
  decomposability := "1 atomic claim + 2 misclassification examples."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:four-axis-reduction (Strange reduction). -/
-- inputCat: Cat 1 ( — reclassified from Cat 3; theorem composes only Mathlib, no paper_* axioms)


def gap_prop_four_axis_reduction : LedgerEntry := {
  identifier := "prop:four-axis-reduction"
  paperLabel := "prop:four-axis-reduction"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED. Strange's four-axis typology (Production, Finance, Security, Knowledge) reduces to three on analytical horizon: Finance + Security both load on NU; Knowledge either loads on PI (productive-tech-stock reading) or operates on slower cluster outside scope (civilizational-worldview reading)."
  decomposability := "4 axis reductions."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: prop:fourth-axes (no fourth axis admissible). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_prop_fourth_axes : LedgerEntry := {
  identifier := "prop:fourth-axes"
  paperLabel := "prop:fourth-axes"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. No fourth axis (knowledge, soft power, separately-mobilized military, institutional resilience, demographic capacity) is admissible — each either reduces to {PI, MU, NU} or operates outside analytical horizon."
  decomposability := "5 candidate-fourth-axis rejections."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := ["Lean-R2-add--paper-prop-coverage-expansion"]
  obstacleCitation := none
}

/-! ## Group H: omissions caught by fresh-agent hostile review -/

/-- paper source: thm:threshold-case-specific; Lean:
 `MainTheorem.thm_threshold_case_specific`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_thm_threshold_case_specific : LedgerEntry := {
  identifier := "thm:threshold-case-specific"
  paperLabel := "thm:threshold-case-specific"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PUBLISHED. Threshold-crossing application (axis-form + composite-form dual test) of the case-specific multilateral form θ̄(t) = θ̄_req · K(t) (formula derivation = `gap_prop_theta_bar_case`). Threshold-crossing event detected when either (a) `min_k x_k(t)/x̄_k(t) < 1` (axis-form) OR (b) `Influence_h(t) < θ̄_req · Influence_C(t)` (composite-form). Numerical paper Table values: Spain 1700 6.00; Netherlands 1750 5.16; Britain 1956 5.07; USSR 1985 4.47; Russia 2024 5.62; US 2025 5.30."
  decomposability := "1 atomic algebraic claim + 6 case calibrations."
  computability := "PUBLISHED."
  attackVector := "CLOSED in Lean via paper-bound axiom discharge."
  attackHistory := []
  obstacleCitation := none
}

/-- paper source: def:structural-tension; Lean: `MainTheorem.structural_tension`. -/
-- inputCat: Cat 3
-- subType: structural-eq


def gap_def_structural_tension : LedgerEntry := {
  identifier := "def:structural-tension"
  paperLabel := "def:structural-tension"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "PUBLISHED. Structural tension T(x_i, x_{-i}) = w_c · T_cross + w_s · T_state + w_r · T_rent with non-negative weights and three components. Used by `prop:clustering` + `thm:tension-cycle`."
  decomposability := "Decomposed into (a) carrier `structural_tension`; (b) 3 component carriers `structuralTension_T_cross/state/rent`; (c) 3 weight carriers `structuralTension_w_c/s/r` with paper-stipulated non-negativity axioms; (d) structural-defining-equation axiom `structural_tension_def` encoding the 3-term sum."
  computability := "PUBLISHED."
  attackVector := "Lean axiomatization per §3.4.3 spec for Cat 3 structural-defining equations: paper's primitives axiomatized as carriers + paper-stated equation surfaced as typed equation axiom `structural_tension_def`."
  attackHistory := ["prior encoding was carrier-only (axiom of type `EconomicSystem → EconomicSystem → ℝ` with no defining equation); per §3.4.3 spec the paper-stated equation has been added as `structural_tension_def`, with the three components + three weights as paper-stipulated carriers"]
  obstacleCitation := none
}

/-! ## Group I: paper-empirical + structural-extension claims -/

/-- paper source: rem:hss-D-positivity; Lean: `Types.paperHSS_D_positive_at_headline_calibration`
 (covered by `paperAggregator_pos_on_pos`). Paper-empirical: D > 0 at
 headline calibration α=0.010 verified per-case via script. -/
-- inputCat: Cat 1


def gap_rem_hss_D_positivity : LedgerEntry := {
  identifier := "rem:hss-D-positivity"
  paperLabel := "rem:hss-D-positivity"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "PUBLISHED + script-verified. Per-case D = δ_PI·δ_NU - α_PI,NU·α_NU,PI evaluated for 11 historical cases + Saudi-US 1970 static at headline α=0.010: late-industrial template (10 cases) D = 9×10⁻⁴ (interior); information-era template (1 case Russia 2014-2024) D = 1×10⁻⁴ (BORDERLINE). Sensitivity-grid: 6 of 16 cells D ≤ 0 in saddle-node region (already scope-restricted). Script `hss_d_check.py`."
  decomposability := "Per-case headline-calibration check (12 cases) + sensitivity-grid scope (16 cells)."
  computability := "ARITHMETIC (5-min Python)."
  attackVector := "Closed via paper Remark + script `hss_d_check.py`; D > 0 condition verified at all calibration points used in paper."
  attackHistory := ["R6-add--explicit-per-case-D-verification-script-hss_d_check-with-borderline..."]
  obstacleCitation := none
}

/-- paper source: thm:tullock-microfoundation eq:corrected-elasticity; Lean:
 `Types.paperTullock_corrected_elasticity_pending_log_derivative_body`. -/
-- inputCat: Cat 3
-- subType: structural-eq


def gap_eq_corrected_elasticity : LedgerEntry := {
  identifier := "eq:corrected-elasticity"
  paperLabel := "thm:tullock-microfoundation eq:corrected-elasticity"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "PUBLISHED on paper side: ∂log Influence_i / ∂log x_{i,k} = r_k·(1-s_{i,k}) by direct differentiation of `p = x^r/(x^r+Y)`. Lean side: predicate `IsCorrectedTullockElasticity` opaque pending Lean log-derivative operator on `Influence`; the value `r_k·(1-s_k)` is carried explicitly in `paperTullock_corrected_elasticity_pending_log_derivative_body`. Companion typed bridges: `paperTullock_share_in_unit_interval` (s ∈ [0,1)) + `TullockWeightShare` opaque carrier."
  decomposability := "2 typed bridges: (a) share-in-unit-interval, (b) elasticity = r·(1-s)."
  computability := "PUBLISHED (one-line differentiation)."
  attackVector := "Decomposed into typed-bridge axioms; substantive log-derivative discharge pending Lean port of `Influence` differentiability."
  attackHistory := ["R6-add--paper-rewrite-thm-tullock-microfoundation-with-exact-form-and-eq..."]
  obstacleCitation := some "Mathlib/paper-mathematics: substantive `IsCorrectedTullockElasticity` body requires log-derivative operator on opaque `Influence` functional."
}

/-- paper source: rem:kl-projection-mle; Lean:
 `Types.paperKLProjection_tension_number_at_optimum`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_kl_projection_mle : LedgerEntry := {
  identifier := "rem:kl-projection-mle"
  paperLabel := "rem:kl-projection-mle"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "PUBLISHED + two-script comparison. (a) Gaussian-residual approximation (kl_projection_mle.py): λ*=1.0, tension=0.500, MIXED regime, posit and data carry comparable weight. (b) Per-case L_collapse (kl_projection_mle_per_case.py): explicit per-case collapse-time likelihoods on 6 regime-(i) cases at heuristic t_pred(γ) = 1/(Σ γ_k δ_k); λ*=0.0, tension=0.000, DATA dominates (corner solution at (1,0,0)). HONEST FINDING: the per-case implementation reveals the corner-solution issue thm:exponent-derivation Step 3 explicitly acknowledges. The survival-weight prior (0.83, 0.04, 0.13) is recovered as λ→∞ in both runs. Lean: numeric existence claim `∃ tension, |tension - 1/2| ≤ 1/100` (Gaussian-residual run only)."
  decomposability := "2 implementations: Gaussian-residual + per-case L_collapse."
  computability := "ARITHMETIC + simplex grid search + LOO-cv."
  attackVector := "Two-implementation pair quantifies posit-vs-data tension at both interior (Gaussian) and corner (per-case) regimes; full closed implementation tying L_collapse to non-degenerate per-case likelihood (with corner-solution penalty) is the natural next step."
  attackHistory := ["R6-add--KL-projection-MLE-Python-implementation-with-LOO-cross-validation...", "R7-add--per-case-L_collapse-implementation-kl_projection_mle_per_case-reveals...", "R8-add--axis-coverage-penalty-script-kl_projection_mle_axis_coverage-confirms..."]
  obstacleCitation := some "Corner-pull is structural to the t_pred = 1/(Σ γ_k δ_k) heuristic itself; recovery of empirical (0.40, 0.21, 0.39) requires either (a) different t_pred (multi-axis crossing model), or (b) λ_KL → ∞ forcing the survival-weight prior."
}

/-- paper source: rem:permutation-test-pre-registration + cor:ex-ante-pvalue;
 Lean: `Types.paperPermutationTest_strong_informed_null_p_value`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_permutation_test : LedgerEntry := {
  identifier := "rem:permutation-test-pre-registration"
  paperLabel := "rem:permutation-test-pre-registration"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "PUBLISHED + script-verified. Three reference distributions for cor:ex-ante-pvalue: uninformed (p_match=1/6, p≈4×10⁻⁶ rejected); mild (p_match=1/3, p≈1.4×10⁻³ rejected); strong (p_match=2/3, p≈0.234 NOT REJECTED). Headline 4×10⁻⁶ is rejection of UNINFORMED null only. Bootstrap-verified at n=100,000. Script `permutation_p_value.py`. Lean: `binomialUpperTail 11 9 (2/3) ≥ 1/5`."
  decomposability := "3 null reference distributions; one numeric bound."
  computability := "ARITHMETIC + bootstrap."
  attackVector := "Closed via paper Remark + script + Lean numeric bound; OSF pre-registration + Pearl 2009 do-calculus formalization queued for next 11-case extension."
  attackHistory := ["R6-add--permutation-test-bootstrap-Python-with-3-null-reference-distributions..."]
  obstacleCitation := some "OSF pre-registration of regime-classification protocol pending; current p-values are post-hoc benchmarks."
}

/-- paper source: rem:hawkes-alternative; Lean:
 `Types.paperHawkes_kernel_class_exists` (existence) +
 `Types.paperHawkes_damped_oscillatory_centennial_peak` (concrete
 kernel calibration). -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_rem_hawkes_alternative : LedgerEntry := {
  identifier := "rem:hawkes-alternative"
  paperLabel := "rem:hawkes-alternative"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat2External
  closureDistance := "PUBLISHED Bartlett spectrum closed form f(ω) = (μ/(1-η))/|1-φ̂(ω)|² for sub-critical Hawkes; CV² < 1 accommodation requires INHIBITORY Hawkes (Brémaud-Massoulié 1996, Annals of Probab. 24(3):1563-1588): inverted |η| = 1/CV² - 1 ≈ 1.22 at empirical CV² = 0.45. Concrete kernel calibration: damped-oscillatory φ(u) = a·exp(-bu)·cos(ω_0·u) at (a, b, ω_0) = (3.84e-4, 1/60, 2π/192) reproduces PDMP simulation's centennial peak T_cycle = 193.7 yr (vs paper-reported median 192 yr; 1.7 yr difference). Sub-criticality η ≈ 4.7e-3 < 1 deeply satisfied. Scripts `hawkes_bartlett_spectrum.py` (low-pass finding) + `hawkes_damped_oscillatory.py` (centennial-peak closure)."
  decomposability := "Bartlett closed form (derived) + CV² inversion (derived) + concrete damped-oscillatory kernel calibrated."
  computability := "ARITHMETIC + Fourier transform."
  attackVector := "Bartlett closed form + CV² inversion done; concrete damped-oscillatory kernel reproduces centennial peak; empirical identification of (a, b, ω_0) from historical record remains future work."
  attackHistory := ["R6-add--Hawkes-Bartlett-spectrum-Python-with-honest-finding-simple-exp-kernel...", "R7-close--damped-oscillatory-Hawkes-kernel-calibrated-T_cycle-193.7-yr-matches...", "R8-add--empirical-Hawkes-MLE-fit-on-9-event-record-T_peak-1257-yr-NOT..."]
  obstacleCitation := some "Empirical identification underpowered at n=9 (Bacry-Delattre-Hoffmann-Muzy 2013 recommend n~30); MLE-optimal T_peak ≈ 1257 yr differs from construction-calibrated 193.7 yr by an order of magnitude; LR vs Poisson NOT REJECTED."
}

/-- paper source: rem:pre-register-regime-density (D1 cs-vs-co identification);
 Lean: encoded as paper-bound predicate (carrier-pending). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_pre_register_regime_density : LedgerEntry := {
  identifier := "rem:pre-register-regime-density"
  paperLabel := "rem:pre-register-regime-density"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "PRE-REGISTERED methodology in code (script `regime_density_w_tr.py`). HONEST FINDING from 4-case subset (Spain, Netherlands, Britain, USSR): predicted r_k^co from empirical-frequency w_k^tr is (1.06, 0.78, 1.00) vs calibrated (0.40, 0.21, 0.39); gap exceeds 0.25 on every axis (peak 0.66 on PI), UNFAVOURED reconciliation. Three diagnoses: (i) 4-case subset too small; (ii) sub-regime taxonomy too coarse; (iii) cs-vs-co gap FUNDAMENTAL. Full 11-case primary-source archival extraction queued for next revision."
  decomposability := "Methodology + 4-case subset + 11-case full extraction (queued)."
  computability := "PUBLISHED methodology + ARITHMETIC bootstrap; full primary-source extraction pending."
  attackVector := "Methodology pre-registered in code; per-case primary-source classifications can be added without revisiting inference framework."
  attackHistory := ["R7-add--pre-registered-regime-density-script-regime_density_w_tr-with-4-case..."]
  obstacleCitation := some "Full 11-case primary-source archival extraction (BEA / IMF COFER / WIPO PCT / SIPRI for modern; standard historical sources for pre-modern) pending."
}

/-! ## Group J: model-extension proposals (honest-finding follow-up) -/

/-- paper source: rem:model-extension-multi-axis; Lean:
 `Types.paperMultiAxisCrossing_escapes_corner_pull`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_model_extension_multi_axis : LedgerEntry := {
  identifier := "rem:model-extension-multi-axis"
  paperLabel := "rem:model-extension-multi-axis"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "DEMONSTRATED. Multi-axis crossing model t_pred(γ) = max_k {log(θ̄)/(γ_k · δ_k)} (script `multi_axis_crossing_mle.py`) ESCAPES the corner-pull issue of the single-eigenvalue heuristic: at unregularised λ=0 the MLE optimum is INTERIOR γ̂ = (0.185, 0.037, 0.777), not corner. At cross-validated λ*=100 γ̂ = (0.833, 0.037, 0.130) near survival-weight prior. Validates the empirical (0.40, 0.21, 0.39) calibration as consistent with multi-axis-crossing structure (not single-mode-eigenvalue)."
  decomposability := "1 structural-finding claim + 1 numeric witness (γ̂ interior)."
  computability := "ARITHMETIC + simplex grid search."
  attackVector := "Closed via paper Remark + script + Lean axiom encoding existence of interior γ̂."
  attackHistory := ["R8-add--multi-axis-crossing-model-escapes-corner-pull-script-multi_axis..."]
  obstacleCitation := none
}

/-- Substantive finding originally published as paper Remark
 `rem:model-extension-hmm`; that remark was REMOVED from paper in the
 v6 successor-models restructure. The HMM-CV²>1 ruling-out finding is
 retained here as a Lean axiom + companion script
 `paper/hmm_regime_switching_hazard.py` per §11 (substantive content
 stays even when paper restructures the prose surface). Lean axiom:
 `Types.paperHMM_2state_does_not_accommodate_subPoisson`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_rem_model_extension_hmm : LedgerEntry := {
  identifier := "rem:model-extension-hmm"
  paperLabel := "(removed from paper v6 successor-models restructure; finding retained in script hmm_regime_switching_hazard.py)"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "RULED OUT. 2-state Hidden Markov hazard fitted on post-1640 record (script `hmm_regime_switching_hazard.py`) gives implied CV² ≈ 1.08 > 1. Structural reason: marginal mixture of exponentials always has CV² ≥ 1 (over-dispersion w.r.t. exponential baseline). HMM is therefore RULED OUT as a CV² < 1 alternative. Inhibitory Hawkes (Brémaud-Massoulié 1996) remains the operative successor model for CV² < 1 accommodation."
  decomposability := "1 NEGATIVE finding (HMM ruled out for CV² < 1)."
  computability := "ARITHMETIC + structural lower bound (mixture of exponentials)."
  attackVector := "Closed via paper Remark + script + Lean axiom encoding mixture-of-exponentials lower bound."
  attackHistory := ["R8-add--2-state-HMM-hazard-fit-on-9-event-record-CV-squared-implied-1.08-NOT..."]
  obstacleCitation := none
}

/-- paper source: rem:model-extension-queue (superseded by individual
 implementations below; this entry retained for backward-reference). -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_model_extension_queue : LedgerEntry := {
  identifier := "rem:model-extension-queue"
  paperLabel := "rem:model-extension-{multi-axis, state-dependent-decay, translog, two-timescale, combined} (queued items materialized as individual paper remarks; hmm + combined-joint-fit subsequently removed in v6 successor-models restructure)"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "superseded by implementations below: rem:model-extension-state-dependent-decay (PARTIAL), rem:model-extension-translog (STRUCTURAL), rem:model-extension-two-timescale (NOT SUFFICIENT)."
  decomposability := "Superseded by per-extension entries."
  computability := "Implementations now available."
  attackVector := "Closed via per-extension Lean axioms + scripts."
  attackHistory := ["R8-add--three-model-extension-proposals-queued-state-dependent-delta-translog...", "-supersede--three-extensions-implemented-with-honest-PARTIAL-STRUCTURAL-NOT..."]
  obstacleCitation := none
}

/-- paper source: rem:model-extension-state-dependent-decay; Lean:
 `Types.paperStateDependentDecay_partial_recovery`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_model_extension_state_dependent_decay : LedgerEntry := {
  identifier := "rem:model-extension-state-dependent-decay"
  paperLabel := "rem:model-extension-state-dependent-decay"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "PARTIAL implementation. State-dependent δ_k(x_k) = δ_k^0 · (x_k/x_k^*)^{-h_k} (paper-novel multiplicative form ) tested on 6-case calibration set (script `state_dependent_decay.py`). Best-recovery hysteresis (h_PI, h_MU, h_NU) = (1.60, 0.40, 0.80) yields γ̂ = (0.512, 0.013, 0.475), L2 distance 0.243 from empirical (0.40, 0.21, 0.39). PARTIAL: γ_MU stays near zero because heuristic structurally underweights MU even with hysteresis. Per-axis literature anchors ( verified): Pisano-Shih 2012 (PI), Besley-Persson 2011 + Acemoglu-Robinson 2019 (MU), Eichengreen 2011 + Schenk 2010 (NU)."
  decomposability := "1 paper-novel multiplicative form + 3 per-axis hysteresis exponents."
  computability := "ARITHMETIC + simplex grid search."
  attackVector := "Implemented via paper Remark + script + Lean existence axiom; PARTIAL recovery (distance ≤ 0.30) flagged honestly."
  attackHistory := ["-add--state-dependent-delta-multiplicative-form-paper-novel-construction-best...", "-strengthen--Lean-axiom-promoted-to-theorem-with-explicit-script-witness-via..."]
  obstacleCitation := some "Multiplicative form δ_k(x_k) = δ_k^0 · (x_k/x_k^*)^{-h_k} is paper-novel construction (no canonical literature analogue). Empirical identification of (h_PI, h_MU, h_NU) from per-axis erosion data queued."
}

/-- paper source: rem:model-extension-translog; Lean:
 `Types.paperTranslog_admits_csco_distinction`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_rem_model_extension_translog : LedgerEntry := {
  identifier := "rem:model-extension-translog"
  paperLabel := "rem:model-extension-translog"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat2External
  closureDistance := "STRUCTURAL implementation. Translog refinement of Cobb-Douglas (Christensen-Jorgenson-Lau 1973 / Berndt-Christensen 1973 ) admits operating-point-dependent local elasticity. Cross-term β_PI,NU = 0.3 illustrative parameterization shows local elasticity ranges from -0.191 (at x_NU = 0.1) to 0.708 (at x_NU = 2.0). The cs-vs-co identification gap is structurally accommodated as r_cs = average local elasticity (cross-section) vs r_co = local elasticity at hegemonic-collapse trajectory; Cobb-Douglas constant elasticity FORCES r_cs = r_co (single elasticity); translog admits r_cs ≠ r_co naturally. Empirical estimation of (a_k, β_kj) from richer dataset queued. Script `translog_refinement.py`."
  decomposability := "Translog functional form + cross-term parameterization + cs-vs-co accommodation."
  computability := "PUBLISHED (translog from Christensen-Jorgenson-Lau 1973)."
  attackVector := "Implemented via paper Remark + script + Lean existence axiom encoding non-zero cross-term yielding operating-point-dependent local elasticity."
  attackHistory := ["-add--translog-refinement-Christensen-Jorgenson-Lau-1973-cross-term-structure...", "-strengthen--Lean-axiom-promoted-to-theorem-with-explicit-witness-beta-3-10-via..."]
  obstacleCitation := some "Empirical estimation of translog parameters (a_k, β_kj) from richer dataset (more cases / more contest-types) queued for next revision."
}

/-- paper source: rem:model-extension-two-timescale; Lean:
 `Types.paperTwoTimescale_alone_not_sufficient`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_rem_model_extension_two_timescale : LedgerEntry := {
  identifier := "rem:model-extension-two-timescale"
  paperLabel := "rem:model-extension-two-timescale"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "RULED INSUFFICIENT. Two-timescale separation slow-ODE (T_slow ~ 100 yr) vs fast-Tullock (T_fast ~ 5 yr; ε = 0.05 << 1) implemented via Tikhonov-Fenichel slow-manifold reduction (Tikhonov 1952 + Fenichel 1979 + Kuehn 2015, with Sandholm 2010 / Hofbauer-Sigmund 1998 OVERCLAIM corrected — they don't develop two-timescale population-game theory; Benaim-Weibull 2003 is the true two-timescale anchor). Trajectory-averaged slow-effective elasticity = (0.605, 0.876, 0.411) is CLOSER to r_cs = (0.93, 1.27, 0.67) (distance 0.573) than to r_co = (0.40, 0.21, 0.39) (distance 0.697). HONEST FINDING: two-timescale alone does NOT reconcile cs-vs-co. Combined extension (multi-axis crossing + state-dependent δ + translog) needed. Script `two_timescale_separation.py`."
  decomposability := "Tikhonov-Fenichel slow-manifold + paper-novel application slow-ODE-vs-fast-Tullock."
  computability := "ARITHMETIC + Tikhonov-Fenichel."
  attackVector := "RULED INSUFFICIENT honestly via paper Remark + script + Lean existence axiom encoding distance comparison."
  attackHistory := ["-add--two-timescale-separation-Tikhonov-Fenichel-Benaim-Weibull-2003-correct...", "-strengthen--Lean-axiom-promoted-to-theorem-with-explicit-script-witness-dist..."]
  obstacleCitation := none
}

/-- Substantive finding originally published as paper Remark
 `rem:model-extension-combined-joint-fit`; that remark was REMOVED from
 paper in the v6 successor-models restructure. The combined-extension
 negative-finding diagnosis (max_k aggregator non-identification) is
 retained as a Lean theorem + companion script
 `paper/combined_extension_joint_fit.py` per §11. Lean theorem:
 `Types.paperCombinedExtension_does_not_recover_empirical`. -/
-- inputCat: Cat 3
-- subType: working-assumption


def gap_rem_model_extension_combined_joint_fit : LedgerEntry := {
  identifier := "rem:model-extension-combined-joint-fit"
  paperLabel := "(removed from paper v6 successor-models restructure; finding retained in script combined_extension_joint_fit.py)"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "HONEST NEGATIVE FINDING + mechanism diagnosis + LogSumExp-fix withdrawal. Joint optimization over (γ, h, β) of the combined model (multi-axis crossing + state-dependent δ + translog cross-terms) under the heuristic max_k predicted-collapse-time aggregator yields γ̂ = (0.180, 0.740, 0.080) at L²-distance 0.652 from empirical r_co = (0.40, 0.21, 0.39); WORSE than no-extension Cobb-Douglas baseline of 0.479. identified the SOURCE of this negative finding as objective-function degeneracy, NOT under-determination of empirical data: the max_k aggregator collapses the K-axis predictor to its slowest-decaying axis, eliminating identification of γ_MU and γ_NU when γ_PI is small relative to δ_PI⁻¹ (verified: loss is essentially constant across (γ_MU, γ_NU) for any small γ_PI region). The paper-side headline (0.40, 0.21, 0.39) was obtained by case-specific regime-density MLE on post-1640 (\\S\\ref{sec:experiments}), NOT by max_k heuristic, and that smoother case-likelihood does not exhibit the corner-selection degeneracy. : an earlier-draft 'future work' suggestion to replace max_k with a smoothed soft-max / LogSumExp aggregator is WITHDRAWN — LogSumExp introduces a temperature parameter as a 10th free DoF on the n=6 search and does not address the root mismatch between the max_k tractability heuristic and the paper's actual case-likelihood MLE. CONCLUSION: the joint construction is exploratory model-design composition; the negative finding stands as a stress test of the max_k heuristic, NOT a falsification of the underlying composition or the paper-side calibration; no aggregator swap fixes it because no aggregator swap is the right diagnostic axis. Script `combined_extension_joint_fit.py`."
  decomposability := "Joint grid search over 9-parameter combined model (γ on simplex × h ∈ {0, 1.5}^3 × β ∈ {0, 0.3}^3) + 6-case post-1640 calibration target."
  computability := "ARITHMETIC (numerical optimization)."
  attackVector := "Implemented honestly via paper Remark + script + Lean theorem encoding the negative-finding distance comparison; reframed as objective-degeneracy diagnosis; LogSumExp-aggregator-swap suggestion withdrawn."
  attackHistory := ["-add--combined-extension-joint-fit-honest-negative-finding-distance-652-1000-vs...", "--audit-confirmed-no-economics-literature-precedent-for-paper-novel-composition...", "--audit-identified-max_k-aggregator-corner-selection-degeneracy-as-mechanism...", "--audit-B2-LogSumExp-aggregator-swap-suggestion-withdrawn-temperature-parameter..."]
  obstacleCitation := some "max_k aggregator non-identification of (γ_MU, γ_NU) under any γ_PI small relative to δ_PI⁻¹. Root cause is that max_k is a tractability heuristic disjoint from the paper's actual case-specific regime-density MLE used for the headline calibration; no aggregator swap fixes it ( : LogSumExp swap suggestion withdrawn — adds temperature as a 10th free parameter on n=6 observations without addressing the heuristic-vs-paper-MLE mismatch)."
}

/-- paper source: rem:inhibitory-hawkes-specific-kernel; Lean:
 `Types.paperInhibitoryHawkes_accommodates_subPoisson_CV2`. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_rem_inhibitory_hawkes_specific_kernel : LedgerEntry := {
  identifier := "rem:inhibitory-hawkes-specific-kernel"
  paperLabel := "rem:inhibitory-hawkes-specific-kernel"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "POSITIVE FINDING ( corrected) — sub-Poisson CV² < 1 ACCOMMODATED. Pure exponential inhibitory Hawkes kernel φ(u) = -a·exp(-b·u) (Brémaud-Massoulié 1996 signed reproduction-measure framework; Costa et al. 2020 Adv. Appl. Probab. 52(3):879-915 + Duval-Luçon-Pouzat 2022 SPA 148:180-226 — earlier JAP attribution mis-quoted, corrected) under proper asymptotic estimation (50 seeds × T_max=5000 yr per seed, pooled gap estimator, ~3500-4000 gaps total per η): scanning η = -a/b ∈ {-0.5, -0.6,., -0.95} gives monotonically decreasing CV² from 0.5165 (η=-0.5) to 0.3572 (η=-0.95), all sub-Poisson. Best fit: η_star = -0.6, pooled CV² = 0.4613 ± 0.0117 (1 SEM); empirical post-1640 = 0.447 falls inside 95% CI of pooled estimate (|0.0143| ≤ 1.96 × 0.0117 = 0.0229). The QUALITATIVE claim (sub-Poisson regime achievable) is robust across η grid; the QUANTITATIVE η_star ≈ -0.6 is identified with finite SEM by simulation. 'η = -0.9, CV² = 0.465' was a 5-seed-cherry-picked artifact (~3σ above asymptotic mean ~0.37 at that η), withdrawn at. LINEAR inhibitory Hawkes is SUFFICIENT — nonlinear extensions (Brémaud-Massoulié Section 3 positive-part link, Costa et al. 2020 refractory periods, Duval-Luçon-Pouzat 2022 multiplicative inhibition) NOT REQUIRED. Resolves rem:hawkes-alternative kernel-selection question. Script `inhibitory_hawkes_specific_kernel.py`."
  decomposability := "Inhibitory exponential kernel + Ogata thinning simulation + 50-seed × 5000-yr pooled gap-CV² estimation + per-seed SEM."
  computability := "ARITHMETIC + simulation ( : closed-form CV² for INTER-EVENT GAP not available in either linear or nonlinear Hawkes; Bartlett-spectrum identity 1/(1-η)² is the COUNT FANO factor, dimensionally distinct from gap CV² — they coincide only at Poisson; empirical fit must proceed by simulation; reference rem:hawkes-alternative for the corrected statement of the count-Fano vs gap-CV² distinction)."
  attackVector := "Closed via paper Remark + script + Lean theorem encoding all five positive-finding witnesses (η in sub-critical interval, simulated CV² < 1, SEM as separate witness, two-sided 95%-CI bound vs empirical)."
  attackHistory := ["-add--pure-exponential-inhibitory-Hawkes-eta-9-10-simulated-CV2-465-1000-vs...", "--audit-corrected-Costa-2020-to-Adv-Appl-Probab-Duval-2022-to-SPA-CV2-formula...", "--corrected-cherry-pick-detected-replaced-with-50-seed-5000-yr-pooled..."]
  obstacleCitation := none
}

/-- paper source: rem:ig-first-passage-mle; Lean:
 `Types.paperIGFirstPassage_beats_max_k_baseline` +
 `Types.paperIGFirstPassage_closer_to_survival_weight`.

 **inputCategory**: **Cat 3** (paper-
 novel statistical estimator design — IG max-order-statistic
 likelihood as replacement for the degenerate max_k aggregator)
 with **Cat 2 dependency** on Schrödinger 1915 (IG density),
 Tweedie 1957 (IG named distribution + properties), Borodin-Salminen
 2002 (univariate first-passage handbook). Iyengar 1985 explicitly
 NOT chained (Cat 2 adjacency only — bivariate, not used in current
 independent-axes treatment). reductionism: Cat 1 → CLEAR-NO
 (no Mathlib IG distribution); Cat 2 → DEPENDENCY exists but
 currently disconnect (cite chain in docstring, not Lean signature).
 Future round: Hodge-style port `def IGDensity` + `def
 IGMaxOrderStatisticLikelihood` to chain Cat 2 dependency
 explicitly. -/
def gap_rem_ig_first_passage_mle : LedgerEntry := {
  identifier := "rem:ig-first-passage-mle"
  paperLabel := "rem:ig-first-passage-mle + lem:ig-mle-identification (formal lemma in §sec:cardinal-vindication formalizing the IG-MLE identification + bias-variance content)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "POSITIVE FINDING (gap patch). Inverse-Gaussian first-passage max-order-statistic likelihood replaces the degenerate max_k aggregator of `rem:model-extension-combined-joint-fit`, structurally curing the information-erasure pathology. Cite chain: Schrödinger 1915 (Phys. Z. 16, IG density), Tweedie 1957 (Annals Math. Stat. 28, IG named distribution + properties), Borodin-Salminen 2002 (handbook Ch. II.1, univariate reference). Iyengar 1985 (SIAM J. Appl. Math. 45:983-989) treats BIVARIATE Brownian first-passage only — cited as the right joint-structure reference if cross-coupling α_km ≠ 0 is needed; current calibration assumes axis-independence at the first-passage level. Each axis k has log-capability drift to log threshold; T_k ~ IG(μ_k, λ) with μ_k = log(θ̄) / (γ_k · δ_k). Likelihood for scalar t_i = max(T_PI, T_MU, T_NU): L_i(γ; λ) = Σ_k [f_k(t_i; μ_k, λ) · Π_{j≠k} F_j(t_i; μ_j, λ)]. Gradient ∂L_i/∂γ_k is non-zero on EVERY axis via the Π F_j factor, curing the max_k information erasure. Script `ig_first_passage_mle.py`, n=6 industrial cases (Spain 45, Netherlands 115, Britain 84, Qing 75, Ottoman 147, Roman 196 yr): γ̂ = (0.707, 0.037, 0.256), λ̂ = 422.5, L² to (0.40, 0.21, 0.39) = 0.3774 — BEATS max_k baseline 0.479 and joint-fit 0.652 (IG-MLE 4 free params vs 's 9). Hessian eigvals (0, 2.74, 5.77, 6506); identifiable up to simplex. Synthetic n=100 L² = 0.058 (consistent). Reproducible 30-rep bias/variance harness (seeds 1000-1029, Wald sampler, in committed script): mean γ̂ = (0.397, 0.260, 0.342), bias = (-0.003, +0.050, -0.048), ||bias|| = 0.069, SD (0.083, 0.095, 0.066), median L² = 0.090, 70% clear L²≤0.15. Mild finite-sample bias in MU/NU exchange; NOT unbiased at n=6, but identifiable + non-degenerate. HOLE-1 PARTIAL RESOLUTION: γ̂ L² to survival-weight prediction w = (0.64, 0.18, 0.19) is 0.169 vs empirical L² to w of 0.318 — IG-MLE closer to structural prediction. Real-data γ̂_PI = 0.71 sits ~3.7 SD above synthetic mean under truth (0.40, 0.21, 0.39), so under IG spec either (a) true γ_PI > headline, or (b) IG mis-specified (e.g. cross-coupling); n > 6 needed to discriminate."
  decomposability := "3 verified sub-claims: (a) gradient non-degeneracy (analytic, via Π F_j factor); (b) consistency (synthetic n=100 L² = 0.058); (c) identifiability (Hessian eigenvalues positive up to simplex). 2 Lean theorems: paperIGFirstPassage_beats_max_k_baseline (headline L² inequality) + paperIGFirstPassage_closer_to_survival_weight (gap side-benefit)."
  computability := "ARITHMETIC: Schrödinger/Tweedie IG closed-form density + CDF; scipy Nelder-Mead MLE on neg-log-likelihood; numerical Hessian + eigenvalues via finite differences."
  attackVector := " surveyed 4 aggregator-replacement candidates (Cox/AG 1972/1982, frailty Hougaard 2000, copula Nelsen 2006, IG first-passage Schrödinger 1915 / Tweedie 1957 / Iyengar 1985); only IG survived the actual data structure (scalar t_i per case, no per-axis crossing-time labels) — Cox/AG/frailty/copula all presume multi-event observations per cluster. Phase 1 implementation verified non-degeneracy + consistency + identifiability + gap side-benefit via direct numerical computation. Remaining: Lean encoding currently uses numerical witnesses only; substantive Lean predicate for IG density / CDF / likelihood gradient queued."
  attackHistory := ["--audit-surveyed-4-aggregator-candidates-Cox-AG-frailty-copula-IG-first-passage...", "-Phase1-ig_first_passage_mle-py-implemented-gamma-hat-707-37-256-L2-3774-beats...", "--audit-corrected-unbiased-claim-was-non-reproducible-from-committed-script-30...", "-inputCategory-Cat3-with-Cat2-dependency-Schrodinger-1915-Tweedie-1957-Borodin...", "-truth-pursuit-gap-discrimination-test-via-cross-coupled-OU-Monte-Carlo-MLE...", "-RETRACTS--cross-validation-r33_estimator_cross_validation_fast-py-30-reps-each..."]
  obstacleCitation := some "n=6 finite-sample variance + mild bias (||bias|| = 0.069 in MU/NU exchange at n=6 per reproducible 30-rep harness; 70% of reps clear L²≤0.15) is the statistical (not structural) bottleneck. Closure to gapClosed requires (a) n>6 sample size (currently n=6 = regime-(i) industrial subset per joint-fit script; expansion to full 11-case set requires per-regime drift weighting), OR (b) Lean encoding of gradient non-degeneracy + consistency at typed-predicate level (vs current numerical witnesses). gap (real-data γ̂_PI vs survival-weight w) discrimination between true-γ_PI-large vs IG-mis-specification (cross-coupling α_km ≠ 0) also needs n > 6."
}

/-- paper source: rem:var-spectral-test-info-era; Lean:
 `Types.paperVARSpectralTest_info_era_m_equals_3_point_verified` +
 `Types.paperVARSpectralTest_monte_carlo_T_dominance` +
 `Types.paperVARSpectralTest_R21_nickell_correction_boosts_power`.

 **inputCategory**: **Cat 3** (paper-
 novel empirical test design for m=3 in info-era + ++++
 refinements: MC over seeds, n×T power grid, Nickell-bias diagnosis,
 bias correction, bootstrap negative finding) with **Cat 2 dependency**
 on Nickell 1981 (finite-T bias formula) and Kiviet 1995 (queued
 second-order correction). VAR(1) pooled-OLS estimation is standard
 Cat 2 statistics (no specific cite needed). reductionism:
 Cat 1 → CLEAR-NO; Cat 2 → DEPENDENCY exists (Nickell 1981) but
 bias formula is in script comments + paper Remark + bib entry,
 not chained as a Lean def. Future Hodge-style port `def
 NickellBiasFormula (T λ : ℝ) : ℝ :=...` would close the
 Cat 2 ↔ Cat 3 disconnect. -/
def gap_rem_var_spectral_test_info_era : LedgerEntry := {
  identifier := "rem:var-spectral-test-info-era"
  paperLabel := "rem:var-spectral-test-info-era"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "MIXED FINDING (gap partial patch — honest Monte-Carlo update). Empirical VAR(1) spectral test infrastructure attempts to upgrade the paper's conclusion-line concession ('m=3 in mercantile/info-era is empirical observation, not forced consequence') to a verified test that distinguishes m=3 from m=2/m=4. Script `var_spectral_test_info_era.py`: simulate 3-axis country-panel under paper-posited DGP (n_countries=10, T=75, drift δ=(0.02, 0.10, 0.05) + weak linearised cross-coupling); first-difference, fit VAR(1) pooled OLS, extract empirical Jacobian Â; compute eigenvalues of (Â+Âᵀ)/2; ratio test against 1.5. CANONICAL SEED (20260512): |λ̂|=(0.149, 0.079, 0.041); ratios (1.87, 1.92) POINT > 1.5 ✓; 95% bootstrap CIs [1.26, 3.47] and [1.20, 3.99] STRICT FAILS at n=10. POWER TESTS (single-seed): m=4 DGP correctly REJECTED (ratio_2 = 1.35 < 1.5); m=2 DGP correctly IDENTIFIED. MONTE-CARLO over 30 alternative seeds under true m=3 DGP: POINT pass rate = 8/30 = 27% (Type-II at POINT = 73%); STRICT pass rate = 0/30 = 0% (Type-II at STRICT = 100%). Canonical-seed verdict is a 27th-percentile lucky draw, NOT representative. CONCLUSION: procedure has insufficient power at n=10 to certify m=3 even at POINT level from cross-sectional variation alone; real-data extension to n_countries ≥ 20 is MANDATORY for substantive closure (not just for STRICT). Disclosure: SIMULATED data calibrated to paper posit, NOT real-data."
  decomposability := "3 sub-claims: (a) POINT-level m=3 (both ratios > 1.5 at point estimate); (b) procedure power (correctly rejects m=3 under m=4 DGP); (c) STRICT CI certification (FAILS at n=10, blocked on real-data + larger panel). 1 Lean theorem: paperVARSpectralTest_info_era_m_equals_3_point_verified."
  computability := "ARITHMETIC: numpy VAR(1) pooled OLS + scipy.linalg eigenvalues + bootstrap CI (1000 reps)."
  attackVector := " identified 4 candidates (A action-algebra Endo predicate / B Amari Fisher invariant subspaces — DROPPED as phantom attribution / C info-era 4th-axis re-audit / D conditional reframing / E empirical VAR spectral test). E selected as most-confident empirical deliverable. Phase 1 implementation verified procedure works structurally (power test passes) and matches paper posit at point estimate. Remaining: A+C+D theoretical patch (Endo predicate for K_AI compute-stock + 5-candidate info-era re-audit + Lean ledger entry m_equals_3_info_era) queued for."
  attackHistory := ["--audit-surveyed-5-candidates-A-action-algebra-B-Amari-info-geometry-C-4th-axis...", "-Phase1-var_spectral_test_info_era-py-implemented-n10-T75-point-ratios-187-192...", "-MonteCarlo-30-alternative-seeds-under-true-m3-DGP-POINT-pass-rate-8-30-27pct...", "-power-grid-over-n-and-T-reveals-T-dominance-n10-T75-POINT-27pct-T150-57pct...", "-mean-ratio-diagnostic-reveals-Nickell-1981-bias-as-mechanism-true-asymptotic...", "-first-order-Nickell-bias-correction-implemented-fit_nickell_corrected_var1...", "-honest-NEGATIVE-finding-single-step-simulation-based-bootstrap-bias-correction...", "-inputCategory-Cat3-with-Cat2-dependency-on-Nickell-1981-Kiviet-1995-Cat2-Cat3...", "-REAL-DATA-PWT-11-0-G15-1957-2019-n15-T63-panel-perfect-balanced-945-cells-PI..."]
  obstacleCitation := some "PER REAL-DATA RESULT: PWT 11.0 G15 panel (1957-2019, n=15, T=63) gives r1=2.087, r2=1.544 — both POINT > 1.5 ✓; 95% CI [1.156, 6.701] — STRICT FAILS at n=15 (underpowered, consistent with power grid). 4/5 alternative specs also POINT-verify. Real-data POINT verification on PWT 11.0 closes the empirical infrastructure question — the procedure works on real data on the paper's operating scale. STRICT closure still pending: Maddison Project pre-1900 longitudinal extension OR n>=25 cross-sectional widening. Per + diagnosis Nickell-1981 finite-T bias is the structural weakness; first-order correction recovers 53-60% POINT power on simulated data."
}

/-- paper source: rem:fourth-axes-info-era ( gap theoretical
 patch — A+C+D combination ).

 **inputCategory**: **Cat 3** (paper-
 novel info-era re-audit of `prop:fourth-axes` discharge framework)
 with **Cat 2 dependency** on Topkis 1978/1998 Ch. 2 supermodular-
 complementarity machinery + Kuehn 2015 Thm 5.4 center-manifold
 reduction (both already cited at the prop:fourth-axes proof locus)
 + Sevilla-Epoch 2022 (AI compute scaling). reductionism on the
 PARENT entry (= the framework Remark): Cat 1 → CLEAR-NO; Cat 2 →
 DEPENDENCY exists; the 5 sibling axioms (each = Cat 3 with same
 Topkis Cat 2 disconnect) carry the load-bearing Cat 3 claims.
 Sibling-entry reductionism findings recorded in their respective
 attackHistory under. -/
def gap_rem_fourth_axes_info_era : LedgerEntry := {
  identifier := "rem:fourth-axes-info-era"
  paperLabel := "rem:fourth-axes-info-era"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.phenomenologicalConjecture
  closureDistance := "POSITIVE FINDING (gap theoretical complement to empirical). Info-era re-audit of prop:fourth-axes: the original 5-candidate discharge (Proposition `prop:fourth-axes`) used industrial-era assumptions where some candidates (knowledge as PI-or-civilizational; demographic as quasi-static outside τ) operate on timescales μ ≪ 0.01 yr⁻¹ outside τ ∈ [10, 50] yr. Info-era introduces 5 new candidates whose timescales sit INSIDE τ: (i') K_AI compute / training-stock (μ ≈ 1.0 yr⁻¹, Sevilla-Epoch 2022); (ii') K_data data-stock; (iii') Algorithmic-rule-shaping; (iv') AI-augmented demographic capacity (μ ≈ 0.05-0.15 yr⁻¹ inside τ — breaks original discharge); (v') Soft-power-via-platforms. Each reduces to a joint loading on (PI, MU, NU) via Topkis 1998 Ch. 2 supermodular-complementarity (same operative machinery as the proof of prop:fourth-axes + Kuehn 2015 Thm 5.4 center-manifold reduction). The 5 reductions are CONJECTURAL (not proven strongly); per broken-link discipline, the conditional is propagated to P1-P4 failure modes: (F-AI) K_AI / K_data resolve into distinct spectral cluster on 2025-2045 panel data; (F-Demo) AI-augmented demographic exhibits non-trivial slow mode on τ; (F-Spectral) STRICT bootstrap CI of rem:var-spectral-test-info-era at G20+ panel rejects m=3. Load-bearing falsification step: empirical test of rem:var-spectral-test-info-era at n_countries=20 on real 1950-2025 PI/MU/NU panel data with planned 2027-2028 update window."
  decomposability := "5 conjectural reductions: (i')-(v') info-era 4th-axis candidates → joint loading on existing 3 axes. 3 failure modes: (F-AI), (F-Demo), (F-Spectral) — each propagated to P1-P4 as explicit antecedent per broken-link discipline."
  computability := "STRUCTURAL ARGUMENT (Topkis 1998 supermodular lattice + Kuehn 2015 center-manifold). Empirical falsification via rem:var-spectral-test-info-era."
  attackVector := "Per Candidate A+C+D combination: A action-algebra Endo predicate verbalized in Remark text (5 candidate-specific reductions); C re-audit of prop:fourth-axes discharge under info-era assumptions; D conditional reframing propagated to P1-P4 failure modes. No new Lean typed predicate — the 5 reductions are conjectural pending real-data spectral test ( rem:var-spectral-test-info-era at n>=20). Lean encoding currently as Ledger entry only; substantive IsEndomorphismOfActionTriad typed predicate queued."
  attackHistory := ["--Candidate-A-C-D-combination-info-era-re-audit-of-prop-fourth-axes-with-5-new...", "-Phase2-paper-rem-fourth-axes-info-era-added-after-prop-fourth-axes-with-5...", "-inputCategory-parent-entry-Cat3-with-Cat2-dependency-on-Topkis-1978-1998-Ch2..."]
  obstacleCitation := some "gap STRUCTURAL closure requires (a) the 5 info-era reductions to be proved strongly (currently conjectural via Topkis supermodular argument; substantive bodies would need typed accessors for K_AI, K_data on EconomicSystem structure), AND (b) real-data spectral test of rem:var-spectral-test-info-era to pass STRICT bootstrap CI at n_countries >= 20. Conjectural status acceptable per broken-link discipline because (c) the failure modes are propagated to P1-P4 as explicit antecedents — the conditional closure is honestly drawn."
}

/-- sub-gap (i'): K_AI compute / training-stock endomorphism.
 ** STATUS UPGRADE**: gapOpen → gapClosed. The endomorphism
 conclusion is now a CLOSED Lean theorem (`Types.paper_K_AI_compute_
 isEndomorphism`) composing Cat 1 (`complement_isEndomorphism`
 bridge via positive ⇒ nonzero, Mathlib `ne_of_gt`) + Cat 3
 (`paper_K_AI_compute_isComplement` premise axiom — paper-novel
 structural claim that K_AI is positive-coefficient combination of
 PI/MU/NU). The remaining Cat 3 input is tracked as separate sibling
 sub-gap `gap_predicate_K_AI_compute_isComplement`.

 **inputCategory** (recent rounds): **Cat 1** (Lean composition) consuming
 Cat 3 input. reductionism findings: Cat 1 → CLEAR-NO for the
 isComplement premise; Cat 2 → Topkis 1978/1998 Ch. 2 is conceptual
 underpinning of the complementarity framework but the Lean BRIDGE
 is Cat 1 once the encoding is fixed (positive ⇒ nonzero). 
 refactor closes the Cat 2 ↔ Cat 3 disconnect honestly. -/
def gap_predicate_K_AI_compute_isEndomorphism : LedgerEntry := {
  identifier := "predicate:K_AI_compute_isEndomorphism"
  paperLabel := "rem:fourth-axes-info-era (i')"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "Conjectural endomorphism claim. K_AI compute / training-stock scales ~4.3×/yr (5.7-mo doubling, Sevilla-Epoch 2022 IJCNN), placing μ ≈ 1.0 yr⁻¹ inside τ ∈ [10, 50]. Conjectured to load jointly on (PI, MU, NU) via Topkis 1998 Ch. 2 supermodular-complementarity machinery applied at the locus of prop:fourth-axes; absorbed into cross-coupling matrix A of def:coupled-dynamics rather than constituting an independent 4th axis. Lean: axiom `paper_K_AI_compute_isEndomorphism` over predicate `IsEndomorphismOfActionTriad` (Types.lean)."
  decomposability := "Single endomorphism claim ∃ (λ_PI, λ_MU, λ_NU) all non-zero such that K_AI S = λ_PI · PI + λ_MU · MU + λ_NU · NU."
  computability := "STRUCTURAL ARGUMENT (Topkis machinery). Substantive body queued — would require typed accessor `computeStock : EconomicSystem → ℝ` plus explicit derivation of the three loadings."
  attackVector := " Phase 2 added typed predicate + sibling Ledger entry per anti-pattern #2 (no Fin 5 → Prop bundling). Substantive Topkis-application lemma to be developed in a future round."
  attackHistory := ["-add-component-of-rem-fourth-axes-info-era-K_AI-compute-stock-endomorphism...", "-Cat3-reductionism-review-per--discipline-Round1-Cat1-CLEAR-NO-no-Mathlib...", "-refactor-executed-IsComplementOfActionTriad-def-introduced-Cat3-paper-novel..."]
  obstacleCitation := some "Endomorphism CONCLUSION is gapClosed ( theorem). The remaining gap is the Cat 3 isComplement PREMISE (paper_K_AI_compute_isComplement) — substantive body requires (a) typed `computeStock` accessor on EconomicSystem, (b) explicit Topkis-style verification that K_AI's loadings on (PI, MU, NU) are strictly positive (paper-novel structural claim), (c) empirical confirmation via 2025-2045 panel (F-AI failure mode of rem:fourth-axes-info-era). Tracked separately as `gap_predicate_K_AI_compute_isComplement`."
}

/-- sub-gap (ii'): K_data data-stock endomorphism. STATUS:
 gapOpen → gapClosed (CLOSED via composition; same refactor).

 **inputCategory** (recent rounds): **Cat 1** (Lean composition) consuming
 Cat 3 input `paper_K_data_isComplement`. -/
def gap_predicate_K_data_isEndomorphism : LedgerEntry := {
  identifier := "predicate:K_data_isEndomorphism"
  paperLabel := "rem:fourth-axes-info-era (ii')"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "Conjectural endomorphism claim. K_data data-stock loads on PI (information capital) and NU (platform-network position via data-network effects). Same Topkis 1998 Ch. 2 channel as K_AI. No independent slow mode resolved on τ. Lean: axiom `paper_K_data_isEndomorphism`."
  decomposability := "Single endomorphism claim per IsEndomorphismOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (Topkis machinery). Substantive body queued."
  attackVector := " Phase 2 typed predicate + sibling Ledger entry per anti-pattern #2."
  attackHistory := ["-add-component-of-rem-fourth-axes-info-era-K_data-data-stock-endomorphism-axiom", "-Cat3-reductionism-same-as-K_AI-Cat1-NO-Cat2-PARTIAL-Topkis-1978-1998-Ch2...", "-refactor-CLOSED-via-composition-of-Cat1-bridge-and-Cat3-paper_K_data..."]
  obstacleCitation := some "Endomorphism CONCLUSION is gapClosed. Remaining Cat 3 input tracked as `gap_predicate_K_data_isComplement`."
}

/-- sub-gap (iii'): Algorithmic-rule-shaping endomorphism. STATUS:
 gapClosed via composition. **inputCategory**: Cat 1 consuming Cat 3
 `paper_algorithmic_rule_shaping_isComplement`. -/
def gap_predicate_algorithmic_rule_shaping_isEndomorphism : LedgerEntry := {
  identifier := "predicate:algorithmic_rule_shaping_isEndomorphism"
  paperLabel := "rem:fourth-axes-info-era (iii')"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "Conjectural endomorphism claim. Recommender systems / AI-mediated content moderation / algorithmic standard-setting load on NU via existing rule-export + standards channels of def:capability-evolution. Same micromotive-macrostructure mapping as soft-power-via-platforms reduction. Lean: axiom `paper_algorithmic_rule_shaping_isEndomorphism`."
  decomposability := "Single endomorphism claim per IsEndomorphismOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (Topkis machinery). Substantive body queued."
  attackVector := " Phase 2 typed predicate + sibling Ledger entry per anti-pattern #2."
  attackHistory := ["-add-component-of-rem-fourth-axes-info-era-algorithmic-rule-shaping...", "-Cat3-reductionism-same-as-K_AI-Cat1-NO-Cat2-PARTIAL-Topkis-Cat2-Cat3...", "-refactor-CLOSED-via-composition-of-Cat1-bridge-and-Cat3-paper_algorithmic_rule..."]
  obstacleCitation := some "Endomorphism CONCLUSION is gapClosed. Remaining Cat 3 input tracked as `gap_predicate_algorithmic_rule_shaping_isComplement`."
}

/-- sub-gap (iv'): AI-augmented demographic capacity endomorphism.
 Replaces the original prop:fourth-axes entry (v) discharge under
 info-era reading where μ ≈ 0.05-0.15 yr⁻¹ ENTERS τ (breaks the
 "μ ≪ 0.01 outside τ" industrial-era assumption). STATUS:
 gapClosed via composition. **inputCategory**: Cat 1 consuming Cat 3
 `paper_AI_augmented_demographic_isComplement`. -/
def gap_predicate_AI_augmented_demographic_isEndomorphism : LedgerEntry := {
  identifier := "predicate:AI_augmented_demographic_isEndomorphism"
  paperLabel := "rem:fourth-axes-info-era (iv')"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "Conjectural endomorphism claim. AI-augmented labor productivity has μ ≈ 0.05-0.15 yr⁻¹ INSIDE τ (breaks the prop:fourth-axes original entry (v) 'μ ≪ 0.01 outside τ' discharge). Conjectured to load on PI via existing productivity-accumulation channel of def:capability-evolution; population dynamics and demographic structure remain on slow boundary. Lean: axiom `paper_AI_augmented_demographic_isEndomorphism`."
  decomposability := "Single endomorphism claim per IsEndomorphismOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (Topkis machinery). Substantive body queued."
  attackVector := " Phase 2 typed predicate + sibling Ledger entry per anti-pattern #2. Replaces original prop:fourth-axes (v) discharge under info-era reading."
  attackHistory := ["-add-component-of-rem-fourth-axes-info-era-AI-augmented-demographic...", "-Cat3-reductionism-same-as-K_AI-Cat1-NO-Cat2-PARTIAL-Topkis-Cat2-Cat3...", "-refactor-CLOSED-via-composition-of-Cat1-bridge-and-Cat3-paper_AI_augmented..."]
  obstacleCitation := some "Endomorphism CONCLUSION is gapClosed. Remaining Cat 3 input tracked as `gap_predicate_AI_augmented_demographic_isComplement`."
}

/-- sub-gap (v'): Soft-power-via-platforms endomorphism. STATUS:
 gapClosed via composition. **inputCategory**: Cat 1 consuming Cat 3
 `paper_soft_power_via_platforms_isComplement`. -/
def gap_predicate_soft_power_via_platforms_isEndomorphism : LedgerEntry := {
  identifier := "predicate:soft_power_via_platforms_isEndomorphism"
  paperLabel := "rem:fourth-axes-info-era (v')"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "Conjectural endomorphism claim. TikTok / Hollywood-via-streaming / English-as-LLM-default channels all load on NU via existing media/standards channel; same spectral cluster as NU. Absorbed into existing axis. Lean: axiom `paper_soft_power_via_platforms_isEndomorphism`."
  decomposability := "Single endomorphism claim per IsEndomorphismOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (Topkis machinery). Substantive body queued."
  attackVector := " Phase 2 typed predicate + sibling Ledger entry per anti-pattern #2."
  attackHistory := ["-add-component-of-rem-fourth-axes-info-era-soft-power-via-platforms...", "-Cat3-reductionism-same-as-K_AI-Cat1-NO-Cat2-PARTIAL-Topkis-Cat2-Cat3...", "-refactor-CLOSED-via-composition-of-Cat1-bridge-and-Cat3-paper_soft_power_via..."]
  obstacleCitation := some "Endomorphism CONCLUSION is gapClosed. Remaining Cat 3 input tracked as `gap_predicate_soft_power_via_platforms_isComplement`."
}

/-! ### sibling-entry block: 5 isComplement Cat 3 axioms

Per the split-axiom refactor, each of the 5 endomorphism
conclusions is now CLOSED via composition of (Cat 1 bridge
`complement_isEndomorphism`) + (Cat 3 isComplement premise). The 5
isComplement axioms are the actual remaining Cat 3 paper-novel inputs
— each tracked here as a separate sibling entry per anti-pattern #2
discipline (no bundling). -/

/-- Cat 3 input: K_AI compute-stock isComplement (paper-novel
 structural claim per `rem:fourth-axes-info-era` (i') that K_AI
 decomposes as a strict-positive-coefficient combination of the
 three axis projections; closes the endomorphism conclusion via
 `complement_isEndomorphism` Cat 1 bridge). -/
def gap_predicate_K_AI_compute_isComplement : LedgerEntry := {
  identifier := "predicate:K_AI_compute_isComplement"
  paperLabel := "rem:fourth-axes-info-era (i') premise"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Cat 3 paper-novel premise. Conjectural per Topkis 1978/1998 Ch. 2 supermodular framework conceptual underpinning. Lean: axiom `paper_K_AI_compute_isComplement` over predicate `IsComplementOfActionTriad`. Substantive body queued: typed `computeStock : EconomicSystem → ℝ` accessor + explicit verification that loadings on (PI, MU, NU) are strictly positive."
  decomposability := "Single existential claim ∃ (λ_PI > 0, λ_MU > 0, λ_NU > 0) such that K_AI S = λ_PI · PI + λ_MU · MU + λ_NU · NU."
  computability := "STRUCTURAL ARGUMENT (paper-novel). Substantive body queued."
  attackVector := " introduced as the explicit Cat 3 paper-novel premise for the (now-closed) endomorphism conclusion. Awaits substantive body via typed accessor + Topkis-conceptual verification + 2025-2045 empirical (F-AI failure mode)."
  attackHistory := ["-introduce-as-Cat3-input-axiom-replacing-old-bundled-paper_K_AI_compute..."]
  obstacleCitation := some "Substantive body requires typed `computeStock` accessor on EconomicSystem + paper-novel structural verification of strict positivity + 2025-2045 empirical confirmation per F-AI failure mode."
}

/-- Cat 3 input: K_data isComplement. Same pattern as K_AI. -/
def gap_predicate_K_data_isComplement : LedgerEntry := {
  identifier := "predicate:K_data_isComplement"
  paperLabel := "rem:fourth-axes-info-era (ii') premise"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Cat 3 paper-novel premise (positive-coefficient form). Lean: axiom `paper_K_data_isComplement`."
  decomposability := "Single existential claim per IsComplementOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (paper-novel)."
  attackVector := " introduced as Cat 3 input; closure of endomorphism conclusion via Cat 1 bridge composition."
  attackHistory := ["-introduce-as-Cat3-input-axiom-companion-to-now-closed-K_data-endomorphism..."]
  obstacleCitation := some "Substantive body requires typed `dataStock` accessor + structural verification + empirical confirmation."
}

/-- Cat 3 input: algorithmic-rule-shaping isComplement. -/
def gap_predicate_algorithmic_rule_shaping_isComplement : LedgerEntry := {
  identifier := "predicate:algorithmic_rule_shaping_isComplement"
  paperLabel := "rem:fourth-axes-info-era (iii') premise"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Cat 3 paper-novel premise (positive-coefficient form). Lean: axiom `paper_algorithmic_rule_shaping_isComplement`."
  decomposability := "Single existential claim per IsComplementOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (paper-novel)."
  attackVector := " introduced as Cat 3 input."
  attackHistory := ["-introduce-as-Cat3-input-axiom-companion-to-now-closed-algorithmic-rule-shaping..."]
  obstacleCitation := some "Substantive body requires typed accessor for algorithmic-rule channel + structural verification + empirical confirmation."
}

/-- Cat 3 input: AI-augmented demographic isComplement. -/
def gap_predicate_AI_augmented_demographic_isComplement : LedgerEntry := {
  identifier := "predicate:AI_augmented_demographic_isComplement"
  paperLabel := "rem:fourth-axes-info-era (iv') premise"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Cat 3 paper-novel premise (positive-coefficient form). Replaces original prop:fourth-axes (v) discharge under info-era reading. Lean: axiom `paper_AI_augmented_demographic_isComplement`."
  decomposability := "Single existential claim per IsComplementOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (paper-novel)."
  attackVector := " introduced as Cat 3 input."
  attackHistory := ["-introduce-as-Cat3-input-axiom-companion-to-now-closed-AI-augmented-demographic..."]
  obstacleCitation := some "Substantive body requires typed `aiAugmentedProductivity` accessor + structural verification + 2025-2045 empirical confirmation per F-Demo failure mode."
}

/-! ### Cat 2 Hodge-style ports — close -flagged Cat 2 ↔ Cat 3 disconnects -/

/-- Cat 2 port: Inverse-Gaussian density (Schrödinger 1915 / Tweedie
 1957 closed form). Lean: `Types.IGDensity`. Closes the -flagged
 Cat 2 ↔ Cat 3 disconnect for `gap_rem_ig_first_passage_mle` (the
 IG density is now a Lean def in import scope, not just a docstring
 citation). -/
def gap_def_IGDensity : LedgerEntry := {
  identifier := "def:IGDensity"
  paperLabel := "rem:ig-first-passage-mle (IG density port, )"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED via Hodge-style def (no `sorry`). Schrödinger 1915 (Phys. Z. 16:289-295) closed form: f(t; μ, λ) = √(λ / (2π t³)) · exp(−λ(t−μ)² / (2 μ² t)). Direct encoding via Mathlib `Real.sqrt`, `Real.exp`, `Real.pi`. Tweedie 1957 (Annals Math. Stat. 28(2):362-377) named the distribution + tabulated MLE properties."
  decomposability := "Single closed-form def."
  computability := "ARITHMETIC via Mathlib special functions."
  attackVector := " Hodge-style port executed; closes Cat 2 ↔ Cat 3 disconnect for IG density."
  attackHistory := ["-Hodge-style-port-of-IG-density-Schrodinger-1915-Tweedie-1957-closed-form-via..."]
  obstacleCitation := none
}

/-- Cat 2 opaque-axiom port: Inverse-Gaussian CDF (Borodin-Salminen
 2002 closed form via standard normal CDF). Lean: `Types.IGCDF`. -/
def gap_axiom_IGCDF : LedgerEntry := {
  identifier := "axiom:IGCDF"
  paperLabel := "rem:ig-first-passage-mle (IG CDF port, )"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat2External
  closureDistance := "Cat 2 opaque-axiom port. Borodin-Salminen 2002 (handbook Ch. II.1) closed form: F(t; μ, λ) = Φ(√(λ/t)(t/μ−1)) + exp(2λ/μ)·Φ(−√(λ/t)(t/μ+1)) where Φ is the standard normal CDF. Encoded as opaque axiom because Mathlib's standard normal CDF is not currently in the import scope; the closed form is in the paper Remark + script. Promotion to Hodge-style def queued pending import of Mathlib normal CDF (or kernel-pure constructive port via `Mathlib.MeasureTheory.Distribution.Gaussian`)."
  decomposability := "Single closed-form formula (deferred to opaque axiom)."
  computability := "ARITHMETIC pending Mathlib normal CDF in import scope."
  attackVector := " opaque-axiom port executed with full citation; promotion to def queued."
  attackHistory := ["-opaque-axiom-port-of-IG-CDF-Borodin-Salminen-2002-Ch-II-1-closed-form-pending..."]
  obstacleCitation := some "Mathlib `Real.gaussianCdf` or equivalent not in current import scope. Promotion to Hodge-style def requires either: (a) import Mathlib.Probability.Distributions.Gaussian (if available); or (b) kernel-pure constructive port of Φ via the error function."
}

/-- theory optimization: cardinal-calibration identification via
 cross-coupling. Composes paper's `thm:exponent-derivation` (γ_k =
 δ_k⁻¹|∂W/∂x_k|r_k) with `def:coupled-dynamics` (α_km = L_k · ∂W/∂x_m)
 to derive |∂W/∂x_m| = |α_km|/L_k, identifying cardinal γ structurally
 from observable primitives. Resolves gap at theory level: the
 "illustrative cardinal" status of (0.40, 0.21, 0.39) is replaced
 by a falsifiable structural prediction testable against real-data
 α estimation ( task).

 Lean: `Types.paper_cardinal_identification_via_cross_coupling` Cat 3
 axiom + `Types.paperR35_identification_framework_resolves_Hole_1_at_
 theory_level` Cat 1 closure theorem. -/
def gap_axiom_R35_cardinal_identification : LedgerEntry := {
  identifier := "axiom:-cardinal-identification-via-cross-coupling"
  paperLabel := "prop:identification-chain (formal proposition in §sec:cardinal-vindication; composes thm:exponent-derivation + def:coupled-dynamics to derive γ_m = δ_m⁻¹·|α_km|/L_k·r_m)"
  status := GapStatus.gapPartial
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "POSITIVE THEORY OPTIMIZATION. Composes existing paper relations: (1) thm:exponent-derivation γ_k = w_k = δ_k⁻¹|∂W/∂x_k|r_k; (2) def:coupled-dynamics α_km = L_k · ∂W/∂x_m. Combining: |∂W/∂x_m| = |α_km|/L_k for any k≠m, so γ_m = δ_m⁻¹·|α_km|/L_k·r_m is IDENTIFIED from observable cross-coupling α_km + decay δ_m + leakage L_k + Tullock r_m. Resolves gap (Tullock-vs-calibration identification gap) at theory level — the cardinal calibration is no longer 'illustrative parameterization' but a falsifiable structural prediction testable against real-data α estimation. caveat: at n=6 found ||α||=0.0018 negligible; real-data extension to n>20 needed for empirical verification."
  decomposability := "Single identification chain (composition of 2 existing paper relations into a structural prediction)."
  computability := "ARITHMETIC given α_km estimation (VAR pooled OLS) + δ + L + r_m primitives. task: estimate α from real-data G20 panel."
  attackVector := " theoretical optimization paper-side; Lean encodes the identification axiom + closure theorem. Empirical falsifiability verification via real-data α estimation."
  attackHistory := ["-theoretical-optimization-cardinal-calibration-IDENTIFIED-via-cross-coupling...", "-EMPIRICAL-VINDICATION-of-survival-weight-prediction-w-paper-headline..."]
  obstacleCitation := some "Empirical verification requires real-data G20+ VAR estimation of cross-coupling α_km. found ||α||=0.0018 at n=6 (negligible) — either insufficient power at small T OR cross-coupling at hegemonic scale is genuinely small (would require alternative identification source). Closure to gapClosed pending result."
}

/-- Cat 2 Hodge-style port: Nickell-1981 first-order bias formula
 for dynamic-panel-with-fixed-effects pooled-OLS estimator
 (Econometrica 49(6):1417-1426, Equation 18). Lean:
 `Types.NickellBiasFormula`. Closes the -flagged Cat 2 ↔ Cat 3
 disconnect for `paperVARSpectralTest_R21_nickell_correction_boosts_power`. -/
def gap_def_NickellBiasFormula : LedgerEntry := {
  identifier := "def:NickellBiasFormula"
  paperLabel := "rem:var-spectral-test-info-era (Nickell bias formula port, )"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat2External
  closureDistance := "CLOSED via Hodge-style def (no `sorry`). Nickell 1981 (Econometrica 49(6):1417-1426, Eq. 18) bias formula: bias(λ; T) = (2 − λ) / (T − 1). Direct closed-form encoding."
  decomposability := "Single closed-form def."
  computability := "ARITHMETIC."
  attackVector := " Hodge-style port executed; closes Cat 2 ↔ Cat 3 disconnect for Nickell bias formula."
  attackHistory := ["-Hodge-style-port-of-Nickell-1981-bias-formula-Eq-18-direct-closed-form..."]
  obstacleCitation := none
}

/-- Cat 3 input: soft-power-via-platforms isComplement. -/
def gap_predicate_soft_power_via_platforms_isComplement : LedgerEntry := {
  identifier := "predicate:soft_power_via_platforms_isComplement"
  paperLabel := "rem:fourth-axes-info-era (v') premise"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Cat 3 paper-novel premise (positive-coefficient form). Lean: axiom `paper_soft_power_via_platforms_isComplement`."
  decomposability := "Single existential claim per IsComplementOfActionTriad."
  computability := "STRUCTURAL ARGUMENT (paper-novel)."
  attackVector := " introduced as Cat 3 input."
  attackHistory := ["-introduce-as-Cat3-input-axiom-companion-to-now-closed-soft-power-via-platforms..."]
  obstacleCitation := some "Substantive body requires typed accessor for platform-channel NU loading + structural verification + empirical confirmation."
}

/-- Component predicate (a) of `IsLeakageAxisIndependent` — uniform
 discrimination loading r_ℓ across ℓ. added as a separate
 Ledger entry to make the new opaque axiom predicate independently
 auditable. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_uniform_discrimination_loading : LedgerEntry := {
  identifier := "predicate:uniform-discrimination-loading"
  paperLabel := "thm:exponent-derivation Step 2 sufficient condition (a)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "predicate now has SUBSTANTIVE BODY (was opaque axiom in ). `def IsUniformDiscriminationLoading S := ∀ k k', discriminationParameter S k = discriminationParameter S k'` (Types.lean) — over the new opaque accessor `discriminationParameter : EconomicSystem → CapabilityAxis → ℝ` (the per-axis Tullock `r_k`, with companion `discriminationParameter_pos`). Paper-side sufficient condition (a) for leakage-axis-independence: `r_ℓ` approximately uniform across `ℓ`. The Lean body uses EXACT `=` (idealized); paper proof line 673 says \"approximately uniform\" — under calibration r ∈ [0.21, 0.40] holds to within a factor of 2 (empirical caveat, not encoded in the type). Status remains gapBlocked: the predicate semantic is now visible/unfoldable, but the `discriminationParameter` accessor is itself an opaque axiom — the gap is RELOCATED from the predicate to the accessor, not closed (the accessor awaits the `EconomicSystem` constructor)."
  decomposability := "Predicate body DONE in (`∀ k k', discriminationParameter S k = discriminationParameter S k'`); remaining = `discriminationParameter` accessor needs the `EconomicSystem` constructor (deferred to a later round / structure refactor)."
  computability := "Predicate computable given the accessor; accessor itself uncomputed (opaque axiom)."
  attackVector := "Predicate body Lean-defined over opaque accessor. Lean source: `Types.IsUniformDiscriminationLoading` (now a `def`), `Types.discriminationParameter` + `Types.discriminationParameter_pos` (opaque axioms)."
  attackHistory := ["-add--component-predicate-of-IsLeakageAxisIndependent-disjunction-substantive...", "-patch---audit-predicate-given-substantive-body-over-new-opaque-accessor..."]
  obstacleCitation := some "Later round / `EconomicSystem` structure refactor would make `discriminationParameter` a projection — `discriminationParameter` itself HAS paper values (`r_PI/MU/NU = 1.44/1.11/1.13` single-representative, or the `0.40/0.21/0.39` headline calibration). BUT the structure refactor is NOT a genuine gap-closer for the canonical INSTANCES: completing `canonicalPost1815System` requires ALL fields, including `fungibilityMatrix` / `leakageFactor` / `slowEnvelopeAmplitude` which the paper never numerically pins (`φ_{k,ℓ}` is given only structurally). The TRUE terminal blocker is the paper's calibration scope. Treat the refactor as axiom-hygiene only."
}

/-- Component predicate (b) of `IsLeakageAxisIndependent` — special-rank-1
 fungibility form φ_{k,ℓ} = u · β_ℓ with `u` axis-independent. :
 added as a separate Ledger entry to make the new opaque axiom
 predicate independently auditable ( finding
 Q3). The "Special" prefix is load-bearing — paper explicitly rejects
 the more general rank-1 `α_k β_ℓ` form unless `α_k ≡ const`. -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_special_rank1_fungibility_form : LedgerEntry := {
  identifier := "predicate:special-rank1-fungibility-form"
  paperLabel := "thm:exponent-derivation Step 2 sufficient condition (b)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "predicate now has SUBSTANTIVE BODY (was opaque axiom in ). `def IsSpecialRank1FungibilityForm S := ∃ (u : ℝ) (β : CapabilityAxis → ℝ), ∀ k ℓ, fungibilityMatrix S k ℓ = u * β ℓ` (Types.lean) — over the new opaque accessor `fungibilityMatrix : EconomicSystem → CapabilityAxis → CapabilityAxis → ℝ`. Paper-side sufficient condition (b) for leakage-axis-independence: fungibility matrix `φ_{k,ℓ}` admits the special-rank-1 decomposition `φ_{k,ℓ} = u · β_ℓ` with `u` axis-independent. The body `u * β ℓ` has NO `k`-dependent factor, so it automatically rules out the more-general rank-1 form `α_k β_ℓ` (paper line 651 rejects that since it leaves `L_k = α_k · const` residually axis-dependent) — no extra conjunct needed for that. CORRECTION: the row-sum-of-`β` conjunct is OMITTED — paper proof line 673 derives axis-independence of `L_k = u/R · ∑_ℓ β_ℓ r_ℓ` from rank-1 + axis-independent `u` ALONE; the paper's parenthetical \"β_ℓ summing to a fixed constant\" is a rescaling-gauge convention (you can always achieve ∑β = 1 by rescaling u↔β) with NO logical force, not a substantive constraint. The earlier -B.4 note claiming the row-sum conjunct was needed for axis-independence was MISTAKEN on the math. Status remains gapBlocked: the predicate semantic is now visible, but `fungibilityMatrix` is an opaque axiom — gap RELOCATED to the accessor, not closed."
  decomposability := "Predicate body DONE in (`∃ u β, ∀ k ℓ, fungibilityMatrix S k ℓ = u * β ℓ`); remaining = `fungibilityMatrix` accessor needs the `EconomicSystem` constructor (deferred to a later round / structure refactor)."
  computability := "Predicate computable given the accessor; accessor itself uncomputed (opaque axiom)."
  attackVector := "Predicate body Lean-defined over opaque accessor. Lean source: `Types.IsSpecialRank1FungibilityForm` (now a `def`), `Types.fungibilityMatrix` (opaque axiom)."
  attackHistory := ["-add--component-predicate-of-IsLeakageAxisIndependent-disjunction-substantive...", "-patch---audit-predicate-given-substantive-body-over-new-opaque-accessor..."]
  obstacleCitation := some "Later round / `EconomicSystem` structure refactor would make `fungibilityMatrix` a projection — BUT the structure refactor is NOT a genuine gap-closer here: the paper gives `φ_{k,ℓ}` only structurally (`φ_{kk}=1`, form `φ_{k,ℓ}=u·β_ℓ`), never numerically, so the canonical-instance literal `canonicalPost1815System.fungibilityMatrix` cannot be completed honestly. The TRUE terminal blocker is the paper's calibration scope, not Lean engineering. Treat the refactor as axiom-hygiene only."
}

/-- hidden-hypothesis disclosure → substantive body:
 small-coupling regime `‖D⁻¹A‖ < 1` required by paper Step 1 of
 `thm:exponent-derivation` (paper line 667 + `rem:slow-envelope`
 line 680). Pre- monolithic `paper_thm_exponent_derivation_holds`
 axiom HID this antecedent; surfaced it; gives it a
 substantive body. -/
-- inputCat: Cat 1


def gap_predicate_small_coupling_regime : LedgerEntry := {
  identifier := "predicate:small-coupling-regime"
  paperLabel := "thm:exponent-derivation Step 1 + rem:slow-envelope"
  status := GapStatus.gapClosed
  inputCategory := InputCategory.cat1Mathlib
  closureDistance := "predicate has SUBSTANTIVE BODY (was opaque axiom in ). `def SmallCouplingRegime S := crossCouplingOpNormInf S < 1` (Types.lean), where `noncomputable def crossCouplingOpNormInf S := max(α_PI_NU/δ_PI, max((α_MU_PI + α_MU_NU)/δ_MU, α_NU_PI/δ_NU))` is the ∞-operator norm `‖D⁻¹A‖_∞ = max_k (1/δ_k · ∑_{m≠k} |α_km|)` computed directly from the sparse `Jacobian3` (rows ordered (PI, MU, NU) per paper's Jacobian convention line 1240; `α_PI_MU = α_NU_MU = 0` per `def:coupled-dynamics`; `CrossCouplings.nonneg_*` proofs give `|α| = α`). NO new opaque axioms — defined entirely over the pre-existing `jacobianOf` + `Jacobian3` structure (same posture as `decayRate` in : NOT a new opaque axiom — structurally derived). FAITHFULNESS: the paper leaves the norm unspecified (line 667 just says `‖D⁻¹A‖ < 1`); any sub-multiplicative matrix norm `< 1` implies Neumann-series convergence; the ∞-operator norm is sub-multiplicative and chosen for direct computability from the sparse Jacobian; paper line 680's `‖A‖ ≪ min_k δ_k` is a SUFFICIENT condition for `‖D⁻¹A‖_∞ < 1` (each row sum `(∑_{m≠k} α_km)/δ_k ≤ ‖A‖_∞/δ_min < 1`). Empirical note: under post-1815 industrial calibration `δ_min ≈ 0.02` and `‖A‖_∞ ≈ 0.005-0.01` so `‖D⁻¹A‖_∞ ≈ 0.25-0.50 < 1` holds with margin. Status `gapClosed`: the predicate is now substantively defined and computable-modulo-`jacobianOf`; the only residual dependence is on `jacobianOf` (opaque but PRE-EXISTING, Ledgered separately as the `EconomicSystem`/`fderiv` carrier gap — NOT a new gap introduced by this entry)."
  decomposability := "Body DONE in : `crossCouplingOpNormInf S < 1`, max of the 3 sparse row-1-sums of `D⁻¹A`, over `(jacobianOf S).cross` / `.decay`. No remaining sub-claims at this level (carrier-typing for `jacobianOf` is a separate Ledger concern)."
  computability := "Computable-modulo-`jacobianOf` (which is the pre-existing opaque carrier accessor). `crossCouplingOpNormInf` is a `noncomputable def`; `SmallCouplingRegime` a plain `def : Prop`."
  attackVector := "CLOSED in Lean via substantive `def` over the sparse `Jacobian3` ∞-operator norm. Lean source: `Types.SmallCouplingRegime` (now a `def`), `Types.crossCouplingOpNormInf` (noncomputable def over `jacobianOf`)."
  attackHistory := ["-add---CRITICAL-finding-paper-Step-1-line-667-requires-Neumann-convergence...", "-patch---audit-predicate-given-substantive-body-crossCouplingOpNormInf-less..."]
  obstacleCitation := none
}

/-- intermediate predicate: per-axis slow-envelope amplitude
 `ρ_k = (1/δ_k) · |L_k · ∂W/∂x_k| · (1 + O(...))` (paper Step 1
 closed form, `eq:slow-mode-amplitude` line 654). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_slow_envelope_amplitude_formula : LedgerEntry := {
  identifier := "predicate:slow-envelope-amplitude-formula"
  paperLabel := "thm:exponent-derivation Step 1 (eq:slow-mode-amplitude)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "predicate now has SUBSTANTIVE BODY (was opaque axiom in ). `def HasSlowEnvelopeAmplitudeFormula S k := slowEnvelopeAmplitude S k = (1 / decayRate S k) * |leakageFactor S k * rentLoading S k|` (Types.lean) — the LEADING-ORDER form. Paper eq:slow-mode-amplitude line 654 has `ρ_k = (1/δ_k)|L_k ∂W/∂x_k|(1 + O(‖A‖²/δ_min²))`; the `(1 + O(...))` correction is the IDEALIZATION, dropped — but the Step-1 sub-axiom `paper_thm_exponent_step1_slow_envelope_amplitude` carries a `SmallCouplingRegime` antecedent under which `‖D⁻¹A‖ < 1` so the remainder is small (the leading-order `=` is the regime-restricted exact form). Accessors: `decayRate` is a `noncomputable def` over `(jacobianOf S).decay : DecayRates` (NOT a new opaque axiom — δ_k is structurally present, with positivity `decayRate_pos` a theorem from `DecayRates.pos_*`); `rentLoading` (signed ∂W/∂x_k), `leakageFactor` (any-sign L_k), `slowEnvelopeAmplitude` (ρ_k, with parity axiom `slowEnvelopeAmplitude_nonneg`) are 3 new opaque accessors. Status remains gapBlocked: the predicate body is now visible/unfoldable, but the 3 new accessors are themselves opaque axioms — gap RELOCATED to the accessors, not closed (accessors await the `EconomicSystem` constructor)."
  decomposability := "Predicate body DONE in (`slowEnvelopeAmplitude S k = (1/decayRate S k) * |leakageFactor S k * rentLoading S k|`, leading-order); remaining = `rentLoading` / `leakageFactor` / `slowEnvelopeAmplitude` accessors need the `EconomicSystem` constructor (`decayRate` is already a `def` over `jacobianOf`)."
  computability := "Predicate computable given the accessors; `decayRate` def over opaque `jacobianOf`; 3 new accessors uncomputed (opaque axioms)."
  attackVector := "Predicate body Lean-defined over accessors. Lean source: `Types.HasSlowEnvelopeAmplitudeFormula` (now a `def`), `Types.decayRate` (`noncomputable def`) + `decayRate_pos` (theorem), `Types.rentLoading` / `leakageFactor` / `slowEnvelopeAmplitude` + `slowEnvelopeAmplitude_nonneg` (opaque axioms)."
  attackHistory := ["-add--intermediate-predicate-for-Step-1-conclusion-paper-eq-slow-mode-amplitude...", "-patch---audit-predicate-given-leading-order-substantive-body-decayRate-as..."]
  obstacleCitation := some "Later round / `EconomicSystem` structure refactor would make `rentLoading` / `leakageFactor` / `slowEnvelopeAmplitude` projections — BUT NOT a genuine gap-closer: `rentLoading` has paper values (`∂W/∂x_PI/NU/MU = 0.30/0.15/0.10`) but `leakageFactor` `L_k = (1/R)∑φ_{k,ℓ}r_ℓ` depends on the never-numerically-pinned `φ_{k,ℓ}`, and `slowEnvelopeAmplitude` `ρ_k = (1/δ_k)|L_k ∂W/∂x_k|` depends on `L_k` — so the canonical-instance literals can't be completed honestly for `L`/`ρ`. The TRUE terminal blocker is the paper's calibration scope. Treat the refactor as axiom-hygiene only. (`decayRate` is already structurally defined via `jacobianOf`.)"
}

/-- intermediate predicate: per-axis survival weight `w_k`
 admits the Step-2 boxed formula `w_k = δ_k⁻¹ · |∂W/∂x_k| · r_k`
 (paper Step 2 line 671). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_survival_weight_boxed_formula : LedgerEntry := {
  identifier := "predicate:survival-weight-boxed-formula"
  paperLabel := "thm:exponent-derivation Step 2 (boxed w_k formula)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "predicate now has SUBSTANTIVE BODY (was opaque axiom in ). `def HasSurvivalWeightBoxedFormula S k := SurvivalWeight S k = (1 / decayRate S k) * |rentLoading S k| * discriminationParameter S k` (Types.lean) — matches paper Step 2 line 671 `w_k = δ_k⁻¹|∂W/∂x_k|r_k`. NOTE: the boxed form DROPS the leakage factor `L_k` (it is axis-independent under the `IsLeakageAxisIndependent` disjunction and cancels under simplex normalization — paper line 671-673); so the body is NOT `SurvivalWeight = discriminationParameter · slowEnvelopeAmplitude` verbatim (that would retain `L_k`) — it is the independent leading-order boxed form. Accessors: `decayRate` (noncomputable def over `jacobianOf`), `rentLoading` (new opaque, signed ∂W/∂x_k), `discriminationParameter`; `SurvivalWeight` is the pre-existing accessor (with new parity axiom `SurvivalWeight_nonneg`). Approximation level (unchanged from ): branch (a) uniform-r is APPROXIMATE — paper line 673, factor-2 under r ∈ [0.21, 0.40]; branch (b) special-rank-1 is EXACT. Status remains gapBlocked: predicate body visible, but `rentLoading` is opaque — gap RELOCATED to the accessor."
  decomposability := "Predicate body DONE in (`SurvivalWeight S k = (1/decayRate S k) * |rentLoading S k| * discriminationParameter S k`); remaining = `rentLoading` accessor needs the `EconomicSystem` constructor (`decayRate` is a `def` over `jacobianOf`; `discriminationParameter` is the opaque accessor; `SurvivalWeight` is pre-existing)."
  computability := "Predicate computable given the accessors; `rentLoading` + `discriminationParameter` + `SurvivalWeight` uncomputed (opaque axioms); `decayRate` def over opaque `jacobianOf`."
  attackVector := "Predicate body Lean-defined over accessors. Lean source: `Types.HasSurvivalWeightBoxedFormula` (now a `def`), `Types.SurvivalWeight` + `SurvivalWeight_nonneg`, `Types.decayRate` (noncomputable def), `Types.rentLoading` (opaque axiom), `Types.discriminationParameter`."
  attackHistory := ["-add--intermediate-predicate-for-Step-2-boxed-w_k-formula-paper-line-671...", "-patch---audit-predicate-given-substantive-body-SurvivalWeight-equals-1-over..."]
  obstacleCitation := some "Later round / `EconomicSystem` structure refactor would make `rentLoading` a projection — `rentLoading` itself HAS paper values (`∂W/∂x_PI/NU/MU = 0.30/0.15/0.10`). BUT NOT a genuine gap-closer for the canonical INSTANCES: completing `canonicalPost1815System` also requires `SurvivalWeight` / `fungibilityMatrix` / `leakageFactor` / `slowEnvelopeAmplitude` / absolute-capability values that the paper never gives. The TRUE terminal blocker is the paper's calibration scope. Treat the refactor as axiom-hygiene only. (`decayRate` already structurally defined via `jacobianOf`; `discriminationParameter` is the opaque accessor with paper values; `SurvivalWeight` is the pre-existing accessor.)"
}

/-- component (c): the cardinal residual on exponent `c` is located
 in state-dependent `δ_NU(NU)` network hysteresis (paper
 cor:exponent-sensitivity line 693). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_residual_c_located_in_delta_NU_hysteresis : LedgerEntry := {
  identifier := "predicate:residual-c-located-in-delta-NU-hysteresis"
  paperLabel := "cor:exponent-sensitivity residual (c)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side residual-location claim (c): the cardinal residual on exponent `c` (posited ≈0.13 vs empirical ≈0.39) is located in state-dependent `δ_NU(NU)` network-position incumbency hysteresis — paper line 693: lowering `δ_NU` from headline `0.05` to ≈`0.014` raises predicted `c` from `0.13` to ≈`0.35` (closing ≈60% of the gap); joint `(δ_NU, |∂W/∂x_NU|)` adjustment closes the rest, yielding `c = 0.39`. Currently `axiom LocatedInDeltaNUHysteresis : CobbDouglasExponents → CobbDouglasExponents → EconomicSystem → Prop` (Types.lean) — no substantive body. Cross-references the British-case hysteresis evidence (§sec:exp-britain, citing eichengreen2011 / schenk2010)."
  decomposability := "Substantive body would tie the c-residual magnitude to a typed `δ_NU : EconomicSystem → ℝ` accessor threshold (e.g., `c_residual S = predicted_c(δ_NU S) - empirical_c` with `predicted_c` monotone-decreasing in `δ_NU`); requires typing `δ_NU` accessor on `EconomicSystem`."
  computability := "Substantive once `δ_NU` accessor typed; paper-evidenced empirical claim."
  attackVector := "OPEN: typed body queued accessor batch. Lean source: `Types.LocatedInDeltaNUHysteresis` opaque axiom."
  attackHistory := ["-add--component-predicate-of-ResidualsLocatedInMechanisms-conjunction-paper..."]
  obstacleCitation := some "(queued): type `δ_NU : EconomicSystem → ℝ` accessor on `EconomicSystem`, then replace `axiom LocatedInDeltaNUHysteresis` with a `def` tying the c-residual to a `δ_NU` threshold."
}

/-- component (b): the cardinal residual on exponent `b` is located
 in era-varying `|∂W/∂x_MU|` rent-extraction loading (paper
 cor:exponent-sensitivity line 694). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_residual_b_located_in_rent_load_MU : LedgerEntry := {
  identifier := "predicate:residual-b-located-in-rent-load-MU"
  paperLabel := "cor:exponent-sensitivity residual (b)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side residual-location claim (b): the cardinal residual on exponent `b` (posited ≈0.04 vs empirical ≈0.21) is located in era-varying `|∂W/∂x_MU|` rent-extraction loading — paper line 694: the headline `|∂W/∂x_MU| = 0.10` is a stressed-hegemon estimate (the b-relevant cases include Ottoman late-imperial fiscal stress + Qing post-Opium-War mobilization burdens); peacetime `|∂W/∂x_MU|` would lower the prediction further, indicating an unmodeled rent-loading variation parallel to the a-residual. Paper rules out the calibration-set-artefact reading (4-Western subset differs only +0.01 on b). Currently `axiom LocatedInEraVaryingRentLoadMU :... → Prop` (Types.lean) — no substantive body."
  decomposability := "Substantive body would tie the b-residual magnitude to a typed `∂W/∂x_MU : EconomicSystem → ℝ` accessor (era-indexed); requires typing `∂W/∂x_MU` accessor on `EconomicSystem`."
  computability := "Substantive once `∂W/∂x_MU` accessor typed; paper-evidenced empirical claim."
  attackVector := "OPEN: typed body queued accessor batch. Lean source: `Types.LocatedInEraVaryingRentLoadMU` opaque axiom."
  attackHistory := ["-add--component-predicate-of-ResidualsLocatedInMechanisms-conjunction-paper..."]
  obstacleCitation := some "(queued): type `partialW_MU : EconomicSystem → ℝ` (era-indexed) accessor on `EconomicSystem`, then replace `axiom LocatedInEraVaryingRentLoadMU` with a `def`."
}

/-- component (a): the cardinal residual on exponent `a` is located
 in era-varying `|∂W/∂x_PI|` rent-extraction loading (paper
 cor:exponent-sensitivity line 695). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_residual_a_located_in_rent_load_PI : LedgerEntry := {
  identifier := "predicate:residual-a-located-in-rent-load-PI"
  paperLabel := "cor:exponent-sensitivity residual (a)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side residual-location claim (a): the cardinal residual on exponent `a` (posited ≈0.83 vs empirical ≈0.40) is located in era-varying productive-axis `|∂W/∂x_PI|` rent-extraction loading — paper line 695: the headline `|∂W/∂x_PI| = 0.30` is the post-1815 industrial-era anchor; in the late-industrial / information-era regime the productive-axis loading is empirically lower (a larger share of headline GDP arrives via service-sector and rent-currency channels not loading the `Π`-decay term), reducing predicted `a` in the same direction as the 1.08× over-prediction. Primary-source quantification across eras is the empirical extension thm:exponent-derivation leaves to follow-on work. Currently `axiom LocatedInEraVaryingRentLoadPI :... → Prop` (Types.lean) — no substantive body."
  decomposability := "Substantive body would tie the a-residual magnitude to a typed `∂W/∂x_PI : EconomicSystem → ℝ` accessor (era-indexed); requires typing `∂W/∂x_PI` accessor on `EconomicSystem`."
  computability := "Substantive once `∂W/∂x_PI` accessor typed; paper-evidenced empirical claim."
  attackVector := "OPEN: typed body queued accessor batch. Lean source: `Types.LocatedInEraVaryingRentLoadPI` opaque axiom."
  attackHistory := ["-add--component-predicate-of-ResidualsLocatedInMechanisms-conjunction-paper..."]
  obstacleCitation := some "(queued): type `partialW_PI : EconomicSystem → ℝ` (era-indexed) accessor on `EconomicSystem`, then replace `axiom LocatedInEraVaryingRentLoadPI` with a `def`."
}

/-- part-(a) predicate: the regular-value set of `Φ = (PI, MU, NU)`
 is open dense in `ℝ_+³` (paper prop:axis-independence part (a), Sard
 1942 + IFT). Strengthened headline claim, strictly stronger than the
 part-(b) pairwise witnesses. -/
-- inputCat: Cat 2
-- auditVerdict: CLEAN (10-pattern hostile audit)


def gap_predicate_sard_regular_value_set_open_dense : LedgerEntry := {
  identifier := "predicate:sard-regular-value-set-open-dense"
  paperLabel := "prop:axis-independence part (a) (Sard 1942 + IFT)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat2External
  closureDistance := "Composite predicate decomposed per §3.4 into 3 typed atomic sub-axioms (see entries below). Paper claim: the regular-value set of `Φ = (PI, MU, NU) : ℝ_+³` is open and dense in ℝ_+³ (Sard 1942 + IFT). Strictly stronger than the part-(b) pairwise witnesses."
  decomposability := "Decomposed into 3 sub-atoms: gap_axiom_sard_critical_value_set_measure_zero (Cat 2 Sard 1942) + gap_predicate_phi_is_c1_and_non_degenerate (Cat 3 paper hypothesis) + gap_axiom_regular_value_set_open_and_dense_from_ift (Cat 2 IFT/Baire). Composite `SardRegularValueSetOpenDense` is now a `def := A ∧ B ∧ C` over these three atoms; `paper_prop_axis_independence_sard_regular_value_pending_mathlib_sard` is a `theorem` composing them."
  computability := "PUBLISHED (Sard 1942 + IFT); Mathlib infrastructure exists for Sard but requires typing `Φ` as a `C¹` map first."
  attackVector := "Composite is now structurally decomposed; substantive bodies for each atom blocked on Mathlib Sard + typed `Φ`. See per-atom entries for individual closure paths."
  attackHistory := ["composite decomposed into 3 typed atomic sub-axioms; entries gap_axiom_sard_critical_value_set_measure_zero / gap_predicate_phi_is_c1_and_non_degenerate / gap_axiom_regular_value_set_open_and_dense_from_ift added"]
  obstacleCitation := some "Type `Φ : ℝ_+³ → ℝ_+³` (or appropriate manifold map) as a `C¹` map + give `Jacobian3` a substantive body, then apply Mathlib's Sard theorem to discharge each sub-atom."
}

/-- Cat 2 Sard 1942 atom: critical-value set of `Φ : 𝓔 → ℝ_+³` has
 Lebesgue measure zero. Status `gapBlocked` because the substantive body
 requires Mathlib's `MeasureTheory.sard` (or smooth-map regular-value
 density lemma) over a typed `C¹` carrier — neither is currently
 instantiated in this project. -/
def gap_axiom_sard_critical_value_set_measure_zero : LedgerEntry := {
  identifier := "axiom:sard-critical-value-set-measure-zero"
  paperLabel := "prop:axis-independence part (a) sub-atom: Sard 1942"
  status := GapStatus.gapBlocked
  inputCategory := InputCategory.cat2External
  closureDistance := "Cat 2 atom (Sard 1942): critical-value set of a `C¹` map `Φ : ℝ_+³ → ℝ_+³` has Lebesgue measure zero. Bare `:Prop` axiom in Types.lean pending Mathlib `MeasureTheory.sard` infrastructure + typed `Φ` carrier."
  decomposability := "1 atomic Cat 2 external claim."
  computability := "PUBLISHED (Sard 1942)."
  attackVector := "Lean: `axiom SardCriticalValueSetMeasureZero : Prop` (Types.lean). Substantive body waits on Mathlib Sard port + typed `Φ`."
  attackHistory := ["introduced as decomposition sub-atom of SardRegularValueSetOpenDense"]
  obstacleCitation := some "Mathlib `MeasureTheory.sard` over `C¹` maps; also requires `Φ : ℝ_+³ → ℝ_+³` typed as a `C¹` map with substantive Jacobian."
}

/-- Cat 3 paper hypothesis-predicate atom: `Φ` is `C¹` on the
 parametrization of `𝓔` by economic primitives AND non-degenerate at
 some interior point (paper `prop:axis-independence` preamble). -/
def gap_predicate_phi_is_c1_and_non_degenerate : LedgerEntry := {
  identifier := "predicate:phi-is-c1-and-non-degenerate"
  paperLabel := "prop:axis-independence preamble (regularity hypothesis on Φ)"
  status := GapStatus.gapBlocked
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Cat 3 hypothesis-predicate atom: paper's regularity assumption on `Φ`. Bare `:Prop` axiom pending typed `Φ` accessor on `EconomicSystem`; once `Φ : EconomicSystem → ℝ × ℝ × ℝ` is given a substantive body, this predicate can carry concrete `C¹` + non-degenerate content."
  decomposability := "1 atomic Cat 3 hypothesis predicate."
  computability := "Paper-stated regularity hypothesis (preamble to prop:axis-independence)."
  attackVector := "Lean: `axiom PhiIsC1AndNonDegenerate : Prop` (Types.lean). Substantive body waits on typed `Φ` accessor + Mathlib smoothness predicates."
  attackHistory := ["introduced as decomposition sub-atom of SardRegularValueSetOpenDense"]
  obstacleCitation := some "Type `Φ : EconomicSystem → ℝ × ℝ × ℝ` with substantive smooth-map body; then assert `ContDiff ℝ 1 Φ ∧ ∃ S₀, DΦ S₀ has rank 3`."
}

/-- Cat 2 atom: Baire-residual + implicit function theorem consequence
 — a residual set contains a non-empty open dense subset whenever the
 underlying map is non-degenerate at some interior point. -/
def gap_axiom_regular_value_set_open_and_dense_from_ift : LedgerEntry := {
  identifier := "axiom:regular-value-set-open-and-dense-from-ift"
  paperLabel := "prop:axis-independence part (a) sub-atom: IFT consequence"
  status := GapStatus.gapBlocked
  inputCategory := InputCategory.cat2External
  closureDistance := "Cat 2 atom: under non-degeneracy at an interior point, the regular-value set is open and dense (Baire-residual + implicit function theorem). Bare `:Prop` axiom in Types.lean pending Mathlib `Topology.Baire` + `MeanValueTheorem`/`ImplicitFunction` infrastructure + typed `Φ`."
  decomposability := "1 atomic Cat 2 external claim."
  computability := "PUBLISHED (Baire category theorem + implicit function theorem)."
  attackVector := "Lean: `axiom RegularValueSetOpenAndDenseFromIFT : Prop` (Types.lean). Substantive body waits on typed `Φ` + Mathlib IFT/Baire."
  attackHistory := ["introduced as decomposition sub-atom of SardRegularValueSetOpenDense"]
  obstacleCitation := some "Apply Mathlib's `IsOpen.dense` + IFT once typed `Φ` is available."
}

/-- facet T1: the Cobb–Douglas functional form transfers unchanged
 to firm scale (paper prop:cross-scale-portability structural dim 1). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_firmlevel_cobb_douglas_form_transfers : LedgerEntry := {
  identifier := "predicate:firmlevel-cobb-douglas-form-transfers"
  paperLabel := "prop:cross-scale-portability structural transfer 1"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side structural transfer 1: the Cobb–Douglas functional form of the influence functional transfers unchanged from state scale to firm scale (paper Remark prop:cross-scale-portability). Empirical witnesses: firm dyads Apple/Samsung + TSMC vs. Intel. Currently `axiom HasFirmLevelCobbDouglasForm : EconomicSystem → Prop` (Types.lean) — no substantive body. NOTE: stated over the state-level `EconomicSystem` carrier (there is no `FirmSystem` type; mirrors how `cor_cross_scale_nonsub` handles firm cases via a separate `CrossScaleCase` inductive)."
  decomposability := "Substantive body would assert the firm-level influence functional has the form `Influence_F = K_F · Π_F^{a_F} · Μ_F^{b_F} · Ν_F^{c_F}`; requires the `EconomicSystem` constructor + typed firm-level axis accessors."
  computability := "Substantive once the carrier + firm-level accessors are typed; paper-evidenced structural claim."
  attackVector := "OPEN: typed body queued carrier-typing batch. Lean source: `Types.HasFirmLevelCobbDouglasForm` opaque axiom; sub-axiom `MainTheorem.paper_prop_cross_scale_cd_form_transfers_pending_carrier_inhabitation`."
  attackHistory := ["-add--component-predicate-of-IsFirmLevelPortableExtension-conjunction..."]
  obstacleCitation := some "(queued): give `EconomicSystem` a constructor + firm-level axis accessors, then replace `axiom HasFirmLevelCobbDouglasForm` with a `def` asserting the firm-level CD form."
}

/-- facet T2: the three-axis decomposition transfers unchanged to
 firm scale (paper prop:cross-scale-portability structural dim 2). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_firmlevel_three_axis_decomp_transfers : LedgerEntry := {
  identifier := "predicate:firmlevel-three-axis-decomp-transfers"
  paperLabel := "prop:cross-scale-portability structural transfer 2"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side structural transfer 2: the three-axis decomposition `(Π_F, Μ_F, Ν_F)` transfers unchanged from state scale to firm scale (paper Remark prop:cross-scale-portability). Empirical witnesses: firm dyads Apple/Samsung + TSMC vs. Intel. Currently `axiom HasFirmLevelThreeAxisDecomp : EconomicSystem → Prop` (Types.lean) — no substantive body. Stated over `EconomicSystem` carrier (no `FirmSystem` type)."
  decomposability := "Substantive body would assert the firm-level capability vector decomposes into 3 axes `(productive_F, mobilizable_F, network_F)` with the same algebraic role as state-level; requires the `EconomicSystem` constructor + typed firm-level axis accessors."
  computability := "Substantive once the carrier + firm-level accessors are typed."
  attackVector := "OPEN: typed body queued carrier-typing batch. Lean source: `Types.HasFirmLevelThreeAxisDecomp` opaque axiom; sub-axiom `MainTheorem.paper_prop_cross_scale_three_axis_decomp_transfers_pending_carrier_inhabitation`."
  attackHistory := ["-add--component-predicate-of-IsFirmLevelPortableExtension-conjunction..."]
  obstacleCitation := some "(queued): give `EconomicSystem` a constructor + firm-level axis accessors, then replace `axiom HasFirmLevelThreeAxisDecomp` with a `def`."
}

/-- facet T3: the non-substitutability theorem transfers to firm
 scale (paper prop:cross-scale-portability structural dim 3). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_firmlevel_nonsubstitutability_transfers : LedgerEntry := {
  identifier := "predicate:firmlevel-nonsubstitutability-transfers"
  paperLabel := "prop:cross-scale-portability structural transfer 3"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side structural transfer 3: the non-substitutability theorem transfers from state scale to firm scale (paper Remark prop:cross-scale-portability). Empirical witnesses: the 3 firm collapses BlackBerry / Nokia / Kodak — each NU_F-dominated with Π_F and Μ_F materially positive at collapse (paper cites Cor. cross-scale-nonsub). IMPORTANT: this is a FRESH `axiom HasFirmLevelNonSubstitutability : EconomicSystem → Prop` (Types.lean) — it does NOT logically derive from `cor_cross_scale_nonsub` (that lemma is `CrossScaleNonSubValidatedSixCases`, a scale-spanning enumeration-coverage tautology over a 6-constructor inductive with NO `EconomicSystem` argument; it serves only as the empirical witness, not the type-level antecedent for T3). No substantive body — stated over `EconomicSystem` carrier."
  decomposability := "Substantive body would assert that at firm scale, driving any one axis `x_{F,k} → 0` drives `Influence_F → 0` (the firm-level analogue of `thm:nonsubstitutability` / `cor:annihilation-from-tullock`); requires the `EconomicSystem` constructor + typed firm-level axis accessors. Distinct from `cor_cross_scale_nonsub` which only enumerates 6 validated collapse cases."
  computability := "Substantive once the carrier + firm-level accessors are typed; paper-evidenced via 3 firm-collapse cases."
  attackVector := "OPEN: typed body queued carrier-typing batch. Lean source: `Types.HasFirmLevelNonSubstitutability` opaque axiom; sub-axiom `MainTheorem.paper_prop_cross_scale_nonsubstitutability_transfers_pending_carrier_inhabitation`. Empirical witness: `cor_cross_scale_nonsub` + BlackBerry/Nokia/Kodak cases."
  attackHistory := ["-add--component-predicate-of-IsFirmLevelPortableExtension-conjunction..."]
  obstacleCitation := some "(queued): give `EconomicSystem` a constructor + firm-level axis accessors, then replace `axiom HasFirmLevelNonSubstitutability` with a `def` asserting firm-level annihilation-at-zero on each axis (analogue of `thm:nonsubstitutability`)."
}

/-- facet Q: the firm-level Cobb–Douglas exponents shift in the
 structurally-predicted direction (paper prop:cross-scale-portability
 quantitative dim). -/
-- inputCat: Cat 3
-- subType: predicate


def gap_predicate_firmlevel_exponent_shift_direction : LedgerEntry := {
  identifier := "predicate:firmlevel-exponent-shift-direction"
  paperLabel := "prop:cross-scale-portability quantitative dimension"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "OPAQUE AXIOM PREDICATE introduced. Paper-side quantitative shift: the calibrated firm-level exponents `(a_F, b_F, c_F) ≈ (0.35, 0.20, 0.45)` shift the network weight UP (c: 0.39 → 0.45) and the production weight DOWN (a: 0.40 → 0.35) relative to the state-level `(0.40, 0.21, 0.39)` (b ≈ flat: 0.21 → 0.20), in the direction structurally predicted by rising `r_NU` and `|∂W/∂x_NU|` at firm scale (paper Remark prop:cross-scale-portability). Currently `axiom FirmLevelExponentShiftDirection : EconomicSystem → Prop` (Types.lean) — no substantive body. Stated over `EconomicSystem` carrier."
  decomposability := "Substantive body would assert `c_F > c_state ∧ a_F < a_state` (with `(a_F, b_F, c_F)` the firm-level survival-weight-derived exponents, `(a_state, b_state, c_state) = (0.40, 0.21, 0.39)`), AND the shift direction tracks `r_{F,NU} > r_{state,NU}` / `|∂W_F/∂x_NU| > |∂W_state/∂x_NU|`; requires the `EconomicSystem` constructor + typed firm-level `r_NU`, `∂W/∂x_NU` accessors (plus the survival-weight machinery from thm:exponent-derivation at firm scale)."
  computability := "Substantive once the carrier + firm-level rent-loading/discrimination accessors are typed; paper-evidenced by firm-level calibration."
  attackVector := "OPEN: typed body queued carrier-typing batch + firm-level `r_NU` / `∂W/∂x_NU` accessors. Lean source: `Types.FirmLevelExponentShiftDirection` opaque axiom; sub-axiom `MainTheorem.paper_prop_cross_scale_exponent_shift_direction_pending_carrier_inhabitation`."
  attackHistory := ["-add--component-predicate-of-IsFirmLevelPortableExtension-conjunction..."]
  obstacleCitation := some "(queued): give `EconomicSystem` a constructor + firm-level `r_NU : EconomicSystem → ℝ`, `partialW_NU : EconomicSystem → ℝ` accessors, then replace `axiom FirmLevelExponentShiftDirection` with a `def` asserting `c_F > c_state ∧ a_F < a_state` + shift-direction tracking."
}

/-! ## Group R: decomposition atoms (thm:threshold + thm:tension-cycle + prop:taylor-F) -/

/-- Decomposition atom A for `thm:threshold` static-inequality. -/
-- inputCat: Cat 3
-- subType: structural-eq
def gap_atom_threshold_focal_factor_bound : LedgerEntry := {
  identifier := "atom:thm-threshold-focal-factor-bound"
  paperLabel := "thm:threshold proof step 1 (focal-axis Cobb-Douglas)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "PUBLISHED. Paper proof step: under MinimumAxisCondition + θ̄ > 1, the focal-axis Cobb-Douglas factor (x_j(t)/x_j*)^{γ_j} is ≤ θ̄⁻¹ at the crossing instant."
  decomposability := "1 atomic structural-eq stipulation."
  computability := "PUBLISHED (Cobb-Douglas algebra)."
  attackVector := "Cat 3 atom encoded as `paper_thm_threshold_focal_factor_bound` axiom in MainTheorem.lean (R45 §13 decomposition)."
  attackHistory := ["R45: introduced as atom A of thm:threshold §13 decomposition"]
  obstacleCitation := none
}

/-- Decomposition atom B for `thm:threshold` static-inequality. -/
-- inputCat: Cat 3
-- subType: structural-eq
def gap_atom_threshold_nonfocal_factor_bound : LedgerEntry := {
  identifier := "atom:thm-threshold-nonfocal-factor-bound"
  paperLabel := "thm:threshold proof step 2 (non-focal axes ≤ 1)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "PUBLISHED. Paper proof step: under NonCompensatingNonCrossing, the non-focal axes' joint Cobb-Douglas factor ∏_{k≠j}(x_k/x_k*)^{γ_k} is ≤ 1 (paper proof side condition β ≤ 1)."
  decomposability := "1 atomic structural-eq stipulation."
  computability := "PUBLISHED (Cobb-Douglas algebra + side-condition)."
  attackVector := "Cat 3 atom encoded as `paper_thm_threshold_nonfocal_factor_bound` axiom in MainTheorem.lean (R45 §13 decomposition)."
  attackHistory := ["R45: introduced as atom B of thm:threshold §13 decomposition"]
  obstacleCitation := none
}

/-- Decomposition atom C for `thm:threshold` static-inequality. -/
-- inputCat: Cat 3
-- subType: structural-eq
def gap_atom_threshold_factors_combine : LedgerEntry := {
  identifier := "atom:thm-threshold-factors-combine"
  paperLabel := "thm:threshold proof step 3 (Cobb-Douglas product rule)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "PUBLISHED. Paper proof step: focal-factor + non-focal-factor bounds combined via Cobb-Douglas product yield InfluenceBelowThetaBarInverse. Cat 3 because conclusion carrier is opaque (closed form lives in thm:representation)."
  decomposability := "1 atomic structural-eq stipulation."
  computability := "PUBLISHED (Cobb-Douglas product rule)."
  attackVector := "Cat 3 atom encoded as `paper_thm_threshold_factors_combine` axiom in MainTheorem.lean (R45 §13 decomposition)."
  attackHistory := ["R45: introduced as atom C of thm:threshold §13 decomposition"]
  obstacleCitation := none
}

/-- Decomposition spectral atom for `thm:tension-cycle`. Cat 3
 paper-novel composition (paper does not cite Bartlett 1955; PDMP
 framework is Daley-Vere-Jones 2003 §7). -/
def gap_axiom_paper_pdmp_lowfreq_band : LedgerEntry := {
  identifier := "axiom:paper-pdmp-lowfreq-band"
  paperLabel := "thm:tension-cycle (paper renewal-convolution argument)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "PAPER-NOVEL COMPOSITION. Paper thm:tension-cycle proof constructs the low-frequency band statement via renewal-style convolution of deterministic relaxation and shock-arrival contributions, citing Daley-Vere-Jones 2003 §7 for the PDMP framework. Paper explicitly disclaims the explicit Bartlett-spectrum computation. The band statement T_cycle ∈ [τ_relax, τ_relax + E[τ_shock]] is what the renewal-style argument supports; the explicit peak is a numerical observation."
  decomposability := "1 atomic Cat 3 paper-novel spectral atom (composition of renewal convolution + PDMP framework from Daley-Vere-Jones 2003 §7)."
  computability := "Paper proof (renewal-style convolution); Lean axiomatized pending Mathlib PDMP infrastructure."
  attackVector := "Cat 3 paper-novel composition (paper does not cite Bartlett 1955; PDMP framework cited via Daley-Vere-Jones 2003 §7 per paper's actual reference chain)."
  attackHistory := ["extracted as atom from former monolithic paper_thm_tension_cycle_band_holds", "reclassified Cat 2 → Cat 3 paper-novel composition; Bartlett 1955 §6.2 attribution removed (anachronism: PDMP is Davis 1984)", "identifier renamed bartlett_1955_pdmp_lowfreq_band → paper_pdmp_lowfreq_band per §11 paper-Lean unification (symbol-level anachronism eliminated)"]
  obstacleCitation := some "Closure requires (a) Mathlib PDMP infrastructure for the renewal convolution to be Lean-derived, OR (b) typed bridge from a `RenewalProcess` carrier in Mathlib's MeasureTheory / point-process modules."
}

/-- Decomposition Cat 3 atom for `thm:tension-cycle` PDMP hypothesis. -/
def gap_atom_paper_pdmp_satisfies_spectral_hypotheses : LedgerEntry := {
  identifier := "atom:paper-pdmp-satisfies-spectral-hypotheses"
  paperLabel := "thm:tension-cycle proof preamble (PDMP construction)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "Paper-novel hypothesis predicate: the paper's PDMP carrier for an EconomicSystem satisfies the spectral hypotheses (stationarity + integrable autocovariance + ergodicity) needed for the low-frequency band claim. Paper invokes the Daley-Vere-Jones 2003 §7 PDMP framework."
  decomposability := "1 atomic Cat 3 hypothesis predicate; bundles three sub-properties (stationarity / integrable autocovariance / ergodicity) — future round may split into per-property typed bridges."
  computability := "Definitional atom (paper PDMP construction subsection invoking Daley-Vere-Jones 2003 §7)."
  attackVector := "Cat 3 atom `paper_pdmp_satisfies_spectral_hypotheses` in MainTheorem.lean. Cat 3 hypothesis-predicate sub-type. Symbol-level Bartlett attribution eliminated per §11 paper-Lean unification."
  attackHistory := ["introduced as Cat 3 hypothesis-predicate atom of thm:tension-cycle decomposition", "docstring + paperLabel corrected to remove Bartlett 1955 attribution (PDMP framework is Daley-Vere-Jones 2003 §7 per paper's actual cite)", "identifier renamed paper_pdmp_satisfies_bartlett → paper_pdmp_satisfies_spectral_hypotheses (predicate also renamed PaperPDMPSatisfiesBartlettHypotheses → PaperPDMPSatisfiesSpectralHypotheses)"]
  obstacleCitation := none
}

/-- Working-assumption axiom for `prop:taylor-F`. -/
-- inputCat: Cat 3
-- subType: working-assumption
def gap_axiom_paper_prop_taylor_F : LedgerEntry := {
  identifier := "axiom:paper-prop-taylor-F-holds"
  paperLabel := "prop:taylor-F (working-assumption axiom replacing sorry)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "Paper Hessian decomposition H^{(k)}_{mn} = ∂²W/∂x_m∂x_n + δ_{mn}·∂²d_k/∂x_m². Lean replication requires Mathlib multivariate Taylor + concrete F : ℝ³ → ℝ carrier (currently EconomicSystem carrier is opaque so F cannot be stated directly)."
  decomposability := "Working-assumption pending carrier-port engineering."
  computability := "PUBLISHED (paper proof); Lean derivation pending carrier port."
  attackVector := "R45: replaced raw `sorry` in prop_taylor_F body with `paper_prop_taylor_F_holds` working-assumption axiom per discipline §3.4.4. Now surfaced via #print axioms (was hidden before)."
  attackHistory := ["sorry placeholder until R45", "R45: sorry → working-assumption axiom (#print axioms now surfaces dependency)"]
  obstacleCitation := some "Carrier-port engineering: requires (a) typed F : EconomicSystem → ℝ³ → ℝ accessor; (b) Mathlib multivariate iteratedFDeriv Taylor; (c) Lean port of Hessian decomposition. Deferred per §12.4 wholesale-reorganization criterion."
}

/-- Forward-use cardinal ŵ = (0.640, 0.175, 0.185). -/
def gap_axiom_forward_use_cardinal_w_hat : LedgerEntry := {
  identifier := "axiom:forward-use-cardinal-w-hat"
  paperLabel := "thm:pwt-loop-closure (formal theorem in §sec:cardinal-vindication)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "Forward-use Cobb-Douglas cardinal ŵ = (0.640, 0.175, 0.185), derived from PWT 11.0 G15 1957-2019 cross-coupling extraction via the identification chain γ_m = δ_m^(-1) |α_km|/L_k r_m (paper composition of thm:exponent-derivation + def:coupled-dynamics, now formalized as prop:identification-chain). Empirically vindicated over historical headline (L² to data-derived γ̂_pred = 0.034 vs 0.321 for headline). Paper v6 promoted this finding to its own formal theorem thm:pwt-loop-closure."
  decomposability := "1 atomic Cat 3 structural-eq (paper-novel cardinal empirically derived via identification chain)."
  computability := "PUBLISHED (R36 script r36_close_R34_R35_loop.py); 4/7 sensitivity-test specifications STRONG match (R38)."
  attackVector := "Cat 3 atom encoded as `forwardUseCardinal_w_hat` axiom in Types.lean. Forward-use recommendation per paper Conclusion v2 update + R46 (P4) coupled-ODE re-derivation (script r46_p4_under_w_hat.py): 2025 cross-section China/US ≈ 0.96, 2045 trajectory ≈ 1.04."
  attackHistory := ["R36: PWT loop closure → ŵ vindicated over headline at L²=0.034", "R38: 7-spec sensitivity → 4/7 STRONG ŵ match, 0/7 strong headline match", "R45: marked as Cat 3 structural-eq with subType tag", "R46: coupled-ODE re-derivation under ŵ gives (P4) 2045 band [1.03, 1.04]; paper Conclusion + abstract + main results + (P4) updated to dual-cardinal form"]
  obstacleCitation := none
}

/-- ŵ-over-headline empirical-loop-closure verdict. -/
def gap_axiom_w_hat_vindicated_over_headline : LedgerEntry := {
  identifier := "axiom:w-hat-vindicated-over-headline-at-PWT-G15"
  paperLabel := "thm:pwt-loop-closure + prop:frequency-scope (formal theorem + proposition in §sec:cardinal-vindication)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.workingAssumption
  closureDistance := "ŵ = (0.640, 0.175, 0.185) is the framework's forward cardinal per PWT G15 1957-2019 empirical loop closure (L²=0.034 to data-derived γ̂_pred vs L²=0.321 for legacy headline). Paper formalizes this as thm:pwt-loop-closure. Maddison Project 1870-2018 (n=18, T=149) is a frequency-scope finding: pooled δ_PI = -0.002 reflects near-unit-root multi-decade behaviour (Cochrane 1988, Nelson 1982); paper formalizes this as prop:frequency-scope with explicit annual-frequency domain (δ > 0). The verdict is frequency-specific (annual-cyclical regime), not universal cross-horizon."
  decomposability := "Single-cardinal commitment. Frequency-scope qualifier added to Theorem thm:exponent-derivation."
  computability := "PUBLISHED (R36 + R38 + R46 Maddison scope finding)."
  attackVector := "Cat 3 working-assumption axiom `paper_w_hat_vindicated_over_headline_at_PWT_G15` in Types.lean. v4: single-cardinal commitment (dual-cardinal v2-v3 hedge withdrawn); Theorem thm:exponent-derivation has explicit annual-frequency scope."
  attackHistory := ["R36: PWT empirical loop closure L²=0.034 (ŵ) vs L²=0.321 (headline)", "R38: 7-spec sensitivity confirms robustness", "R45: encoded as working-assumption axiom + ledger entry", "R46: Maddison-Project longer-T frequency-scope finding (sign reversal = unit-root regime)", "v4: single-cardinal commitment to ŵ; dual-cardinal hedge withdrawn; theorem scope explicit (δ > 0 annual-frequency domain)"]
  obstacleCitation := some "Full multi-frequency extension: ŵ verdict applies at annual-cyclical regime; multi-decade unit-root regime requires separate scope analysis. Currently encoded as theorem-scope qualifier, not separate ledger entry."
}

/-- v4: PPP-alignment of Influence ratio (third-party validation). -/
def gap_axiom_influence_ppp_alignment : LedgerEntry := {
  identifier := "axiom:influence-ppp-alignment-third-party-validation"
  paperLabel := "tab:third-party-validation (v4)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "v4 third-party validation: framework Influence ratio under ŵ aligns with structural-capability indices and diverges from MER-FX accounting. 2025 China/US: framework Influence 0.96 ; Lowy 2024 API 0.88 ; Pardee 2024 RNP 0.85-0.95 ; IMF PPP-GDP 1.29 ; MER-GDP 0.64. Divergence from MER is structural: MER overvaluation = USD-network artefact = component of NU_US, not separate capability."
  decomposability := "1 structural-eq atom: framework Influence aligns to structural-capability/PPP scale, not MER-FX scale."
  computability := "PUBLISHED (independent third-party indices)."
  attackVector := "Cat 3 structural-eq atom encoded as docstring claim in paper §sec:experiments-future + tab:third-party-validation. Lean signature: aligned with `forwardUseCardinal_w_hat` axiom dependency chain."
  attackHistory := ["v4: added third-party validation table + PPP-alignment narrative; framework Influence ratio empirically aligned with Lowy/Pardee/PPP-GDP family"]
  obstacleCitation := none
}

/-- v4.1: cardinal-invariance of (P5)/(P6) Saudi/Germany discriminating predictions. -/
def gap_axiom_p5_p6_cardinal_invariance : LedgerEntry := {
  identifier := "axiom:p5-p6-cardinal-invariance"
  paperLabel := "sec:experiments-future (P5)/(P6) Cardinal-robustness items (v4.1)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "v4.1 cardinal-invariance claim: (P5) Saudi NU-first and (P6) Germany PI-first ordering predictions are cardinal-invariant (depend on meta-theorem σ-permutation + δ_k ordering + ∂W/∂x_PI primitive, not on (a, b, c)). The 30%-decline trigger threshold (P5) and threshold-crossing time (P6) are level computations that depend on ŵ, but the ORDERING discriminator does not."
  decomposability := "1 hypothesis predicate: (P5)/(P6) ordering claims are cardinal-invariant."
  computability := "PUBLISHED (meta-theorem ordering result)."
  attackVector := "Cat 3 hypothesis predicate encoded as docstring claim in §sec:experiments-future (P5)/(P6) Cardinal-robustness notes."
  attackHistory := ["v4.1: added explicit cardinal-invariance qualifier to (P5)/(P6) discriminating predictions; level computations now use ŵ explicitly"]
  obstacleCitation := none
}

/-- v4.2: firm-level cardinal-robustness for portability test. -/
def gap_axiom_firm_level_cardinal_robustness : LedgerEntry := {
  identifier := "axiom:firm-level-cardinal-robustness"
  paperLabel := "sec:firms cardinal-robustness (v4.2)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.hypothesisPredicate
  closureDistance := "v4.2 firm-level cardinal-robustness: the 3 firm dyad ratios are reported under both headline (0.40, 0.21, 0.39) and ŵ (0.640, 0.175, 0.185). Samsung/Apple 0.66 → 0.76 ; Google/Microsoft 1.02 → 1.10 ; Intel/TSMC 0.46 → 0.51. Qualitative winners + non-substitutability theorem at firm level preserved under both cardinals (cardinal-invariant claim)."
  decomposability := "1 hypothesis predicate: firm-level qualitative ordering is cardinal-invariant."
  computability := "PUBLISHED (3 dyads × 2 cardinals computed)."
  attackVector := "Cat 3 hypothesis predicate encoded in tab:apple-samsung, tab:msft-googl, tab:tsmc-intel as dual-cardinal rows."
  attackHistory := ["v4.2: added ŵ-cardinal rows to 3 firm tables; qualitative winners preserved across both cardinals"]
  obstacleCitation := none
}

/-- v4.3: era-table ŵ-survival row recovers ŵ for late-industrial era exactly. -/
def gap_axiom_era_table_w_hat_recovery : LedgerEntry := {
  identifier := "axiom:era-table-w-hat-recovery"
  paperLabel := "tab:era-exponents-derived ŵ-survival column (v4.3)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat3PaperNovel
  cat3SubType := Cat3SubType.structuralDefiningEquation
  closureDistance := "v4.3 era-table extension: added 'ŵ-survival' column to tab:era-exponents-derived under the v4 forward cardinal (uniform L_k=1 + paper r_k = (0.93, 1.27, 0.67)). Late-industrial row recovers ŵ = (0.640, 0.175, 0.185) EXACTLY, confirming the era-table is internally consistent with R36 PWT empirical loop closure. 4 era rows reported: Mercantile (0.48, 0.07, 0.46) / Industrial (0.54, 0.15, 0.31) / Late-industrial (0.64, 0.18, 0.19) / Information (0.37, 0.10, 0.53)."
  decomposability := "1 structural-eq atom: late-industrial ŵ-survival prediction matches R36 ŵ exactly."
  computability := "PUBLISHED (arithmetic on δ + r table)."
  attackVector := "Cat 3 structural-eq encoded in tab:era-exponents-derived ŵ-survival column."
  attackHistory := ["v4.3: ŵ-survival column added; late-industrial row recovers ŵ exactly (cross-validation internal consistency)"]
  obstacleCitation := none
}

/-- v4.4: Cat 2 axiom for Lowy Asia Power Index 2024. -/
def gap_axiom_lowy_2024_api : LedgerEntry := {
  identifier := "axiom:lowy-2024-asia-power-index-china-us-ratio"
  paperLabel := "tab:third-party-validation Lowy row (v4.4)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat2External
  closureDistance := "External Cat 2 measurement: Lowy Institute Asia Power Index 2024, China/US ratio = 0.88 (US 80.7 vs China 71.3). 8-component multi-dimensional measure across 131 indicators with explicit linear weights. Cited in paper §sec:intro literature review (\\citealp{lowy2025api}); used in v4 third-party validation."
  decomposability := "1 atomic external measurement."
  computability := "PUBLISHED (Lowy Institute 2024 annual update)."
  attackVector := "Cat 2 axiom recorded in paper tab:third-party-validation. auditVerdict: CLEAN (10-pattern hostile audit, R45 + v4.4): citation real, statement matches Lowy 2024 country-level scores."
  attackHistory := ["R45: tagged in Cat 2 entries via auditVerdict comment", "v4.4: explicit Cat 2 ledger entry created for third-party validation traceability"]
  obstacleCitation := none
}

/-- v4.4: Cat 2 axiom for Pardee Relative National Power 2024. -/
def gap_axiom_pardee_2024_rnp : LedgerEntry := {
  identifier := "axiom:pardee-2024-relative-national-power-china-us-ratio"
  paperLabel := "tab:third-party-validation Pardee row (v4.4)"
  status := GapStatus.gapOpen
  inputCategory := InputCategory.cat2External
  closureDistance := "External Cat 2 measurement: Pardee Center / University of Denver Relative National Power Codebook 2024 (\\citealp{moyermarkle2024}), China/US ratio range = 0.85-0.95 across GPI/HHMI/DiME multidimensional indices. Cited in paper §sec:intro literature review; used in v4 third-party validation."
  decomposability := "1 atomic external measurement (multi-index)."
  computability := "PUBLISHED (Pardee Center 2024 codebook)."
  attackVector := "Cat 2 axiom recorded in paper tab:third-party-validation. auditVerdict: CLEAN (10-pattern hostile audit, v4.4): real codebook, multi-index range citation matches Pardee 2024 documentation."
  attackHistory := ["v4.4: explicit Cat 2 ledger entry created for third-party validation traceability"]
  obstacleCitation := none
}

/-! ## Group S: paper-label coverage backfill

The paper audit found labels in `influence_capacity.tex` that were present in
Lean docstrings or prose but not represented as ledger entries. Most are
definitions or scope/protocol remarks: they are not closure targets, but the
gap-ledger discipline still needs them to be searchable and classified. -/

def mkPaperCoverageEntry
    (identifier paperLabel : String)
    (status : GapStatus)
    (inputCategory : InputCategory)
    (cat3SubType : Cat3SubType)
    (coverage : String) : LedgerEntry := {
  identifier := identifier
  paperLabel := paperLabel
  status := status
  inputCategory := inputCategory
  cat3SubType := cat3SubType
  closureDistance := coverage
  decomposability := "Paper-label coverage backfill entry. Not a composite proof shortcut; use this entry only to locate the source label and its Lean encoding/backlog."
  computability := "COVERAGE / CLASSIFICATION."
  attackVector := "R46 paper-label audit: surfaced a labelled paper object that was previously present only in prose or Lean docstrings, not as a typed LedgerEntry."
  attackHistory := ["R46: paper-label coverage backfill from influence_capacity.tex vs Ledger.lean label diff"]
  obstacleCitation := none
}

def gap_def_system : LedgerEntry :=
  mkPaperCoverageEntry "def:system" "def:system"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.carrier
    "Cat 3 carrier. Lean encoding: `Types.EconomicSystem` structure with paper primitive projections/accessors."

def gap_def_reachable : LedgerEntry :=
  mkPaperCoverageEntry "def:reachable" "def:reachable"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition. Lean encoding: `Types.ReachableSet`; substantive set construction remains opaque pending the `EconomicSystem` carrier port."

def gap_def_influence : LedgerEntry :=
  mkPaperCoverageEntry "def:influence" "def:influence"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition. Lean encoding: `EconomicSystem.Influence`, `InfluenceAggregator`, and `influence_via_aggregator`."

def gap_def_three_projections : LedgerEntry :=
  mkPaperCoverageEntry "def:three-projections" "def:three-projections / lem:three-projections"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition. Lean encoding: `productiveCapacity`, `mobilizableSurplus`, `networkPosition`, and `axisValue`."

def gap_lem_three_projections_alias : LedgerEntry :=
  mkPaperCoverageEntry "lem:three-projections" "lem:three-projections"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Alias label on the same paper object as `def:three-projections`; tracked separately because the TeX source exposes both labels."

def gap_def_normalizations : LedgerEntry :=
  mkPaperCoverageEntry "def:normalizations" "def:normalizations"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition of equal-weight and empirical exponent normalizations; no standalone Lean theorem target."

def gap_def_three_contest_game : LedgerEntry :=
  mkPaperCoverageEntry "def:three-contest-game" "def:three-contest-game"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.carrier
    "Cat 3 carrier/structure for the paper's three independent contests. Lean encoding uses `CapabilityAxis`, `TullockParameters`, and Tullock predicates."

def gap_def_tullock_csf : LedgerEntry :=
  mkPaperCoverageEntry "def:tullock-csf" "def:tullock-csf"
    GapStatus.gapOpen InputCategory.cat2External Cat3SubType.notCat3
    "Cat 2 external formula (Tullock 1980 / Skaperdas 1996). Lean encoding: opaque `TullockContestProbability`; promotion path is a Hodge-style closed-form def once contestant profiles are typed."

def gap_def_pi : LedgerEntry :=
  mkPaperCoverageEntry "def:pi" "def:pi"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition of productive capacity. Lean encoding: `productiveCapacity` projection on `EconomicSystem`."

def gap_def_mu : LedgerEntry :=
  mkPaperCoverageEntry "def:mu" "def:mu"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition of mobilizable surplus. Lean encoding: `mobilizableSurplus` projection and `MobilizableSurplusEqualsReachabilityRadius`."

def gap_def_nu : LedgerEntry :=
  mkPaperCoverageEntry "def:nu" "def:nu"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural definition of network position. Lean encoding: `networkPosition`, `networkPosition_via_spectrum`, and `nu_function_of_spectrum`."

def gap_def_hegemonic_ss : LedgerEntry :=
  mkPaperCoverageEntry "def:hegemonic-ss" "def:hegemonic-ss"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.hypothesisPredicate
    "Cat 3 regime predicate. Lean encoding: `IsHegemonicSteadyState`."

def gap_def_hazard : LedgerEntry :=
  mkPaperCoverageEntry "def:hazard" "def:hazard"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Cat 3 structural hazard definition for tension-driven shocks. Lean coverage is via the tension-cycle / Hawkes / PDMP predicates rather than a standalone closed form."

def gap_prop_translog_vs_cobb_douglas : LedgerEntry :=
  mkPaperCoverageEntry "prop:translog-vs-cobb-douglas" "prop:translog-vs-cobb-douglas"
    GapStatus.gapOpen InputCategory.cat3PaperNovel Cat3SubType.workingAssumption
    "Paper proposition not yet typed as a Lean theorem. It applies external translog/Cauchy facts to the paper's A4 base-point-independence clause; needs a typed translog-family predicate and theorem statement."

def gap_rem_a0_prior : LedgerEntry :=
  mkPaperCoverageEntry "rem:a0-prior" "rem:a0-prior"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.hypothesisPredicate
    "Scope note decomposing A0 into A0a and A0b; Lean encoding already uses separate A0a/A0b predicates and `A0_commensurability`."

def gap_rem_axiom_economy : LedgerEntry :=
  mkPaperCoverageEntry "rem:axiom-economy" "rem:axiom-economy"
    GapStatus.gapOpen InputCategory.cat3PaperNovel Cat3SubType.workingAssumption
    "Axiom-economy remark not yet typed: A1 measurability suffices and A4 two-base-point form suffices. Needs separate Lean predicates if upgraded from prose."

def gap_rem_axis_vs_composite : LedgerEntry :=
  mkPaperCoverageEntry "rem:axis-vs-composite" "rem:axis-vs-composite"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Interpretive scope note linking axis-form and composite-form tests; no standalone theorem target."

def gap_rem_carr_center_manifold : LedgerEntry :=
  mkPaperCoverageEntry "rem:carr-center-manifold" "rem:carr-center-manifold"
    GapStatus.gapOpen InputCategory.cat2External Cat3SubType.notCat3
    "External-method remark (Carr 1981 center-manifold correction) not typed as a Lean dependency."

def gap_rem_decay_calibration : LedgerEntry :=
  mkPaperCoverageEntry "rem:decay-calibration" "rem:decay-calibration"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Paper calibration convention for decay rates; Lean encoding: `DecayRates`, `decayRate`, and calibration-specific predicates."

def gap_rem_finite_share_elasticity : LedgerEntry :=
  mkPaperCoverageEntry "rem:finite-share-elasticity" "rem:finite-share-elasticity"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Interpretive remark explaining why finite-share corrected elasticity blocks naive `a = r_k`; related Lean predicates are `IsCorrectedTullockElasticity` and finite-share entries."

def gap_rem_info_motivation : LedgerEntry :=
  mkPaperCoverageEntry "rem:info-motivation" "rem:info-motivation"
    GapStatus.gapDefinitional InputCategory.cat2External Cat3SubType.notCat3
    "Information-theoretic motivation via Cover-Thomas independence decomposition; paper explicitly does not use it as the formal derivation."

def gap_rem_invariance : LedgerEntry :=
  mkPaperCoverageEntry "rem:invariance" "rem:invariance"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Normalization-invariance scope note; no separate Lean theorem beyond existing threshold/collapse/nonsubstitutability statements."

def gap_rem_khasminskii_stochastic_stability : LedgerEntry :=
  mkPaperCoverageEntry "rem:khasminskii-stochastic-stability" "rem:khasminskii-stochastic-stability"
    GapStatus.gapOpen InputCategory.cat2External Cat3SubType.notCat3
    "External-method strengthening via Khasminskii Lyapunov criterion; not yet a typed Lean dependency."

def gap_rem_long_cycles : LedgerEntry :=
  mkPaperCoverageEntry "rem:long-cycles" "rem:long-cycles"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Historical-interpretive long-cycle scope note; formal content is tracked under `thm:tension-cycle` and model-extension entries."

def gap_rem_mrs_clarification : LedgerEntry :=
  mkPaperCoverageEntry "rem:mrs-clarification" "rem:mrs-clarification"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Clarifies marginal-rate-of-substitution interpretation of non-substitutability; no standalone theorem target."

def gap_rem_mu_protocol : LedgerEntry :=
  mkPaperCoverageEntry "rem:mu-protocol" "rem:mu-protocol"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Measurement protocol for MU; Lean coverage is through the `mobilizableSurplus` projection and calibration predicates."

def gap_rem_nu_protocol : LedgerEntry :=
  mkPaperCoverageEntry "rem:nu-protocol" "rem:nu-protocol"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Measurement protocol for NU; Lean coverage is through `networkPosition` and spectrum-link predicates."

def gap_rem_operational_projections : LedgerEntry :=
  mkPaperCoverageEntry "rem:operational-projections" "rem:operational-projections"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Operational interpretation of PI/MU/NU projections; no separate closure target beyond axis definitions."

def gap_rem_pi_protocol : LedgerEntry :=
  mkPaperCoverageEntry "rem:pi-protocol" "rem:pi-protocol"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Measurement protocol for PI; Lean coverage is through `productiveCapacity`, `usefulWork`, `gdp`, and `valueAdded` accessors."

def gap_rem_replicator_ess : LedgerEntry :=
  mkPaperCoverageEntry "rem:replicator-ess" "rem:replicator-ess"
    GapStatus.gapOpen InputCategory.cat2External Cat3SubType.notCat3
    "External alternative via logit-dynamic invariant measure / ESS-style argument; not yet typed as a dependency."

def gap_rem_set_not_scalar : LedgerEntry :=
  mkPaperCoverageEntry "rem:set-not-scalar" "rem:set-not-scalar"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Interpretive scope note: reachable set is primitive and scalar indices are projections; no separate Lean theorem target."

def gap_rem_shock_direction : LedgerEntry :=
  mkPaperCoverageEntry "rem:shock-direction" "rem:shock-direction"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.hypothesisPredicate
    "Shock-direction caveat for dominant tension components; tied to tension-cycle predicates."

def gap_rem_trefethen_pseudospectra : LedgerEntry :=
  mkPaperCoverageEntry "rem:trefethen-pseudospectra" "rem:trefethen-pseudospectra"
    GapStatus.gapOpen InputCategory.cat2External Cat3SubType.notCat3
    "External-method remark on Trefethen-Embree pseudospectra for AEB transient amplification; not yet a typed Lean dependency."

def gap_rem_units : LedgerEntry :=
  mkPaperCoverageEntry "rem:units" "rem:units"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "Units and cross-system comparability convention for the three axes; no separate theorem target."

def gap_rem_why_three : LedgerEntry :=
  mkPaperCoverageEntry "rem:why-three" "rem:why-three"
    GapStatus.gapDefinitional InputCategory.cat3PaperNovel Cat3SubType.structuralDefiningEquation
    "High-level explanation of the three-axis count; formal proof obligations are tracked under `thm:three-axes`, `prop:two-axis-reduction`, `prop:four-axis-reduction`, and `prop:fourth-axes`."

/-! ## Status-distribution helpers -/

/-- All ledger entries (concatenation; update when new entries added). -/
def allEntries : List LedgerEntry := [
  -- Group A: 4 load-bearing axioms


  gap_A0_commensurability, gap_A1_continuity, gap_A2_monotonicity, gap_A4_multiplicative_scaling,
  -- Group B: 2 derivable redundancies


  gap_A3_zero_axis_annihilation, gap_A5_log_additivity,
  -- Group C: 5 conditional hypotheses


  gap_hyp_slow_driver_regime, gap_hyp_special_rank_1_fungibility,
  gap_hyp_ex_ante_regime_assignment_protocol, gap_hyp_small_share_tullock,
  gap_hyp_time_invariant_cross_couplings,
  -- Group D: main theorems


  gap_thm_representation, gap_thm_nonsubstitutability,
  gap_thm_tullock_microfoundation, gap_lem_budget_feedback,
  gap_thm_dynamics_microfoundation, gap_lem_hss_exists,
  gap_thm_threshold, gap_thm_meta_collapse,
  gap_thm_collapse_sequence, gap_thm_collapse_sequence_info,
  gap_thm_collapse_aeb, gap_cor_two_regimes,
  gap_thm_exponent_derivation, gap_thm_three_axes,
  gap_prop_nonlinear_stability, gap_prop_clustering,
  gap_prop_nu_removal,
  -- Group E: ex-ante-protocol


  gap_prop_ex_ante_classification, gap_cor_ex_ante_pvalue,
  gap_cor_selection_bias_corrected_null,
  -- Group F: hegemonic-margin / corollaries


  gap_prop_theta_bar_derived, gap_prop_theta_bar_case,
  gap_cor_composite_margin, gap_cor_annihilation_from_tullock,
  gap_cor_finite_share_tullock, gap_cor_exponent_sensitivity,
  gap_cor_cross_scale_nonsub,
  -- Group G: 17 additional propositions/theorems for paper coverage


  gap_thm_decomposition, gap_prop_axis_independence, gap_prop_relaxation,
  gap_prop_two_anchors, gap_prop_uw_subsumes, gap_prop_mu_reachability,
  gap_prop_taylor_F, gap_prop_long_cycle, gap_thm_tension_cycle,
  gap_prop_robustness_extension, gap_prop_era_from_tech,
  gap_prop_cross_scale_portability, gap_prop_strange_as_era_varying,
  gap_prop_strict_nesting, gap_prop_two_axis_reduction,
  gap_prop_four_axis_reduction, gap_prop_fourth_axes,
  -- Group H: paper-coverage entries


  gap_thm_threshold_case_specific, gap_def_structural_tension,
  -- Group I: paper-empirical + structural-extension claims


  gap_rem_hss_D_positivity, gap_eq_corrected_elasticity,
  gap_rem_kl_projection_mle, gap_rem_permutation_test,
  gap_rem_hawkes_alternative, gap_rem_pre_register_regime_density,
  -- Group J: model extensions (R8/R9)


  gap_rem_model_extension_multi_axis,
  gap_rem_model_extension_hmm,
  gap_rem_model_extension_queue,
  -- Group K: model extensions — implementations of queued proposals


  gap_rem_model_extension_state_dependent_decay,
  gap_rem_model_extension_translog,
  gap_rem_model_extension_two_timescale,
  -- Group L: model extensions — combined extension + inhibitory Hawkes


  gap_rem_model_extension_combined_joint_fit,
  gap_rem_inhibitory_hawkes_specific_kernel,
  -- Group L.1: IG first-passage MLE — gap aggregator non-degeneracy patch


  gap_rem_ig_first_passage_mle,
  -- Group L.2: VAR spectral test — gap info-era m=3 empirical patch


  gap_rem_var_spectral_test_info_era,
  -- Group L.3: 4th-axes info-era theoretical re-audit — gap structural complement


  gap_rem_fourth_axes_info_era,
  -- Group L.3.1-5: 5 sibling endomorphism entries ( status: all gapClosed


  -- via Cat 1 bridge composition with Cat 3 isComplement premises)


  gap_predicate_K_AI_compute_isEndomorphism,
  gap_predicate_K_data_isEndomorphism,
  gap_predicate_algorithmic_rule_shaping_isEndomorphism,
  gap_predicate_AI_augmented_demographic_isEndomorphism,
  gap_predicate_soft_power_via_platforms_isEndomorphism,
  -- Group L.4: Cat 2 Hodge-style ports (close -flagged Cat 2 ↔ Cat 3 disconnects)


  gap_def_IGDensity,
  gap_axiom_IGCDF,
  gap_def_NickellBiasFormula,
  -- Group L.5: theory optimization — cardinal-calibration identification via cross-coupling


  gap_axiom_R35_cardinal_identification,
  -- Group L.3.6-10: 5 sibling isComplement Cat 3 inputs ( split-axiom refactor)


  gap_predicate_K_AI_compute_isComplement,
  gap_predicate_K_data_isComplement,
  gap_predicate_algorithmic_rule_shaping_isComplement,
  gap_predicate_AI_augmented_demographic_isComplement,
  gap_predicate_soft_power_via_platforms_isComplement,
  -- Group M: component predicates of IsLeakageAxisIndependent disjunction 


  gap_predicate_uniform_discrimination_loading,
  gap_predicate_special_rank1_fungibility_form,
  -- Group N: thm:exponent-derivation Step 1 / Step 2 / Step 3 typed scaffolding 


  gap_predicate_small_coupling_regime,
  gap_predicate_slow_envelope_amplitude_formula,
  gap_predicate_survival_weight_boxed_formula,
  -- Group O: cor:exponent-sensitivity 3-residual location predicates 


  gap_predicate_residual_c_located_in_delta_NU_hysteresis,
  gap_predicate_residual_b_located_in_rent_load_MU,
  gap_predicate_residual_a_located_in_rent_load_PI,
  -- Group P: prop:axis-independence part-(a) Sard predicate 


  gap_predicate_sard_regular_value_set_open_dense,
  gap_axiom_sard_critical_value_set_measure_zero,
  gap_predicate_phi_is_c1_and_non_degenerate,
  gap_axiom_regular_value_set_open_and_dense_from_ift,
  -- Group Q: prop:cross-scale-portability 4 firm-level facet predicates 


  gap_predicate_firmlevel_cobb_douglas_form_transfers,
  gap_predicate_firmlevel_three_axis_decomp_transfers,
  gap_predicate_firmlevel_nonsubstitutability_transfers,
  gap_predicate_firmlevel_exponent_shift_direction,
  -- Group R: decomposition atoms (3 thm_threshold + 2 thm_tension_cycle + 1 prop_taylor_F)
  gap_atom_threshold_focal_factor_bound,
  gap_atom_threshold_nonfocal_factor_bound,
  gap_atom_threshold_factors_combine,
  gap_axiom_paper_pdmp_lowfreq_band,
  gap_atom_paper_pdmp_satisfies_spectral_hypotheses,
  gap_axiom_paper_prop_taylor_F,
  -- Group R bis: forward-use cardinal entries
  gap_axiom_forward_use_cardinal_w_hat,
  gap_axiom_w_hat_vindicated_over_headline,
  -- v4: PPP-alignment + third-party validation
  gap_axiom_influence_ppp_alignment,
  -- v4.1-v4.4: cardinal-invariance + firm-level + era-table + Cat 2 third-party
  gap_axiom_p5_p6_cardinal_invariance,
  gap_axiom_firm_level_cardinal_robustness,
  gap_axiom_era_table_w_hat_recovery,
  gap_axiom_lowy_2024_api,
  gap_axiom_pardee_2024_rnp,
  -- Group S: paper-label coverage backfill
  gap_def_system,
  gap_def_reachable,
  gap_def_influence,
  gap_def_three_projections,
  gap_lem_three_projections_alias,
  gap_def_normalizations,
  gap_def_three_contest_game,
  gap_def_tullock_csf,
  gap_def_pi,
  gap_def_mu,
  gap_def_nu,
  gap_def_hegemonic_ss,
  gap_def_hazard,
  gap_prop_translog_vs_cobb_douglas,
  gap_rem_a0_prior,
  gap_rem_axiom_economy,
  gap_rem_axis_vs_composite,
  gap_rem_carr_center_manifold,
  gap_rem_decay_calibration,
  gap_rem_finite_share_elasticity,
  gap_rem_info_motivation,
  gap_rem_invariance,
  gap_rem_khasminskii_stochastic_stability,
  gap_rem_long_cycles,
  gap_rem_mrs_clarification,
  gap_rem_mu_protocol,
  gap_rem_nu_protocol,
  gap_rem_operational_projections,
  gap_rem_pi_protocol,
  gap_rem_replicator_ess,
  gap_rem_set_not_scalar,
  gap_rem_shock_direction,
  gap_rem_trefethen_pseudospectra,
  gap_rem_units,
  gap_rem_why_three
]

/-- Filter ledger entries by status. -/
def filterByStatus (s : GapStatus) : List LedgerEntry :=
  allEntries.filter (fun e => e.status = s)

/-- Count ledger entries by status. -/
def countByStatus (s : GapStatus) : Nat :=
  (filterByStatus s).length

/-- Filter ledger entries by source-of-truth category. -/
def filterByInputCategory (c : InputCategory) : List LedgerEntry :=
  allEntries.filter (fun e => e.inputCategory = c)

/-- Count ledger entries by source-of-truth category. -/
def countByInputCategory (c : InputCategory) : Nat :=
  (filterByInputCategory c).length

/-- One cell of the status × input-category cross-table. -/
def countByStatusAndInputCategory (s : GapStatus) (c : InputCategory) : Nat :=
  (allEntries.filter (fun e => e.status = s ∧ e.inputCategory = c)).length

/-- Entries violating the `gapClosedConditional ↔ conditionalOn ≠ []`
 invariant. This should evaluate to `[]`. -/
def conditionalInvariantViolations : List LedgerEntry :=
  allEntries.filter (fun e =>
    (decide (e.status = GapStatus.gapClosedConditional)) != (!e.conditionalOn.isEmpty))

/-- Total ledger entries. -/
def totalCount : Nat := allEntries.length

end InfluenceCapacity.Ledger
