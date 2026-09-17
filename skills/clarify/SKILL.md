---
name: clarify
description: "Turning a subjective request into an instruction both sides would agree to: the intent in the requester's own words plus a done-condition somebody else could check. Grounds the evaluative word from context first, asks only the residue that would change the deliverable, and locks the result. Use when the ask is 'make it nice', 'clean this up', 'do it properly', or 'that's not quite it'. Don't use for a request that already states its intent and how it will be judged."
---

<!--
CAPABILITIES_SUMMARY:
- ambiguity_detection: Decide whether a request has an achievement condition at all, and refuse to fire when it does
- context_grounding: Resolve evaluative words from the artifact, neighbouring code, repo conventions, and prior corrections before asking anything
- question_budgeting: Bound preference questions without defaulting necessary user-only inputs
- bounded_asking: Use real preference choices or narrow missing-input questions; recommend only with evidence
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

**Principles:** Ground before asking · Real choices, narrow missing inputs · Grounded defaults · Show instead of ask · Respect delegation

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
one.** Only one missing bounds the run to that half. Ground it, then ask only a material
user decision that remains; one open parameter is not automatically a shut gate.

**A shut gate still says so, in one line:** `clarify: gate shut — <the done-sentence>`. That
line is the entire output, it costs the reader nothing, and it is what makes the Removal
condition below readable — a skill that declines silently leaves no evidence it declined.

## Core Contract

- `GROUND` precedes `ASK`, always. **Asking for something the context already
  answers is the failure mode this skill exists to prevent** — the artifact, the
  neighbouring implementation, and the repo's own conventions hold most of it.
- The table bounds optional preference questions, not required user-only inputs.
  Zero is normal; uncertainty alone is not a reason to spend the budget.
- Use closed choices for safely enumerable preferences; each option names the different
  deliverable. For an unknown fact or referent, ask only for that field, not invented options.
  Recommend first only when evidence favors it; otherwise present choices neutrally.
- Maximum **3 questions in round 1, 1 in round 2**. A second vague reply is delegation
  only when the person declines to choose within their delegated discretion and adds no
  unresolved constraint. Confusion, rejection or a partial answer is not delegation.
  No third clarification round: hold unresolved dependent work, never invent its answer.
- Before irreversible, outward-facing, or repo-wide work, resolve required selection
  and factual inputs, then obtain explicit approval of the resolved action. Clarification
  and approval are distinct; an existing explicit approval covering that action suffices.
- Where taste is the variable and the work is reversible, **build two candidates
  instead of asking** — a rendered pair converges faster than a paragraph.
- Never block the whole task on an answer. Everything independent of the open
  question proceeds while it is open.
- **The lock is presented, not filed.** Agreement is the finish line: the person sees the
  instruction and can object cheaply. Irreversible or outward-facing work waits for an
  explicit yes; cheap reversible work proceeds without requiring approval, with the lock
  stated up front. Proceeding in the same turn is not observed assent.
- **Intent is restated in the requester's own words**, once, in one sentence — not
  paraphrased into agent vocabulary. A restatement they have to translate back is not a
  restatement they can agree to.
- A correction to the intent line is the cheapest possible outcome: re-ground from it,
  and do not re-interrogate the parts that were never in dispute.
- The clarified instruction is the deliverable. Do not silently expand it during
  execution — a new want found mid-run is a new request, stated as such.

## Boundaries

### Always
- When a target artifact exists, inspect it before translating an evaluative word. For new work use the available specification and references; do not invent an existing artifact.
- State every default taken without asking, and the ground it rests on.
- Give the locked instruction an acceptance check a third party could run.
- Write at least one exclusion — what this request explicitly does not cover.

### Ask First
- The work is irreversible, published outward, or touches shared code or config.
- Two readings of the request lead to materially different deliverables and no default is defensible.
- The request implies deleting or overwriting something you have not looked at.

### Never
- Ask broad open-ended questions that return the work ("what would you like to do?"). A narrow missing fact or referent is different; do not invent a closed menu for it.
- Re-interrogate the parts of the request that were already specific.
- Ask about anything readable from the repo, the diff, the conversation, or the file in front of you.
- Translate an evaluative word through a fixed dictionary without inspecting an existing target or the available specification.
- Hold all work hostage to an unanswered question.
- Turn a small reversible ask into a specification exercise.

## Workflow

`GATE → GROUND → RESIDUE → ASK → LOCK`

| Phase | Focus | Required check | Read |
|-------|-------|----------------|------|
| `GATE` | Does this need clarifying at all | Either sentence needs an unsupported material decision | `reference/detect.md` |
| `GROUND` | Fill from context, respecting source roles | Every filled item names an applicable source | `reference/grounding.md` |
| `RESIDUE` | What genuinely remains open | Each residue changes the deliverable | `reference/grounding.md` |
| `ASK` | Necessary decisions within budget | Real options or narrow inputs; recommendations have evidence | `reference/questions.md` |
| `LOCK` | One instruction both sides agree to | Intent is stated in their words; the acceptance check is runnable by another person | `reference/lock.md` |

## Question Budget

| Blast radius \ Reversibility | Reversible | Irreversible / outward-facing |
|---|---|---|
| **Small** (one file, a few lines, a local look) | **0** when grounded or safely delegated; otherwise only the necessary material decision | Resolve missing inputs, then confirm the resolved action |
| **Large** (structure, many files, expensive to redo) | **0–1** preference question; required user-only inputs within the round limit | Necessary inputs within the round limit, then explicit approval |

These are maxima, not quotas. Approval is separate from clarification and cannot replace
selection of a recipient, destructive target or other missing fact. A known essential input
may use round 2; reaching the cap leaves it unresolved, not defaulted. Ordinary delegated
small work still takes the **short lock** (`reference/lock.md`) and proceeds without questions.

## Translating the Evaluative Word

Eight evaluative words, and the axis each one is actually pointing at. The right column
is the default when nothing in context contradicts it. Inspect an existing target first — this
table says *which axis to look along*, never what to conclude.

| Word | Axis it actually names | Default filling |
|---|---|---|
| nice / clean | agreement with applicable conventions | accepted neighbour within current constraints, not its defects |
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
- **Respect an actual delegation, not merely a second vague reply.** Do not re-ask delegated preferences; do not turn confusion or an unanswered fact into permission to decide.
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
| Everything else | that same line, then the necessary questions (`reference/questions.md`), then the full `LOCK` block |

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
| `reference/grounding.md` | Filling from context: source roles, what each source can settle, and what counts as residue |
| `reference/questions.md` | Writing the choices — good and bad shapes, and the two-round rule |
| `reference/lock.md` | Writing the locked instruction |
| `reference/traps.md` | Before a run that feels like it needs many questions |

---

> The clarified instruction is the artifact. Ask only the decisions context cannot settle.
