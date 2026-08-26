# clarify — a standalone skill for subjective requests

Turn "make it nice" — "clean this up", "do it properly", "that's not quite it" — into **one
instruction both sides would agree to**, using as few questions as the context allows.
Five phases, a question budget sized by reversibility rather than by how vague the request felt, and a
lock that names every default taken silently. **It clarifies; it does not widen the request.**

**Clear means agreeable, not merely measurable.** The bar is that the person who asked can read
the result and say *yes, that is what I meant* — their intent in their own words, plus a
done-condition somebody else could check. A measurable criterion serving the wrong intent is
precise and useless; a shared intent with no checkable condition is a mood two people happen to
share. The lock carries both, and it is put in front of them cheaply enough to disagree with.

Self-contained: no other skill, agent, registry, or repository is required. Everything it depends
on is in `reference/`.

> **A question is a cost. Ask only what the context cannot answer.**

## Install

The skill lives at `skills/clarify/`; that directory is what gets linked, not the repository root —
the README and the test battery stay behind.

```sh
make link                      # every agent CLI installed here
make link AGENT=codex          # just one — claude | codex | agy
make link PROJECT=/path/repo   # that repository, instead of the home directories
make status                    # where is it linked?
make unlink                    # remove the links that point at this repo
make check                     # references resolve inside the skill, counts and identifiers agree
make test                      # run the fixture battery over `make check` and `make link`
```

Three CLIs read a `SKILL.md` with YAML frontmatter, and each looks somewhere different:

| Agent | Global | Inside a project |
|-------|--------|------------------|
| `claude` | `~/.claude/skills` | `<repo>/.claude/skills` |
| `codex` | `$CODEX_HOME/skills`, default `~/.codex/skills` | `<repo>/.agents/skills` |
| `agy` | `~/.gemini/antigravity-cli/skills` | `<repo>/.agents/skills` |

`make link` symlinks `skills/clarify/` into each of them, so a `git pull` here updates every
installed copy at once. A CLI whose own directory does not exist is **skipped, not created** — and
`codex` and `agy` share `.agents/skills` inside a project, so one link there serves both.

Nothing at the destination is ever overwritten: a real directory, or a symlink into some other
checkout, is refused and left alone, and `make unlink` removes only the links pointing at this repo.
Override the destination outright with `SKILLS_DIR=<dir>` when your runtime keeps skills somewhere
none of the three names.

## Use

```
clarify make it nice           # the evaluative request
clarify clean up around here   # clear verb, no edge
clarify not quite it           # a rejection with an unnamed delta
```

Or let it trigger on its own whenever a request arrives with no achievement condition.

## What it does

`GATE → GROUND → RESIDUE → ASK → LOCK`

1. **GATE** — two sentences have to write themselves: *what the person is after*, in their words, and *who looks at what and decides it is done*. Both do → the skill does not fire, and says so in one line. Firing on a clear request costs the same as executing a vague one.
2. **GROUND** — fill the evaluative word from the artifact itself, the neighbouring implementation, and the repo's declared conventions, before asking anything.
3. **RESIDUE** — keep only the open items where different answers produce materially different deliverables *and* no default is defensible.
4. **ASK** — closed choices, recommended option first, sized by a reversibility × blast-radius budget. Zero questions is a normal outcome; two rounds is the maximum.
5. **LOCK** — the intent in the requester's own words, a target, an observable done-state, an acceptance check a third party can run, an exclusion, and every default taken silently — stated back so that disagreeing costs one word. On the zero-question path the same fields collapse into a single line. Reversible work proceeds on non-objection; irreversible work waits for an explicit yes.

### What a run emits

| Run | Output |
|---|---|
| The gate stayed shut | one line: `clarify: gate shut — <the done-sentence>` |
| Zero questions, nothing open | one line naming what was read, then the **short lock** — one line carrying every field |
| Everything else | that same line, the questions, then the full lock block |

