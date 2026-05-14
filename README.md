# InfluenceCapacity Lean 4 Formalisation

[![Lean](https://img.shields.io/badge/Lean-4.16.0-blue?logo=lean)](https://leanprover.github.io/)
[![Mathlib](https://img.shields.io/badge/Mathlib-v4.16.0-green)](https://github.com/leanprover-community/mathlib4)
[![Build](https://img.shields.io/badge/lake%20build-passing-brightgreen)](#build-instructions)
[![Ledger](https://img.shields.io/badge/ledger-153%20entries-informational)](#ledger-state)
[![Sorry-free](https://img.shields.io/badge/sorry-free-success)](#lean-kernel-scope)
[![Paper](https://img.shields.io/badge/paper-SSRN%206716498-orange)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6716498)

Companion Lean 4 / Mathlib formalisation to the paper:

> Li, A. C. (2026). *Influence Capacity Beyond GDP: An Axiomatic Three-Axis
> Decomposition*. SSRN Working Paper 6716498.

The paper develops a three-axis Cobb--Douglas influence functional
$\Influence(\System) = \PI^a \cdot \MU^b \cdot \NU^c$ over productive capacity
$\PI$, mobilizable surplus $\MU$, and network position $\NU$, derived along three
converging routes (axiomatic representation, Tullock-contest microfoundation,
budget-feedback dynamics) and calibrated against eleven hegemonic transitions
plus the Saudi--US 1970 cross-section. The cardinal commitment is
$\hat w = (0.640, 0.175, 0.185)$, vindicated by PWT 11.0 G15 1957--2019 empirical
loop closure via the structural identification chain
$\gamma_m = \delta_m^{-1} \cdot |\alpha_{km}|/L_k \cdot r_m$.

## Structure

| File | Role |
|---|---|
| `lakefile.lean` | Lake project definition (Mathlib v4.16.0) |
| `InfluenceCapacity.lean` | Top-level re-export |
| `InfluenceCapacity/Types.lean` | Opaque types: `EconomicSystem`, `CapabilityAxis`, `Influence`, `Jacobian3`, `TullockParameters`, `HistoricalEra`, `IsHegemonicSteadyState`, `SmallShareRegime`, `IsAEBTopology`, `IsSelfProductiveTopology`, plus 50+ paper-source-bound `Prop` predicates for typed conclusions |
| `InfluenceCapacity/ClassicalResults.lean` | Axiomatised classical theorems used by paper proofs: Aczel 1966 multiplicative-Cauchy, Hartman--Grobman, Routh--Hurwitz 3x3, Bauer--Fike, Cox--Lewis mixed-Poisson dispersion, Topkis lattice decomposition, Cover--Thomas chain rule, Tikhonov--Fenichel slow-manifold, Tullock CSF small-share limit, finite-dim norm equivalence |
| `InfluenceCapacity/OpenHypotheses.lean` | Paper axioms (A0a/A0b, A1, A2, A4) + 5 conditional hypotheses (slow-driver-regime, special-rank-1 fungibility, ex-ante regime-assignment protocol, small-share Tullock asymptotic, time-invariant cross-couplings) |
| `InfluenceCapacity/MainTheorem.lean` | Paper theorems as sorry-free Lean declarations covering representation, A3+A5 redundancy, Tullock microfoundation, dynamics, threshold collapse, meta-collapse, regime-(i)/(ii)/(iii) collapse-sequence, AEB, exponent-derivation, three-axes, hegemonic-margin, ex-ante-protocol corollaries, non-substitutability, the cardinal vindication chain (`prop:identification-chain`, `lem:ig-mle-identification`, `thm:pwt-loop-closure`, `prop:frequency-scope`), and the corresponding successor-model direction predicates |
| `InfluenceCapacity/Ledger.lean` | Typed gap ledger: every paper axiom, theorem, proposition, lemma, corollary, definition, and remark is registered with status (`gapOpen` / `gapPartial` / `gapBlocked` / `gapDeadEnd` / `gapClosed` / `gapClosedConditional` / `gapDefinitional`), input category (Cat 0 kernel / Cat 1 Mathlib / Cat 2 external published / Cat 3 paper-novel), Cat 3 sub-type per the §3.4 six-canonical taxonomy (carrier, hypothesis-predicate, structural-defining-equation, working-assumption, conditional-hypothesis, phenomenological-conjecture), and attack history |

## Ledger state

153 entries total. Strict trust discipline: the source compiles
sorry-free under `lake build`. Closure rests on either Mathlib lemmas, typed
classical-axiom discharge, explicit witness construction, or paper-bound axioms
that decompose monolithic claims into single-step typed bridges.

| Status | Meaning |
|---|---|
| `gapClosed` | Sorry-free Lean closure via classical-axiom discharge, real Mathlib proof, inductive-type plus rfl, explicit witness, or discharge to a paper-novel primitive axiom |
| `gapClosedConditional` | Sorry-free under explicit `Hyp_*` broken-link predicates surfaced by `#print axioms` |
| `gapPartial` | Structurally decomposed; substantive bodies or per-case witnesses still pending |
| `gapBlocked` | Blocked by missing carrier construction or absent calibration data |
| `gapDeadEnd` | Falsified or no-go routes preserved for planning |
| `gapDefinitional` | Paper definition, scope predicate, or starting commitment that is not a closure target |
| `gapOpen` | Load-bearing axiom, conditional hypothesis, external-method placeholder, or working assumption awaiting derivation |

Live counts via `#eval countByStatus` (`InfluenceCapacity.Ledger.countByStatus`)
and `#eval countByInputCategory`. The ledger is the canonical source of truth;
narrative summaries in this README and elsewhere may drift behind the live
state.

## Lean kernel scope

The Lean kernel verifies the deductive structure of the axiomatic apparatus
and the algebraic reductions: representation theorem, A3+A5 axiom-economy
redundancies, Tullock-CSF small-share limit, non-substitutability, three-axes
spectral count, and the qualitative meta-collapse ordering theorem. It does
not verify the empirical content -- the survival-weight cardinal $\hat w$,
the 9-strict-match ex-ante ordering verdict, the PWT empirical loop closure,
or the prediction registry (P1)--(P6) -- which rest on the companion Python
validation scripts and remain falsifiable against future data.

## Build instructions

```bash
cd lean4-formalization
lake exe cache get    # download Mathlib pre-built cache (do NOT rebuild Mathlib)
lake build            # builds InfluenceCapacity in O(seconds) given cache
```

## References

Paper-cited classical results axiomatised in `ClassicalResults.lean`:

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

## License

This formalisation accompanies the paper above and inherits its citation and
reuse terms. For collaboration inquiries, contact the author via the SSRN
working-paper page.
