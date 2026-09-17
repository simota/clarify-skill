# lock — the instruction this skill produces

Purpose: the required fields of the locked instruction, and what each must carry.
Read at `LOCK`.

## Block

```markdown
## Locked instruction
- Intent: <one sentence, in the requester's own words: what they are actually after>
- Target: <file / screen / range — where the change stops>
- Done state: <observable state after the change, no adjectives>
- Acceptance: <who runs or looks at what, and what result settles it>
- Not doing: <at least one — the tempting adjacent thing>
- Defaults taken: <item — value — basis (artifact / neighbour / convention / prior turn / delegated discretion)>
- Open: <unresolved item and the work it gates> | none
```

## Short form

On the zero-question path the full block costs more than the change it governs, so the same
fields collapse into **one line** — every slot still present, none waived:

```
lock: <intent> → <done state>; checked by <acceptance>; not touching <exclusion>; default <item = value, source>
```

Use it when the budget was zero **and** `Open` is empty. Anything open, any question asked, or
any irreversible work goes back to the full block — a line nobody can scan field by field is
the wrong shape for something that has to be argued with.

The one thing the short form may not do is drop a slot. `Not doing` in particular disappears
first when a format is squeezed, and it is the field that was holding the scope still.

The block is rendered in whatever language the run is speaking — the field set is the
contract, the labels are not. In Japanese it reads
`確定指示 / 意図 / 対象 / 完了状態 / 受入条件 / やらないこと / 採用した既定 / 未決`,
in the same order. **Never drop a field because its label translates awkwardly.**

## Field rules

- **Intent** — the sentence the person would sign. Their vocabulary, not the agent's; one
  sentence, no "and". This is the field agreement actually happens on — every other field
  is how that agreement is made checkable. **If the intent line is guessed rather than
  grounded, say so in it** ("taking the goal to be …") so disagreeing costs one word.
- **Target** — a path, a component, or a named range. "the whole thing" is not a target.
- **Done state** — must survive the adjective test: delete every evaluative word and it
  still says what will be true. `card padding is 16px, matching the list view`, not
  `the spacing is tidy`.
- **Acceptance** — a command, a visual comparison against a named reference, or a number
  against a baseline. **"you'll see it" is not an acceptance condition.** Someone other
  than the author has to be able to run it.
- **Not doing** — never empty. The exclusion is the cheapest scope control available,
  and the thing that was obviously out of scope is exactly what gets added otherwise.
- **Defaults taken** — every value taken without asking, with its source. This is the price
  of a small question budget: fewer questions, nothing hidden.
- **Open** — name unresolved items and the work they gate. A completed lock has no blocking items; an exhausted question budget does not authorize dependent work.

## Agreement

The lock is finished when the other person could disagree with it cheaply — that is the
whole point of writing it down. Whether approval is required depends on the action, not
on silence inferred before a person could respond:

| Work | Approval requirement |
|---|---|
| Reversible, small | State the lock and proceed without requiring approval. Do not record assent that was not observed. |
| Reversible, large | State the lock; proceed only on settled work. A pause or same-turn execution supplies no approval. |
| Irreversible / outward-facing | Explicit approval of the resolved action, even when publication is reversible. Reuse an existing approval only if it covers that action. |

**A correction to Intent is the cheapest possible outcome, not a failure of the run.** Re-ground
from the corrected sentence and re-lock; do not reopen the fields that were never in dispute.

## After the lock

- Irreversible or outward-facing work waits for approval of the resolved action. Other work proceeds only within the settled lock; blocking inputs stay unresolved.
- The lock is a ceiling. A further improvement found while working is offered in one
  line and left to the person — absorbing it silently converts "make it nice" into an
  unrequested rewrite, which is the original failure with better intentions.
- If execution proves a locked item impossible, say so and re-lock that item only. Do
  not restart the whole clarification.