Then the work proceeds under the lock and reports as itself. "Nothing else" bounds the
clarification, never the run: withholding the artifact to stay inside a format would be the
failure the skill is named against.

## The idea

Most clarification tooling treats questions as free and vagueness as the enemy. This one prices the
question: someone who says "whatever you think" is **delegating**, and answering a ten-minute reversible
change with three questions bills them for the agent's uncertainty. So the effort goes into reading
context, and the questions are spent only on what reading cannot settle.

- **Over-clarifying is the dominant failure**, not under-clarifying — the traps file leads with it.
- **A second vague answer is an answer.** It means *you decide*: take the default, name it, proceed. There is no third round.
- **A default is not a shortcut.** Every value taken without asking appears in the lock with its source. Fewer questions, nothing hidden.
- **Show instead of ask.** Where the variable is taste and building the second candidate is cheap, two rendered options ask the question better than any sentence can.
- **An open question is not a stop.** Everything it does not gate keeps moving.
- **A shut gate says so.** Declining is reported in one line, not silently — otherwise nobody can tell the skill has stopped earning its place.
- **The cheapest outcome is a corrected intent line.** A guessed intent stated plainly can be disagreed with in one word; a correct intent left unstated cannot.

## Layout

| Path | Purpose |
|------|---------|
| `Makefile` | `link` / `unlink` / `status` per agent CLI, plus `check` / `test` |
| `tools/check.sh` | The fixture battery `make test` runs — what keeps `make check` and `make link` honest |
| `skills/clarify/` | The skill itself — the directory `make link` symlinks |
| `docs/index.html` | The published site — one self-contained page explaining the workflow |

Paths below are relative to `skills/clarify/`.

| File | What it holds |
|------|---------------|
| `SKILL.md` | The contract: the two gate sentences, the workflow, the question budget, the three output shapes, and the translation table for eight evaluative words |
| `reference/detect.md` | The gate sentences, the six classes of vagueness, the false positives that keep it shut, and the non-English trigger mapping |
| `reference/grounding.md` | Source order, what each source can and cannot settle, and what qualifies as residue |
| `reference/questions.md` | Question shapes good and bad, the two-round rule, and show-instead-of-ask |
| `reference/lock.md` | The locked-instruction block, its one-line short form, the rule for each field, and how agreement is taken |
| `reference/traps.md` | The failure modes, over-clarifying first among them |

## Docs site

`docs/index.html` is a single self-contained page that explains the skill — the two gate sentences,
the five phases, the question budget, the translation table, and what the lock has to carry in
either of its forms. No build step, no dependencies, one file.

```sh
make pages   # serve docs/ at http://localhost:8000 to preview
```

To publish it: **Settings → Pages → Source: Deploy from a branch → `main` / `/docs`**. The site then
lives at `https://<owner>.github.io/<repo>/`.

The page is explanatory only; `skills/clarify/SKILL.md` and its `reference/` files stay canonical.
Nothing generates the page, so nothing silently drifts without a diff to review — and `make check`
reads the page with its tags stripped, so the two counts it states — five phases and eight
evaluative words, in the fact strip and in the prose alike — cannot drift from what `SKILL.md`
actually tabulates.

## What `make check` holds still

Counts catch an added row; they are blind to a rename, which is why the check matches
identifiers across files as well. Five things have to agree before it exits zero:

| Checked | Fails when |
|---|---|
| Every cited `*.md` path | it does not resolve inside `skills/clarify/`, or reaches through a parent |
| Every file in `reference/` | `SKILL.md` never names it |
| The phase count | prose or the published page claims a number the Workflow table does not tabulate |
| The evaluative-word count | the same, against the translation table |
| Three identifiers | the frontmatter `name` leaves the directory name behind · the phase chain and the Workflow table name different phases · `reference/detect.md` maps a trigger onto a row the translation table no longer defines |

`make test` mutates a throwaway copy of the tree once per rule and asserts the exit status —
a check that has quietly stopped catching something fails there instead of passing silently.
