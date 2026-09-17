# Evaluation records

This directory publishes the human-readable subset of the completed design review.
These are synthetic contract witnesses, not transcripts from an agent or CLI rollout.
They must not be reported as empirical gate accuracy, task success, or user-attention savings.

## Included here

- `cases.md`: the same 128 requests and contexts, including 86 Japanese requests.
- `predictions.md`: the five falsifiable predictions frozen before the local policy edit.
- `methodology.md`: the pre-edit interpretation and counting rules.
- `results.md`: the unchanged before/after judgments for all 128 cases, including remaining failures and uncertainty.

The cases, predictions, methodology and judgments were copied without rewriting them for this PR.
The earlier local history used a snapshot commit; the published commits instead descend from upstream
`6ddd3c0ce73fe0b57d85c9146e46d3213d55a619`. Publishing that history is not a new experiment.

## Scope of the evidence

The initial-GATE, continuation and routing-stub scenarios have different denominators.
`fixed` means the assertion tested in that case was addressed under the stated rule interpretation;
it does not establish that an agent follows the rule, that every other rule in the case is correct,
or that ceremony, latency and wrong deliverables have not regressed. `still-ambiguous` also includes
known uncorrected issues because the requested four-way classification has no separate unfixed label.

The full, separately delivered archive is named `clarify-skill-reviewed.zip`. The executable
observation grader, its structured fixtures, raw JSONL annotations, independent-axis pairs,
hash manifest, detailed review and logs remain in that archive, not this checkout.
References to `cases.jsonl` and `budget-axis-pairs.json` in the frozen predictions refer to that
original archive; they are not missing runtime dependencies or files promised by this PR.

The archive's grader self-test accepted 16 hand-written valid observations and rejected 31
intentional violations. This tests the observation grader, not skill compliance. No actual
Claude Code, Codex or Antigravity selection/rollout was performed.

## Repository checks

Run from the repository root:

```sh
make check
make test
```

These validate references, counts, identifiers and installation behavior. They do not execute
the 128 requests or establish semantic correctness. The existing 44 tests are unchanged.

## Remaining work

Selection and gate-shut noise, cross-skill ownership and fallback, mandatory exclusions,
subjective acceptance, grounding and prototype cost, and decisionally independent progress
remain separate findings. They have not been silently folded into these five policy changes.
Real user corrections, abandonment, redo rates and execution costs remain unmeasured.
