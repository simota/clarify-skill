# detect — does the gate open, and on what

Purpose: decide whether a request needs clarifying at all, and name which class of
vagueness it carries. Read at `GATE`.

## The gate

Two sentences have to be writable about the request, without inventing anything:

> **The person is after <intent>** — in their words, not yours.
> **<who> looks at <what> and decides it is done.**

- Both write themselves → **Clarify does not fire.** Execute the request.
- Neither does → the gate opens on the full workflow.
- Only one does → ground that half; ask only the material user decision still missing.
  A shut gate does not waive the executor's authorization for an external or destructive action.

Firing on a clear request costs the same as executing a vague one. Both spend the
requester's attention on your uncertainty.

## Classes

Each class has a different residue, so name it before grounding.

| Class | Shape | Example | What is actually missing |
|---|---|---|---|
| **Evaluative** | judgement word, no condition | "make it nice" | the axis of judgement and its bar |
| **Unbounded** | clear verb, no edge | "clean up around here" | scope, and what must not change |
| **Delegated** | explicit hand-off | "whatever you think" | only choices outside the delegated discretion, unknown facts or approval |
| **Rejection** | negative, unnamed delta | "not quite it" | which property of the last artifact is wrong |
| **Imported** | a word from elsewhere | "make it modern", "do it properly" | the referent — modern compared to what |
| **Quantified-sounding** | number-shaped, unmeasured | "make it faster" | the metric, the baseline, the target |

## False positives — the gate stays shut

- The vague word qualifies an already-specified outcome: "set the header padding to 16px so it looks nice". "Make the header spacing nice" fixes the target and property, not necessarily the amount or condition. Keep only that residue.
- Applicable context selects the desired state. A token scale or a sibling's mere existence is not a choice among its values; check authority and conflicts in `reference/grounding.md`.
- A small reversible draft is safely delegated and cheaper to show, with no missing user-only fact or authority. Size alone does not settle ambiguity.
- The person has decided and is asking for execution. Clarifying then is a refusal in polite clothing.

## Signals that raise the class, not the question count

Presence of any of these moves the request into the irreversible column of the
budget table — it does not license a longer interrogation:

- writes outside the working tree, publishes, sends, or deploys
- deletes or overwrites something not yet read
- touches shared config, schema, or a public interface
- costs more to redo than to do

## The same words in another language

The classes are about the missing achievement condition, not the vocabulary, so they hold
in any language — and the translation table in SKILL.md is keyed on the axis, not on the
word. **This section is the one place the skill carries non-English triggers**, because a
request rarely arrives in the language the skill was written in.

| Japanese | Lands on the row |
|---|---|
| いい感じに / きれいに | nice / clean |
| モダンに / かっこよく | modern / slick |
| ちゃんと / しっかり | properly / solid |
| 速く | fast / snappy |
| 使いやすく | easy to use |
| 適当に / よしなに | whatever / up to you |
| なんか違う | not quite it |
| リファクタして | refactor this |

Two traps specific to a language with no articles and frequently dropped subjects: the
request often omits **which thing** entirely — 「きれいにして」 names no target, so scope is
residue by default — and 「よしなに」 is a stronger delegation than "whatever you think",
not a weaker one. Neither changes the workflow; both change what grounding has to recover.
