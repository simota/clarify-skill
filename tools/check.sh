#!/bin/sh
# Fixture battery for `make check`.
#
# `make check` is what backs this skill's self-containment premise, so the check itself needs
# a check: each case below mutates a throwaway copy of the tree and asserts the exit status.
# An edit to the check recipe that stops catching something fails here instead of passing quietly.
#
#   sh tools/check.sh
#
# Cases are named for what they inject. `want=ok` means the tree is clean and the check must
# pass; `want=fail` means the injected fault must be caught.

set -u

SRC=$(cd "$(dirname "$0")/.." && pwd)
SKILL=skills/clarify
TMP=$(mktemp -d "${TMPDIR:-/tmp}/clarify-check.XXXXXX") || exit 1
trap 'rm -rf "$TMP"' EXIT

pass=0
fail=0

# copy_ <name> — a throwaway copy of the tree, printed as a path. Every case mutates its own.
copy_() {
	d=$TMP/$(printf '%s' "$1" | tr -c 'a-zA-Z0-9' '_')
	rm -rf "$d"
	mkdir -p "$d/skills" || exit 1
	cp -R "$SRC/Makefile" "$SRC/README.md" "$SRC/docs" "$d/" || exit 1
	cp -R "$SRC/$SKILL" "$d/skills/" || exit 1
	printf '%s' "$d"
}

# case <name> <ok|fail> <setup-shell-run-inside-the-copy> [indir|foreign]
case_() {
	name=$1
	want=$2
	setup=$3
	where=${4:-indir}

	d=$(copy_ "$name")

	if [ -n "$setup" ]; then
		( cd "$d" && eval "$setup" ) || { printf 'SETUP  %s\n' "$name"; fail=$((fail + 1)); return; }
	fi

	if [ "$where" = foreign ]; then
		( cd / && make -f "$d/Makefile" check ) >/dev/null 2>&1
	else
		( cd "$d" && make check ) >/dev/null 2>&1
	fi
	got=$?

	if [ "$want" = ok ] && [ "$got" -eq 0 ]; then
		pass=$((pass + 1)); printf 'ok     %s\n' "$name"
	elif [ "$want" = fail ] && [ "$got" -ne 0 ]; then
		pass=$((pass + 1)); printf 'ok     %s\n' "$name"
	else
		fail=$((fail + 1)); printf 'FAIL   %s (want %s, exit %s)\n' "$name" "$want" "$got"
	fi
}

# --- the tree is clean -------------------------------------------------------
case_ 'clean tree'                       ok   ''
case_ 'clean tree, foreign cwd via -f'   ok   '' foreign

# --- a cited reference does not resolve --------------------------------------
case_ 'missing ref, lower-case name'     fail 'printf "See \`nonexistent-file.md\`.\n" >> $SKILL/SKILL.md'
case_ 'missing ref, capitalised name'    fail 'printf "See \`NOTREAL.md\`.\n" >> $SKILL/reference/detect.md'
case_ 'missing ref, new root .md'        fail 'printf "See \`nonexistent-file.md\`.\n" > CONTRIBUTING.md'
case_ 'missing ref, new .md in skill'    fail 'printf "See \`nonexistent-file.md\`.\n" > $SKILL/NOTES.md'
case_ 'reference dir deleted, foreign'   fail 'rm -rf $SKILL/reference' foreign
case_ 'detect.md deleted, foreign cwd'   fail 'rm $SKILL/reference/detect.md' foreign

# --- a reference file exists that SKILL.md never names ------------------------
case_ 'orphan file in reference/'        fail 'printf "# Orphan\n" > $SKILL/reference/orphan.md'
case_ 'orphan named by SKILL.md only'    ok   'printf "# Orphan\n" > $SKILL/reference/orphan.md
                                              printf "See \`reference/orphan.md\`.\n" >> $SKILL/SKILL.md'

# --- something points at a parent --------------------------------------------
case_ 'parent ref in SKILL.md'           fail 'printf "See \`../escape.md\`.\n" >> $SKILL/SKILL.md'
case_ 'parent ref in README.md'          fail 'printf "See \`../escape.md\`.\n" >> README.md'
case_ 'parent ref in new root .md'       fail 'printf "See \`../escape.md\`.\n" > CONTRIBUTING.md'

# --- a relative path in an install example is not a parent reference ----------
case_ 'relative PROJECT= in a fence'     ok   'printf "\n\`\`\`sh\nmake link PROJECT=../sibling-repo\n\`\`\`\n" >> README.md'

