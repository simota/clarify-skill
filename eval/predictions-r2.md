# Round 2 prediction — frozen before the edit

Base: commit f5d7365 (merge of the round-1 policy fixes).
This file is committed before any canonical skill text changes, and its counterevidence is not
edited afterwards. The cases are the same 128 in `cases.md`; neither their oracles nor their
contexts are changed for this round.

Method: the same manual contract-witness reading as `methodology.md` — a rule interpretation
traced against each case's stated context. It is not a CLI or model rollout. The reader of the
after-edit text is also the author of the edit, which is a weaker check than round 1's frozen
archive; the results file says so instead of hiding it.

Round 1 left 23 cases `still-ambiguous`. This round targets 21 of them. C045 (binding guide vs
past preference, with no stated exception authority) and C103 (owner contract unavailable) are
left as they are: the first is an oracle dispute, the second has no gold label.

## P6 — an owning skill's dialogue is not repeated, and a missing owner is not a stall
If the trigger list competes with installed owner skills, a rule that defers to an owner whose
contract already includes the clarifying dialogue or diagnosis should make C099–C102, C109,
C111 and C112 hand off once without a Clarify question, and a rule that a named owner is optional
should make C114 proceed with normal planning instead of stalling on an absent skill.
C105, C107, C108, C110 and C113 must keep zero questions.
Counterevidence: any of those controls gains a question, Clarify and an owner both ask the same
preference, or an absent skill is still required.

## P7 — a number-shaped word asks for the metric before anything is measured
If the `fast / snappy` row mandates measuring first, a rule that names the metric the requester
judges by — from context when it is there, as one narrow question when it is user-only — and that
treats measurement as execution work should make C104, C115, C117 and C118 ask only the metric
(or SLA), and C116 must not trigger a real payment to obtain a baseline.
Clear controls C005 and C020 keep zero questions.
Counterevidence: an invented relative target, a benchmark run inside clarification, or a metric
question on C005/C020.

## P8 — "readable from the repo" has a cost bound
If "never ask what is readable" has no discovery limit, a rule that counts evidence as readable
only when it is locatable at about the cost of the question should make C120 and C121 ask one
narrow locator after a short bounded search, without claiming to know the convention.
C042–C044 (cheaply readable sources) keep zero questions.
Counterevidence: an unbounded search justified as question avoidance, a locator question where the
source was cheap to read, or an asserted convention that was not read.

## P9 — show-instead-of-ask is limited to cheap, local, side-effect-free candidates
If prototype cost and ownership are unspecified, restricting show-instead-of-ask to candidates that
are cheap, local and free of external calls, fees and writes outside the working tree should make
C122 and C123 ask the concrete preference question instead of generating paid or external
candidates. C124 may still offer two short local openings.
Counterevidence: a paid or external candidate built as a free question, or C124 losing its cheap
shown pair.

## P10 — while waiting, only decisionally independent work moves
If "everything independent proceeds" admits technically independent work that bakes in an open
answer, a rule that moves only work whose content is the same under every remaining answer should
make C125 hold the storage-dependent tests, filenames and docs vocabulary, while still moving
what does not depend on the choice, and report what waits instead of implying background waiting.
Counterevidence: tests or docs that assume one storage option before the answer.

## P11 — lock fields carry the grounded meaning, a real bound, and an honest acceptance
If mandatory `Not doing`, literal-copy intent and third-party-only acceptance are over-strong:
- C126 should state the bound of a fully bounded edit instead of inventing an adjacent non-goal,
  and its tone should be accepted by the requester, not by a character count;
- C127 should keep the requester's words in Intent and add the grounded observable meaning, not
  the vague word alone;
- C128 should separate objective checks from the requester's subjective sign-off, and never
  present a mechanical pass as tonal acceptance.
Counterevidence: an invented non-goal, a literal "make it nice" intent with nothing grounded, or a
mechanical proxy reported as subjective acceptance.

## P12 — a shut gate is not announced on an auto-selected run
The gate-shut status line is user-visible noise on C001–C032 when nobody asked for Clarify.
Emitting it only on explicit invocation should remove that noise from auto-selected clear requests
while keeping the Removal condition checkable from explicit invocations.
Counterevidence: an explicitly invoked run that shuts silently, or an auto-selected clear request
that still prints a status line.

## Scope cap
P6–P12, plus contradictions found while reading the text against itself (approval scope,
restatement, output language, the rejection row's fixed count). No new phase, no new evaluative
word, no external skill dependency. C045 and C103 stay `still-ambiguous`.
