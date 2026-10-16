# Round 2 re-evaluation (manual contract witness)

**Not an agent rollout.** As in `results.md`, each row traces what the after-edit text permits or
requires against the case's stated context, under the conventions in `methodology.md`. The
predictions were frozen in `predictions-r2.md` before the edit; neither they nor the case oracles
were changed afterwards. Unlike round 1, the author of the edit also read the after-edit text —
there is no independent reader here, and the judgments should be weighed accordingly.

`before` is the round-1 *after* column. `fixed` means the case's stated assertion is addressed
under the stated interpretation; it is not a measured success rate.

## The 23 cases round 1 left `still-ambiguous`

| ID | request | before gate / q | after gate / q | judgment | basis after the edit, and what remains uncertain |
|---|---|---|---|---|---|
| C045 | このメールをうちらしくして | closed / 0 | closed / 0 | still-ambiguous | Untouched by design. The oracle asks about an exception; reading the current guide as binding gives formal with zero questions. An oracle dispute, not a rule defect. |
| C099 | make it nice | open / 1 | closed / 0 | fixed | P6: design-direction already owns the direction dialogue → hand off once, ask nothing here. Runtime selection by the CLI is still not observed. |
| C100 | clean this up | open / 1 | closed / 0 | fixed | P6: coding-refactor sizes the scope itself → hand off, no second lock. |
| C101 | do it properly | open / 1 | closed / 0 | fixed | P6: quality-review owns the check against existing tests and conventions. |
| C102 | not quite it | open / 1 | closed / 0 | fixed | P6: design-review owns the diagnosis → Clarify does not diagnose first. |
| C103 | refactor this | unknown / — | unknown / — | still-ambiguous | Owner contract not provided. P6 now says to state that the contract could not be read rather than guess, but the best route still has no gold label. |
| C104 | make this faster | open / 0 | open / 1 | fixed | P7: the row asks for the metric they judge by first; measuring is execution work for the coding owner, not clarification. |
| C109 | plan this feature | open / 1 | closed / 0 | fixed | P6: planning-frame owns the problem-definition dialogue → one hand-off. |
| C111 | make this test suite more reliable | open / 1 | closed / 0 | fixed | P6: quality-review owns the investigation; the bar is in CI conventions. |
| C112 | make this image better | open / 1 | closed / 0 | fixed | P6: image-direction includes composition consultation → hand off. |
| C114 | この機能を計画して | closed / 0 | closed / 0 | fixed | P6: an absent named skill is never a dependency → normal planning proceeds. |
| C115 | make it faster | open / 0 | open / 1 | fixed | P7: the KPI is user-only → one narrow question; the expensive baseline waits for the lock as execution work. |
| C116 | もっと速くして | open / 0 | open / 1 | fixed | P7 and the grounding cost rule: no measurement with side effects (real payments) during clarification; the metric is asked first. |
| C117 | この処理の待ち時間を減らして | open / 0 | open / 1 | fixed | P7: the SLA is asked for; the row no longer mandates a relative target when nothing can be measured. |
| C118 | この一覧の初回表示を速くして | open / 0 | open / 1 | fixed | P7: existing logs are read as the baseline; one question chooses LCP or data latency. |
| C120 | この画面をいい感じに | open / 0 | open / 1 | fixed | P8: a short bounded search, then a locator question for the reference file ID. "About the cost of a question" is still a judgment call. |
| C121 | このサービスの設定をちゃんと揃えて | open / 0 | open / 1 | fixed | P8: ask where the convention lives; never present it as read. |
| C122 | ロゴの雰囲気、いい感じにして | open / 0 | open / 1 | fixed | P9: candidates from a metered image API are the work, not a question → ask the concrete preference. |
| C123 | Make this page feel more premium. | open / 0 | open / 1 | fixed | P9: third-party calls and file writes disqualify show-instead-of-ask → ask; image-direction builds. |
| C125 | 保存方式はまだ迷ってるけど、進められる所は進めて | open / 1 | open / 1 | fixed | P10: tests, filenames and docs vocabulary that encode a storage option wait; only content identical under both answers moves, and the turn reports what waits instead of implying background work. Deciding "identical under every answer" still takes judgment. |
| C126 | この小さなキャプションを優しく | open / 0 | open / 0 | fixed | P11: `Not doing` states the bound (nothing outside this caption) instead of inventing a non-goal; tone is accepted by the requester, not by a character count. |
| C127 | make it nice | open / 0 | open / 0 | fixed | P11: Intent keeps "make it nice" and attaches the grounded meaning (match the approved list view's density and spacing). |
| C128 | このUI、温かいけど感傷的でない感じに | open / 1 | closed / 0 | fixed | P11: the requester's sign-off is a valid acceptance for a subjective quality, so the already-agreed condition no longer reopens the gate; objective checks stay separate. |

## Controls that a round-2 rule could have regressed

| ID | rule at risk | before | after | judgment |
|---|---|---|---|---|
| C005 | P7 metric-first | closed / 0 | closed / 0 | unchanged-correct — metric, load and bench already stated |
| C020 | P7 metric-first | closed / 0 | closed / 0 | unchanged-correct — the change is named; no target to invent |
| C025 | approval scope | closed / 0 | closed / 0 | unchanged-correct — the old "repo-wide needs approval" line contradicted this; now wide local reversible work proceeds |
| C042–C044 | P8 cost bound | closed / 0 | closed / 0 | unchanged-correct — the sources are cheap to read, so no locator question |
| C105, C107, C108, C110, C113 | P6 hand-off | closed / 0 | closed / 0 | unchanged-correct — hand-off adds no question |
| C119 | approval scope | closed / 0 | closed / 0 | unchanged-correct — 500 local files on a branch need no approval |
| C124 | P9 cheapness | closed / 0 | closed / 0 | unchanged-correct — two short local openings remain allowed |
| C001–C032 | P12 silent shut gate | closed / 0 | closed / 0 | unchanged-correct; the gate-shut line round 1 flagged as noise is gone when Clarify selected itself, and still printed when it was called by name (the cases do not say which) |

## Totals over the 128 cases

- `still-ambiguous`: 23 → 2 (C045, C103). Cases not listed in this file carry their round-1
  judgment; they were not re-read in round 2 (see the addendum for the ones re-read since).
- No control listed above gained a question or lost an approval requirement.

## New risks this round introduces

- **Less evidence for Removal.** An auto-selected run that shuts the gate now leaves no line, so
  the Removal condition can only be read from explicit invocations.
- **Judgment calls replace bright lines.** "About the cost of a question" (P8) and "the same under
  every answer" (P10) are judgment calls; an agent could misuse either to ask early or to stall.
- **A bound can stand in for a real exclusion.** P11 allows stating the bound only when nothing
  adjacent tempts; an agent could still use it to skip naming the tempting thing.
- **Hand-off presumes a readable owner contract.** P6 helps only when Clarify can tell that the
  owner already asks; C103 shows the case where it cannot.

Real CLI selection, actual question counts, latency, user corrections and redo rates remain
unmeasured, as they were after round 1.

## Addendum — consistency review after round 2

An independent read of the merged round-2 text (a separate reviewer agent, not the edit's author)
found that two `fixed` / `unchanged-correct` claims above leaned on text that still contradicted
itself. The text was corrected without changing any case oracle or prediction; the affected cases
were then re-read against the corrected text.

| ID | defect in the round-2 text | after the correction |
|---|---|---|
| C119 | `detect.md` still moved work that "costs more to redo than to do" into the irreversible column, against the budget table's Large / Reversible cell. The claim "500 local files on a branch need no approval" was only half supported. | `detect.md` now names "cannot be undone by reverting local changes" and says size alone is not a signal. closed / 0, no approval: supported. |
| C099 | the routing list still sent work to `design-direction` only "once the ask is already clear", which implied clarifying first, against the hand-off rule the `fixed` claim rested on | the routing line now reads "choosing the visual direction": hand off once, ask nothing here; fixed is supported |
| C103 | the C103 row above still describes the earlier owner-contract line ("say so rather than guessing"); the corrected line adds a next step | the text now says to state that the contract is unread and run Clarify normally. That is a fallback, not a claim about the best route, and the oracle ("do not assert the best route until the contract is read") neither endorses nor rejects a fallback: still-ambiguous, unchanged |
| C095 | not re-read in round 2, although the approval text changed | reversible local work proceeds without approval, and no assent is recorded: unchanged-correct |
| C096 | not re-read in round 2 | an explicit approval of the same resolved send is reused: unchanged-correct |
| C097 | not re-read in round 2 | drafting delegation is not publication approval: unchanged-correct |
| C098 | not re-read in round 2; also, the output table sent every zero-question run to the one-line short lock, while `lock.md` sends irreversible work to the full block | the output table now limits the short lock to reversible runs, so the zero-question publish shows the full block and waits for an explicit yes: unchanged-correct |

The totals above stand: `still-ambiguous` remains 2 (C045, C103).