# --- the phase count drifts from the Workflow table ---------------------------
case_ 'phase count drifts in README.md'  fail 'sed "s/[Ff]ive phases/four phases/g" README.md > _ && mv _ README.md'
case_ 'phase count drifts in a ref file' fail 'printf "The four-phase workflow.\n" >> $SKILL/reference/traps.md'
case_ 'phase digit drifts in the page'   fail 'sed "s|>5</b><span>phases|>6</b><span>phases|" docs/index.html > _ && mv _ docs/index.html'
case_ 'phase prose drifts from check'    fail 'for f in $SKILL/SKILL.md README.md docs/index.html; do
                                                 sed -E "s/[Ff]ive[- ]phase/the phase/g; s|>5</b><span>phases|>5</b><span>steps|" "$f" > _ && mv _ "$f"
                                               done'
case_ 'a 6th phase row, prose stale'     fail 'awk "{print} /^\\| \`LOCK\` \\|/{print \"| \`FAKE\` | Does it? | Never | — |\"}" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'

# --- the evaluative-word count drifts from the translation table ---------------
case_ 'word count drifts in SKILL.md'    fail 'sed "s/Eight evaluative words/Seven evaluative words/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'word count drifts in a ref file'  fail 'printf "The seven evaluative words.\n" >> $SKILL/reference/grounding.md'
case_ 'word digit drifts in the page'    fail 'sed "s|>8</b><span>evaluative words|>9</b><span>evaluative words|" docs/index.html > _ && mv _ docs/index.html'
case_ 'word prose drifts from check'     fail 'for f in $SKILL/SKILL.md README.md docs/index.html; do
                                                 sed -E "s/[Ee]ight[- ]evaluative/the evaluative/g; s|>8</b><span>evaluative words|>8</b><span>trigger words|" "$f" > _ && mv _ "$f"
                                               done'
case_ 'a 9th word row, prose stale'      fail 'awk "{print} /^\\| refactor this \\|/{print \"| tidy it up \\| Something \\| Something |\"}" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'

# --- an identifier drifts between the files that share it ----------------------
#
# A rename keeps every count intact, so these are exactly the edits the count scans cannot see.
case_ 'row key renamed, detect stale'    fail 'sed "s/refactor this |/tidy this up |/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'row key renamed in both files'    ok   'for f in $SKILL/SKILL.md $SKILL/reference/detect.md; do
                                                 sed "s/refactor this |/tidy this up |/" "$f" > _ && mv _ "$f"
                                               done'
case_ 'phase renamed in the chain only'  fail 'sed "s/RESIDUE -> ASK/LEFTOVER -> ASK/; s/RESIDUE → ASK/LEFTOVER → ASK/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'phase renamed in the table only'  fail 'sed "s/RESIDUE[^ ]* | What genuinely/LEFTOVER | What genuinely/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'phase renamed everywhere'         ok   'sed "s/RESIDUE/LEFTOVER/g" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'the phase chain is deleted'       fail 'grep -v "GATE → GROUND" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'frontmatter name drifts'          fail 'sed "s/^name: clarify/name: clarify-v2/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'

# --- a table that is not the counted one must not inflate either count ---------
case_ 'an unrelated table in SKILL.md'   ok   'printf "\n| A | B |\n|---|---|\n| x | y |\n| x | y |\n" >> $SKILL/SKILL.md'

# --- `make link` places the skill where each CLI actually reads it ------------
#
# The three CLIs look in three different directories, and a link recipe is exactly the kind of
# thing that is never watched failing: it either wrote a symlink somewhere or it did not. Each
# case below runs the real recipe against a throwaway HOME and then asserts the tree it left —
# a recipe that quietly links nothing, or links into a CLI that is not installed, fails here.
#
# Default fixture: claude and codex are installed (their home directories exist), agy is not.

