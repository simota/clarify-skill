---
name: clarify
description: "Turning a subjective request into an instruction both sides would agree to: the intent in the requester's own words plus a done-condition somebody else could check. Grounds the evaluative word from context first, asks only the residue that would change the deliverable, and locks the result. Use when the ask is 'make it nice', 'clean this up', 'do it properly', or 'that's not quite it'. Don't use for a request that already states its intent and how it will be judged."
---

<!--
CAPABILITIES_SUMMARY:
- ambiguity_detection: Decide whether a request has an achievement condition at all, and refuse to fire when it does
- context_grounding: Resolve evaluative words from the artifact, neighbouring code, repo conventions, and prior corrections before asking anything
- question_budgeting: Size the number of questions from reversibility x blast radius, never from how unclear the request feels
- bounded_asking: Emit closed choices with a recommended default, each option stating the difference in the deliverable
- prototype_as_question: Replace a question with two concrete candidates where taste is cheaper to see than to describe
- instruction_lock: Produce a locked instruction with an observable done-state, acceptance check, exclusions, and the defaults taken
-->

# Clarify

> **"A question is a cost. Ask only what the context cannot answer."**

Owns the interval between a subjective request and the first line of work — and only that
interval. It converts "make it nice" into one instruction **both sides would agree to** and
hands it to whoever executes, which is usually itself, one line later: the lock is the
boundary between the two jobs, not a stopping point. **Clarify never widens the request, and
it never counts the work it then does as part of clarifying.** Five phases, a question budget
that is often zero, and a lock that names every default taken.

**Clear means agreeable, not merely measurable.** An instruction is finished when the
person who asked can read it and say *yes, that is what I meant* — the intent stated in
their terms, and a done-condition a third party could check. Either half alone fails:
a measurable criterion serving the wrong intent is precise and useless, and a shared
intent with no checkable condition is a mood two people happen to share.

**Principles:** Ground before asking · Closed choices, never open questions · Defaults over deadlock · Show instead of ask · Repeated vagueness is delegation

## Trigger Guidance

Use Clarify when the request is:
- an evaluative word with no achievement condition — make it nice / clean this up / do it properly / whatever you think / make it modern / easier to use / faster
- concrete in verb but unbounded in scope — "refactor this" with no line drawn
- a rejection of prior work stated as a feeling — "not quite it" / "something is off"
- a delegation that will become expensive to undo — irreversible, outward-facing, or wide

Route elsewhere when the task is primarily:
- the problem itself is unstated and a plan is wanted: `planning-frame`
- a whole feature needs a frozen spec with acceptance criteria: `spec-dialogue`
- judging whether a rendered UI actually looks good: `design-review` / `design-critique`
- deciding the visual direction once the ask is already clear: `design-direction`

**The gate — run it first.** Two sentences must be writable without inventing anything:
*what the person is actually after* (intent, in their terms), and *who looks at what, and
decides it is done* (the condition). Both write themselves → Clarify does not fire; execute
the request. **Firing on an already-clear request is the same defect as executing a vague
one.** Only one of them missing tells you which half the run is for — an intent without a
condition needs grounding, a condition without an intent needs one question.

**A shut gate still says so, in one line:** `clarify: gate shut — <the done-sentence>`. That
line is the entire output, it costs the reader nothing, and it is what makes the Removal
condition below readable — a skill that declines silently leaves no evidence it declined.

## Core Contract

- `GROUND` precedes `ASK`, always. **Asking for something the context already
  answers is the failure mode this skill exists to prevent** — the artifact, the
  neighbouring implementation, and the repo's own conventions hold most of it.
- The question count comes from the budget table below — from reversibility and
  blast radius, never from how vague the request felt.
- Every question is a closed choice, recommended option first, and **each option
  names the difference in the deliverable**, not in the abstraction. "A: wider spacing /
  B: higher density" is a choice; "what direction should the design take?" is not.
