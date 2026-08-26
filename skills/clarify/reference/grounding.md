# grounding — fill from context before asking

Purpose: the order of sources, what each can settle, and what is left as residue.
Read at `GROUND` and `RESIDUE`.

## Source order

Stop at the first source that settles an item. Record the source with the item —
a filled value with no source is a guess wearing a fact's clothes.

| # | Source | Settles | Cannot settle |
|---|---|---|---|
| 1 | **The artifact itself** — open the file, render the screen, run the thing | which defects actually exist, and their size | what the person prefers among defensible options |
| 2 | **The neighbour** — the sibling component, the adjacent module, the last accepted output | house style, naming, density, structure | anything the neighbour is itself wrong about |
| 3 | **Declared convention** — the agent-instructions file, lint and formatter config, design tokens, type strictness | the bar the repo already holds itself to | a bar the repo has never set |
| 4 | **This conversation** — earlier corrections, rejected attempts, stated preferences | what was already ruled out; do not re-offer it | anything not yet discussed |
| 5 | **Durable memory / past feedback** | standing preferences across sessions | whether the preference still holds — verify if load-bearing |

**Rule:** an item answerable at levels 1–3 is never a question. Asking it says the
context was not read.

## Turning the word into an observable

Grounding is finished for an item when it reads as an observable state, not an
adjective:

- *nice* → *card padding matches the list view (16px), heading weight matches the sibling page*
- *properly* → *the error path has a test, as the two neighbouring handlers do*
- *fast* → *cold start is 2.4s today; target under 1.5s*
- *easy to use* → *creating an entry takes 4 taps today; target 2*

If the sentence still needs an adjective to carry its meaning, grounding is not done
and the residue is real.

## What qualifies as residue

An open item survives into `ASK` only if **both** hold:

1. different answers produce **materially different deliverables** — not different wording of the same one, and
2. **no default is defensible** from sources 1–5.

Everything else is a default. A default is taken silently in the work and named
explicitly in the `LOCK` block — that is the trade: fewer questions, full disclosure.

Rank surviving residues by how much of the deliverable turns on them, and cut to the
budget. **A residue below the cut is a default, never a dropped concern.**