# link_case <name> <ok|fail> <make-args> <assertion> [<setup>]
#   The assertion runs inside the copy with $H as the fake home and $S as the skill it should
#   point at; a non-zero exit fails the case even when make itself exited as expected.
link_case_() {
	name=$1
	want=$2
	margs=$3
	assert=$4
	setup=${5:-}

	d=$(copy_ "link_$name")
	H=$d/home
	mkdir -p "$H/.claude" "$H/.codex" || exit 1
	# make resolves its own directory physically, so the link it writes names the physical path.
	# Comparing against `$d` would fail on any machine where the scratch tree sits under a
	# symlink — /tmp on macOS, for one — for a reason that has nothing to do with the recipe.
	S=$(cd "$d/$SKILL" && pwd -P)

	if [ -n "$setup" ]; then
		( cd "$d" && H=$H S=$S eval "$setup" ) || { printf 'SETUP  %s\n' "$name"; fail=$((fail + 1)); return; }
	fi

	( cd "$d" && make HOME="$H" CODEX_HOME="$H/.codex" $margs ) >/dev/null 2>&1
	got=$?

	if [ "$want" = ok ] && [ "$got" -ne 0 ]; then
		fail=$((fail + 1)); printf 'FAIL   link: %s (make exited %s, want 0)\n' "$name" "$got"; return
	fi
	if [ "$want" = fail ] && [ "$got" -eq 0 ]; then
		fail=$((fail + 1)); printf 'FAIL   link: %s (make exited 0, want non-zero)\n' "$name"; return
	fi

	if ( cd "$d" && H=$H S=$S eval "$assert" ); then
		pass=$((pass + 1)); printf 'ok     link: %s\n' "$name"
	else
		fail=$((fail + 1)); printf 'FAIL   link: %s (make exited %s as expected, tree is wrong)\n' "$name" "$got"
	fi
}

link_case_ 'installed CLIs get a link'   ok   'link' \
	'[ "$(readlink "$H/.claude/skills/clarify")" = "$S" ] &&
	 [ "$(readlink "$H/.codex/skills/clarify")" = "$S" ]'

link_case_ 'an absent CLI is skipped'    ok   'link' \
	'[ ! -e "$H/.gemini" ]'

link_case_ 'agy installed, agy linked'   ok   'link' \
	'[ "$(readlink "$H/.gemini/antigravity-cli/skills/clarify")" = "$S" ]' \
	'mkdir -p "$H/.gemini/antigravity-cli"'

link_case_ 'no CLI installed at all'     fail 'link' \
	'[ ! -e "$H/.claude/skills" ]' \
	'rm -rf "$H/.claude" "$H/.codex"'

link_case_ 'linking twice is idempotent' ok   'link' \
	'[ "$(readlink "$H/.claude/skills/clarify")" = "$S" ]' \
	'make HOME="$H" CODEX_HOME="$H/.codex" link >/dev/null 2>&1'

link_case_ 'a foreign link is refused'   fail 'link' \
	'[ "$(readlink "$H/.codex/skills/clarify")" = /elsewhere ]' \
	'mkdir -p "$H/.codex/skills" && ln -s /elsewhere "$H/.codex/skills/clarify"'

link_case_ 'a real directory is refused' fail 'link' \
	'[ -f "$H/.codex/skills/clarify/keep-me" ]' \
	'mkdir -p "$H/.codex/skills/clarify" && : > "$H/.codex/skills/clarify/keep-me"'

link_case_ 'AGENT= links only that one'  ok   'link AGENT=codex' \
	'[ -L "$H/.codex/skills/clarify" ] && [ ! -e "$H/.claude/skills/clarify" ]'

link_case_ 'an unknown AGENT stops'      fail 'link AGENT=nope' \
	'[ ! -e "$H/.claude/skills/clarify" ]'

# codex and agy both read `<repo>/.agents/skills`, so a project link is two directories, not three.
link_case_ 'PROJECT= links the repo'     ok   'link PROJECT=proj' \
	'[ "$(readlink proj/.claude/skills/clarify)" = "$S" ] &&
	 [ "$(readlink proj/.agents/skills/clarify)" = "$S" ] &&
	 [ ! -e "$H/.claude/skills/clarify" ]' \
	'mkdir -p proj'

link_case_ 'SKILLS_DIR= overrides all'   ok   'link SKILLS_DIR=elsewhere/skills' \
	'[ "$(readlink elsewhere/skills/clarify)" = "$S" ] &&
	 [ ! -e "$H/.claude/skills/clarify" ]'

link_case_ 'unlink removes only ours'    ok   'unlink' \
	'[ ! -e "$H/.claude/skills/clarify" ] &&
	 [ "$(readlink "$H/.gemini/antigravity-cli/skills/clarify")" = /elsewhere ]' \
	'make HOME="$H" CODEX_HOME="$H/.codex" link >/dev/null 2>&1
	 mkdir -p "$H/.gemini/antigravity-cli/skills" && ln -s /elsewhere "$H/.gemini/antigravity-cli/skills/clarify"'


printf '\n%s passed, %s failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