- Maximum **3 questions per round, 2 rounds total**. If the second round comes back
  vague as well, that is delegation: take the default, say which default, proceed.
  **Asking a third time is prohibited.**
- Irreversible, outward-facing, or repo-wide work gets at least one confirming
  question regardless of budget, and waits for `LOCK` approval.
- Where taste is the variable and the work is reversible, **build two candidates
  instead of asking** — a rendered pair converges faster than a paragraph.
- Never block the whole task on an answer. Everything independent of the open
  question proceeds while it is open.
- **The lock is presented, not filed.** Agreement is the finish line: the person sees the
  instruction and can object cheaply. Irreversible or outward-facing work waits for an
  explicit yes; reversible work proceeds on non-objection, with the lock stated up front so
  objecting stays cheaper than redoing.
- **Intent is restated in the requester's own words**, once, in one sentence — not
  paraphrased into agent vocabulary. A restatement they have to translate back is not a
  restatement they can agree to.
- A correction to the intent line is the cheapest possible outcome: re-ground from it,
  and do not re-interrogate the parts that were never in dispute.
- The clarified instruction is the deliverable. Do not silently expand it during
  execution — a new want found mid-run is a new request, stated as such.

## Boundaries

### Always
- Look at the actual artifact before translating any evaluative word. "Modern" has no meaning until the current screen is on the table.
- State every default taken without asking, and the ground it rests on.
- Give the locked instruction an acceptance check a third party could run.
- Write at least one exclusion — what this request explicitly does not cover.

### Ask First
- The work is irreversible, published outward, or touches shared code or config.
- Two readings of the request lead to materially different deliverables and no default is defensible.
- The request implies deleting or overwriting something you have not looked at.

### Never
- Ask an open question ("what would you like to do?", "what matters most?") — it moves the work back to the person who asked precisely because they did not want to do it.
- Re-interrogate the parts of the request that were already specific.
- Ask about anything readable from the repo, the diff, the conversation, or the file in front of you.
- Translate an evaluative word through a fixed dictionary without inspecting the target.
- Hold all work hostage to an unanswered question.
- Turn a small reversible ask into a specification exercise.

## Workflow

`GATE → GROUND → RESIDUE → ASK → LOCK`

| Phase | Focus | Required check | Read |
|-------|-------|----------------|------|
| `GATE` | Does this need clarifying at all | Neither the intent sentence nor the done-sentence writes itself | `reference/detect.md` |
| `GROUND` | Fill from context, in source order | Every filled item names its source | `reference/grounding.md` |
| `RESIDUE` | What genuinely remains open | Each residue changes the deliverable | `reference/grounding.md` |
| `ASK` | Closed choices within budget | Recommended default is first, and viable | `reference/questions.md` |
| `LOCK` | One instruction both sides agree to | Intent is stated in their words; the acceptance check is runnable by another person | `reference/lock.md` |

## Question Budget

| Blast radius \ Reversibility | Reversible | Irreversible / outward-facing |
|---|---|---|
| **Small** (one file, a few lines, a local look) | **0 questions.** Take the default, state the **short lock** (one line, `reference/lock.md`), and let the artifact be the answer | 1 question — confirmation only |
| **Large** (structure, many files, expensive to redo) | 1 question — direction only | Up to 3 questions, then `LOCK` waits for approval |

A budget of zero is a real answer, not a shortcut. **The person said "make it nice"
because they were delegating**; spending three questions on a ten-minute reversible
change bills them for your uncertainty.

## Translating the Evaluative Word

Eight evaluative words, and the axis each one is actually pointing at. The right column
is the default when nothing in context contradicts it. Read the artifact first — this
table says *which axis to look along*, never what to conclude.

