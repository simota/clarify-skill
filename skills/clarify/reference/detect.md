# detect — does the gate open, and on what

Purpose: decide whether a request needs clarifying at all, and name which class of
vagueness it carries. Read at `GATE`.

## The gate

Two sentences have to be writable about the request, without inventing anything:

> **The person is after <intent>** — in their words, not yours.
> **<who> looks at <what> and decides it is done.**

- Both write themselves → **Clarify does not fire.** Execute the request.
- Neither does → the gate opens on the full workflow.
- Only one does → that tells you which half the run is for. An intent with no condition
  needs grounding; a condition with no intent needs one question, and only one.

Firing on a clear request costs the same as executing a vague one. Both spend the
requester's attention on your uncertainty.

## Classes

Each class has a different residue, so name it before grounding.

| Class | Shape | Example | What is actually missing |
|---|---|---|---|
| **Evaluative** | judgement word, no condition | "make it nice" | the axis of judgement and its bar |
| **Unbounded** | clear verb, no edge | "clean up around here" | scope, and what must not change |
| **Delegated** | explicit hand-off | "whatever you think" | nothing — a default is the answer |
| **Rejection** | negative, unnamed delta | "not quite it" | which property of the last artifact is wrong |
| **Imported** | a word from elsewhere | "make it modern", "do it properly" | the referent — modern compared to what |
| **Quantified-sounding** | number-shaped, unmeasured | "make it faster" | the metric, the baseline, the target |

## False positives — the gate stays shut

- The vague word qualifies an already-specified change: "make the header spacing nice" fixes target, property, and intent. Only the amount is open.
- The repo answers it. A lint rule, a token set, an existing sibling implementation, or a line in the repo's agent-instructions file is an achievement condition already written down.
- The work is reversible and small enough that showing an artifact is cheaper than describing one.
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
