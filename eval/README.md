# Evaluation records

This directory publishes the human-readable subset of the completed design review.
These are synthetic contract witnesses, not transcripts from an agent or CLI rollout.
They must not be reported as empirical gate accuracy, task success, or user-attention savings.

## Included here

- `cases.md`: the same 128 requests and contexts, including 86 Japanese requests.
- `predictions.md`: the five falsifiable predictions frozen before the local policy edit.
- `methodology.md`: the pre-edit interpretation and counting rules.
- `results.md`: the unchanged before/after judgments for all 128 cases, including remaining failures and uncertainty.
- `predictions-r2.md`: round 2 — seven predictions (P6–P12) frozen before the second policy edit,
  aimed at 21 of the 23 cases round 1 left `still-ambiguous`.
- `results-r2.md`: round 2 judgments for those 23 cases and for the controls a round-2 rule could
  regress, plus the new risks the round introduces. Read by the edit's author, not independently.

The round-1 cases, predictions, methodology and judgments were copied without rewriting them.
Round 2 adds files instead of editing those: the case oracles are unchanged.
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

These validate references, counts, identifiers and installation behavior, and CI runs both on
Linux and macOS. They do not execute the 128 requests or establish semantic correctness.

## Remaining work

Round 1 left selection and gate-shut noise, cross-skill ownership and fallback, mandatory
exclusions, subjective acceptance, grounding and prototype cost, and decisionally independent
progress as separate findings; round 2 addresses them (`results-r2.md`). C045 (an oracle dispute)
and C103 (no owner contract) remain open. Real CLI selection, user corrections, abandonment,
redo rates and execution costs remain unmeasured.