| Word | Axis it actually names | Default filling |
|---|---|---|
| nice / clean | agreement with what is already there | neighbouring code / screen is the spec |
| modern / slick | spacing, hierarchy, restraint of colour | existing tokens; none → two candidates |
| properly / solid | the verification that is missing | match the repo's existing bar (tests, error paths, types) |
| fast / snappy | a number: p95, bundle size, cold start | measure now, target stated relative to now |
| easy to use | steps and hesitation on one named task | pick the single primary path, fix that |
| whatever / up to you | explicit delegation | shortest correct implementation, shown afterwards |
| not quite it | an unnamed delta in the last artifact | inspect it, propose three candidate deltas, ask once |
| refactor this | which property improves, and the bound | one property, one module, behaviour identical |

The rows are keyed on the axis, not on the vocabulary, so a request in another language
lands on the same row — `reference/detect.md` carries the mapping for the one language
this skill is most often asked in.

## Gotchas

- **Over-clarifying is the dominant failure**, not under-clarifying. Three questions on a reversible thirty-line change reads as refusal to work.
- **A second vague answer means "you decide."** Treat it as an answer, take the default, and say so in one line. Re-asking after it burns the delegation.
- **Options that differ only in adjective are not options.** If the reader cannot picture two different artifacts, the question is unasked.
- **The specific parts of a request are load-bearing.** "Make the header spacing nice" is vague about the amount only — scope, target, and intent are already given. Clarify the residue, not the sentence.
- **Show beats ask on taste, but not on cost.** Two candidates are a question only where building the second is cheap.
- **An unanswered question is not a stop.** Do everything it does not gate, and say what waits on it.
- **`LOCK` is a ceiling, not a floor.** Finding more to improve mid-run is a new request, offered in one line, not absorbed.

## Lifecycle

- **Failure:** work started under an evaluative word that had no achievement condition, producing an artifact that is rejected for reasons nobody could have stated in advance — and its mirror, a delegated small task answered with an interrogation.
- **Effect:** every run ends in an instruction with a third-party-runnable acceptance check, or in a shipped default with the default named. It does not decide *what looks good* (`design-review`), and it does not plan work (`planning-frame`).
- **Owner:** repository owner; the budget table and the translation table are the parts that move.
- **Removal:** delete when ten consecutive invocations close at `GATE` — both sentences wrote themselves, and the skill's only effect was a line saying so. Read the last ten transcripts that name it; no counter has to exist for that to be checkable.

## Done when

The intent is one sentence the person who asked would sign, the done-state is observable,
the acceptance check is runnable by somebody else, every silent default is named with its
source, and the whole thing has been put in front of them cheaply enough to object to.
**Agreement is the test, and measurability is how agreement is made possible** — not a
substitute for it.

## Output Requirements

The clarification emits one of three shapes, and nothing else:

| Run | Output |
|---|---|
| The gate stayed shut | one line: `clarify: gate shut — <the done-sentence>` |
| Zero questions, nothing open | one line naming what was read, then the **short lock** — one line carrying every field (`reference/lock.md`) |
| Everything else | that same line, then the questions (up to three closed choices, recommended first), then the full `LOCK` block |

**The work then proceeds under the lock and reports as itself.** "Nothing else" bounds this
output, not the run: on the zero-question path the artifact is what the person is waiting for,
and withholding it to stay inside a format would be the failure this skill is named against.

Ceiling: a zero-question run is two lines before the work starts. Never restate
the request back to the person who wrote it. Output language follows the CLI global
config; identifiers, paths, and commands stay in English.

## Reference Map

| File | Read this when... |
|------|-------------------|
| `reference/detect.md` | Deciding whether the gate opens, and which class of vagueness it is |
| `reference/grounding.md` | Filling from context: source order, what each source can settle, and what counts as residue |
| `reference/questions.md` | Writing the choices — good and bad shapes, and the two-round rule |
| `reference/lock.md` | Writing the locked instruction |
| `reference/traps.md` | Before a run that feels like it needs many questions |

---

> The clarified instruction is the artifact. If it needed three questions, it needed one.
