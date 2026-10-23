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

# The caller's make variables must not reach the cases: `PROJECT=… make test` would otherwise send
# every link case into that real repository, and `make test AGENT=codex` arrives through MAKEFLAGS.
unset PROJECT AGENT SKILLS_DIR CODEX_HOME MAKEFLAGS MFLAGS MAKELEVEL

SRC=$(cd "$(dirname "$0")/.." && pwd)
SKILL=skills/clarify
TMP=$(mktemp -d "${TMPDIR:-/tmp}/clarify-check.XXXXXX") || exit 1
trap 'rm -rf "$TMP"' EXIT

pass=0
fail=0

# A count claim may wrap over a line break; mutations that remove one map newlines to this byte first.
NL=$(printf '\001')

# copy_ <name> — a throwaway copy of the tree, printed as a path. Every case mutates its own.
copy_() {
	d=$TMP/$(printf '%s' "$1" | tr -c 'a-zA-Z0-9' '_')
	rm -rf "$d"
	mkdir -p "$d/skills" || exit 1
	cp -R "$SRC/Makefile" "$SRC/README.md" "$SRC/docs" "$SRC/eval" "$d/" || exit 1
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
case_ 'missing ref with a folder'        fail 'printf "See \`skills/clarify/reference/gone.md\`.\n" >> README.md'
case_ 'missing ref under eval/'          fail 'printf "See \`eval/nope.md\`.\n" >> README.md'
case_ 'skill cites a repo-only path'     fail 'printf "See \`eval/README.md\`.\n" >> $SKILL/SKILL.md'
case_ 'markdown link to a missing file'  fail 'printf "See [gone](reference/gone.md).\n" >> $SKILL/SKILL.md'
case_ 'link example in a code fence'     ok   'printf "\n\`\`\`markdown\nSee [the notes](NOTES.md).\n\`\`\`\n" >> README.md'
case_ 'longer fence holds a short one'   fail 'printf "\n\`\`\`\`markdown\nClose a fence with:\n\`\`\`\n\`\`\`\`\n\nSee [gone](gone.md).\n" >> README.md'
case_ 'link example in an indented fence' ok  'printf "\n   \`\`\`markdown\n   See [the notes](NOTES.md).\n   \`\`\`\n" >> README.md'
case_ 'CRLF fence still closes'          fail 'printf "\r\n\`\`\`sh\r\nx\r\n\`\`\`\r\n\r\nSee [g](gone.md).\r\n" >> README.md'
case_ 'link example in a ~~~ fence'      ok   'printf "\n~~~markdown\nSee [the notes](NOTES.md).\n~~~\n" >> README.md'
case_ 'link example in inline code'      ok   'printf "Use \`[x](notes.md)\` syntax.\n" >> README.md'
case_ 'markdown link that resolves'      ok   'printf "See [lock](reference/lock.md).\n" >> $SKILL/SKILL.md'
case_ 'missing link with an anchor'      fail 'printf "See [d](missing.md#section).\n" >> README.md'
case_ 'missing link in angle brackets'   fail 'printf "See [d](<missing.md>).\n" >> README.md'
case_ 'angle-bracket link that resolves' ok   'printf "See [lock](<reference/lock.md>).\n" >> $SKILL/SKILL.md'
case_ 'missing link with a title'        fail 'printf "See [d](gone.md \"Title\").\n" >> README.md'
case_ 'anchored link that resolves'      ok   'printf "See [lock](reference/lock.md#field-rules \"Rules\").\n" >> $SKILL/SKILL.md'
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
case_ 'parent ref in a markdown link'    fail 'printf "See [x](../escape.md).\n" >> README.md'
case_ 'a URL may contain ../'            ok   'printf "See [ext](https://example.com/a/../b) and \`https://example.com/c/../d\`.\n" >> README.md'
case_ 'cd ../ outside any code span'     ok   'printf "Run \`make link\`, then cd ../ and repeat.\n" >> README.md'

# --- a relative path in an install example is not a parent reference ----------
case_ 'relative PROJECT= in a fence'     ok   'printf "\n\`\`\`sh\nmake link PROJECT=../sibling-repo\n\`\`\`\n" >> README.md'

# --- the phase count drifts from the Workflow table ---------------------------
case_ 'phase count drifts in README.md'  fail 'sed "s/[Ff]ive phases/four phases/g" README.md > _ && mv _ README.md'
case_ 'phase count drifts in a ref file' fail 'printf "The four-phase workflow.\n" >> $SKILL/reference/traps.md'
case_ 'phase count wrapped over a line'  fail 'printf "A four\nphase workflow.\n" >> README.md'
# Any "N phases" counts as a claim, even about something else: skipping a phrasing (an earlier
# "N phases of" exemption) also skipped real claims, silently. Rewording is the cheaper failure.
case_ 'any digit + phases is a claim'    fail 'printf "Release takes 2 phases of review.\n" >> README.md'
case_ 'digit claim before "of…" word'    fail 'printf "Clarify runs 6 phases offering one question each.\n" >> README.md'
case_ 'page digit claim "N phases of"'   fail 'sed "s|>Five phases</a>|>The 6 phases of clarify</a>|" docs/index.html > _ && mv _ docs/index.html'
case_ 'digit count drifts in README.md'  fail 'printf "The workflow has 6 phases.\n" >> README.md'
case_ 'hyphenated digit phase claim'     fail 'printf "The 6-phase workflow.\n" >> README.md'
case_ 'hyphenated digit word claim'      fail 'printf "The 9-evaluative-word table.\n" >> README.md'
case_ 'digit word count drifts in prose' fail 'printf "Nine evaluative words? No: 9 evaluative words.\n" >> $SKILL/reference/traps.md'
case_ 'number word inside another word'  ok   'printf "Each lock is written\nphase by phase.\n" >> README.md'
case_ 'phase chain wrapped over a line'  ok   'printf "The workflow runs GATE → GROUND →\nRESIDUE → ASK → LOCK.\n" >> README.md'
case_ 'table separator written spaced'   ok   'sed "s/^|-------|-------|----------------|------|$/| ----- | ----- | ----- | ----- |/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md
                                               grep -q "^| ----- | ----- |" $SKILL/SKILL.md'
case_ 'phase digit drifts in the page'   fail 'sed "s|>5</b><span>phases|>6</b><span>phases|" docs/index.html > _ && mv _ docs/index.html'
case_ 'phase prose drifts from check'    fail 'for f in $SKILL/SKILL.md README.md docs/index.html; do
                                                 tr "\n" "\001" < "$f" | sed -E "s/[Ff]ive([- $NL])phase/the\1phase/g; s|>5</b><span>phases|>5</b><span>steps|" | tr "\001" "\n" > _ && mv _ "$f"
                                               done'
case_ 'a 6th phase row, prose stale'     fail 'awk "{print} /^\\| \`LOCK\` \\|/{print \"| \`FAKE\` | Does it? | Never | — |\"}" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'

# --- the evaluative-word count drifts from the translation table ---------------
case_ 'word count drifts in SKILL.md'    fail 'sed "s/Eight evaluative words/Seven evaluative words/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'word count drifts in a ref file'  fail 'printf "The seven evaluative words.\n" >> $SKILL/reference/grounding.md'
case_ 'word digit drifts in the page'    fail 'sed "s|>8</b><span>evaluative words|>9</b><span>evaluative words|" docs/index.html > _ && mv _ docs/index.html'
case_ 'word prose drifts from check'     fail 'for f in $SKILL/SKILL.md README.md docs/index.html; do
                                                 tr "\n" "\001" < "$f" | sed -E "s/[Ee]ight([- $NL])evaluative/the\1evaluative/g; s|>8</b><span>evaluative words|>8</b><span>trigger words|" | tr "\001" "\n" > _ && mv _ "$f"
                                               done'
case_ 'a 9th word row, prose stale'      fail 'awk "{print} /^\\| refactor this \\|/{print \"| tidy it up \\| Something \\| Something |\"}" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'

# --- an identifier drifts between the files that share it ----------------------
#
# A rename keeps every count intact, so these are exactly the edits the count scans cannot see.
case_ 'row key renamed, detect stale'    fail 'sed "s/refactor this |/tidy this up |/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md
                                               sed "s|<td>refactor this</td>|<td>tidy this up</td>|" docs/index.html > _ && mv _ docs/index.html'
case_ 'trigger table header renamed'     fail 'sed "s/| Japanese | Lands on the row |/| 日本語 | Lands on the row |/; s/| リファクタして | refactor this |/| リファクタして | tidy it up |/" $SKILL/reference/detect.md > _ && mv _ $SKILL/reference/detect.md'
case_ 'row key renamed, page stale'      fail 'for f in $SKILL/SKILL.md $SKILL/reference/detect.md; do
                                                 sed "s/refactor this |/tidy this up |/" "$f" > _ && mv _ "$f"
                                               done'
case_ 'row key renamed everywhere'       ok   'for f in $SKILL/SKILL.md $SKILL/reference/detect.md; do
                                                 sed "s/refactor this |/tidy this up |/" "$f" > _ && mv _ "$f"
                                               done
                                               sed "s|<td>refactor this</td>|<td>tidy this up</td>|" docs/index.html > _ && mv _ docs/index.html'
case_ 'page drops a translation row'     fail 'grep -v "<tr><td>easy to use</td>" docs/index.html > _ && mv _ docs/index.html'
case_ 'page reorders translation rows'   fail 'awk "/<tr><td>easy to use<\/td>/{h=\$0; next} {print} /<tr><td>refactor this<\/td>/{print h}" docs/index.html > _ && mv _ docs/index.html'
case_ 'no page at all'                   ok   'rm docs/index.html'

# --- the page's copies of the grounding table and the short lock drift ---------
case_ 'page grounding cell drifts'       fail 'sed "s|<td>a still-applicable preference</td>|<td>standing preferences</td>|" docs/index.html > _ && mv _ docs/index.html'
case_ 'grounding.md cell drifts'         fail 'sed "s/| a still-applicable preference |/| any remembered preference |/" $SKILL/reference/grounding.md > _ && mv _ $SKILL/reference/grounding.md'
case_ 'synced edit with & and code'      ok   'sed "s/| a still-applicable preference |/| a still-applicable \`pref\` \& habit |/" $SKILL/reference/grounding.md > _ && mv _ $SKILL/reference/grounding.md
                                               sed "s|<td>a still-applicable preference</td>|<td>a still-applicable <code>pref</code> \&amp; habit</td>|" docs/index.html > _ && mv _ docs/index.html'
case_ 'grounding row edited everywhere'  ok   'sed "s/| a still-applicable preference |/| any remembered preference |/" $SKILL/reference/grounding.md > _ && mv _ $SKILL/reference/grounding.md
                                               sed "s|<td>a still-applicable preference</td>|<td>any remembered preference</td>|" docs/index.html > _ && mv _ docs/index.html'
case_ 'page short lock drops a slot'     fail 'sed "s/ in &lt;target&gt;//" docs/index.html > _ && mv _ docs/index.html'
case_ 'lock.md short lock drifts'        fail 'sed "s/; not touching <exclusion>//" $SKILL/reference/lock.md > _ && mv _ $SKILL/reference/lock.md'
case_ 'phase renamed in the chain only'  fail 'sed "s/RESIDUE -> ASK/LEFTOVER -> ASK/; s/RESIDUE → ASK/LEFTOVER → ASK/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'phase renamed in the table only'  fail 'sed "s/RESIDUE[^ ]* | What genuinely/LEFTOVER | What genuinely/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'phase renamed in SKILL.md only'   fail 'sed "s/RESIDUE/LEFTOVER/g" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'phase renamed everywhere'         ok   'for f in $SKILL/SKILL.md README.md docs/index.html; do
                                                 sed "s/RESIDUE/LEFTOVER/g" "$f" > _ && mv _ "$f"
                                               done'
case_ 'phase chain drifts in README.md'  fail 'sed "s/RESIDUE → ASK/ASK → RESIDUE/" README.md > _ && mv _ README.md'
case_ 'an unrelated arrow chain'         ok   'printf "TDD runs RED → GREEN → REFACTOR.\n" >> README.md'
case_ 'phase chain drifts in the page'   fail 'sed "s/GROUND → RESIDUE/GROUND → EXTRA → RESIDUE/" docs/index.html > _ && mv _ docs/index.html'
case_ 'the phase chain is deleted'       fail 'grep -v "GATE → GROUND" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
case_ 'frontmatter name quoted'          ok   'sed "s/^name: clarify$/name: \"clarify\"/" $SKILL/SKILL.md > _ && mv _ $SKILL/SKILL.md'
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

# The same checkout reached by another spelling is still ours — relinking and unlinking must agree.
link_case_ 'our link, another spelling'  ok   'link' \
	'[ "$(readlink "$H/.codex/skills/clarify")" = "$d/alias/$SKILL" ]' \
	'ln -s "$d" "$d/alias" && mkdir -p "$H/.codex/skills" && ln -s "$d/alias/$SKILL" "$H/.codex/skills/clarify"'

link_case_ 'unlink takes that spelling'  ok   'unlink' \
	'[ ! -e "$H/.codex/skills/clarify" ] && [ ! -L "$H/.codex/skills/clarify" ]' \
	'ln -s "$d" "$d/alias" && mkdir -p "$H/.codex/skills" && ln -s "$d/alias/$SKILL" "$H/.codex/skills/clarify"'

link_case_ 'a dangling link is refused'  fail 'link' \
	'[ -L "$H/.codex/skills/clarify" ]' \
	'mkdir -p "$H/.codex/skills" && ln -s "$d/gone" "$H/.codex/skills/clarify"'

link_case_ 'SKILLS_DIR=~ is expanded'    ok   'link SKILLS_DIR=~' \
	'[ "$(readlink "$H/clarify")" = "$S" ] && [ ! -e "./~" ]'

link_case_ 'unlink removes only ours'    ok   'unlink' \
	'[ ! -e "$H/.claude/skills/clarify" ] &&
	 [ "$(readlink "$H/.gemini/antigravity-cli/skills/clarify")" = /elsewhere ]' \
	'make HOME="$H" CODEX_HOME="$H/.codex" link >/dev/null 2>&1
	 mkdir -p "$H/.gemini/antigravity-cli/skills" && ln -s /elsewhere "$H/.gemini/antigravity-cli/skills/clarify"'


# --- a destination make cannot carry is refused, not mis-linked ------------------
#
# Make splits paths on whitespace, so these cannot go through link_case_'s word-split arguments.
space_case_() {
	name=$1
	var=$2
	d=$(copy_ "space_$name")
	H=$d/home
	mkdir -p "$H/.claude" "$H/my" "$H/my proj" || exit 1
	( cd "$d" && make HOME="$H" "$var=$H/my proj" link ) >/dev/null 2>&1
	got=$?
	if [ "$got" -ne 0 ] && [ -z "$(find "$H" -type l)" ]; then
		pass=$((pass + 1)); printf 'ok     link: %s\n' "$name"
	else
		fail=$((fail + 1)); printf 'FAIL   link: %s (exit %s, links: %s)\n' "$name" "$got" "$(find "$H" -type l)"
	fi
}
space_case_ 'PROJECT with a space refused'    PROJECT
space_case_ 'SKILLS_DIR with a space refused' SKILLS_DIR

# `~` expands to HOME, so a spaced HOME reaches the destination through it and must be refused.
d=$(copy_ 'tilde into spaced home')
mkdir -p "$d/h sp" "$d/h"
if ! ( cd "$d" && make HOME="$d/h sp" SKILLS_DIR='~/skills' link ) >/dev/null 2>&1 && [ -z "$(find "$d/h" "$d/h sp" -type l)" ]; then
	pass=$((pass + 1)); printf 'ok     link: SKILLS_DIR=~/… under a spaced HOME refused\n'
else
	fail=$((fail + 1)); printf 'FAIL   link: SKILLS_DIR=~/… under a spaced HOME refused\n'
fi

# A spaced HOME does not build the destination when PROJECT= does, so it is not refused there.
d=$(copy_ 'spaced home, project dest')
mkdir -p "$d/h sp" "$d/proj"
if ( cd "$d" && make HOME="$d/h sp" PROJECT="$d/proj" link ) >/dev/null 2>&1 && [ -L "$d/proj/.claude/skills/clarify" ]; then
	pass=$((pass + 1)); printf 'ok     link: a spaced HOME is fine under PROJECT=\n'
else
	fail=$((fail + 1)); printf 'FAIL   link: a spaced HOME is fine under PROJECT=\n'
fi

# `make -f` through a path with a space cannot find itself; it must say why, not fail on a half path.
d=$TMP/'sp ace'
mkdir -p "$d/skills" && cp -R "$SRC/Makefile" "$SRC/README.md" "$SRC/docs" "$SRC/eval" "$d/" && cp -R "$SRC/$SKILL" "$d/skills/"
if ( cd / && make -f "$d/Makefile" check ) 2>&1 | grep -q 'contains whitespace'; then
	pass=$((pass + 1)); printf 'ok     a spaced repo path via -f is explained\n'
else
	fail=$((fail + 1)); printf 'FAIL   a spaced repo path via -f is explained\n'
fi
if ( cd "$d" && make check ) >/dev/null 2>&1; then
	pass=$((pass + 1)); printf 'ok     a spaced repo path from inside still checks\n'
else
	fail=$((fail + 1)); printf 'FAIL   a spaced repo path from inside still checks\n'
fi

# Glob characters in the repo path are not whitespace; -f through them must still work.
d=$TMP/'glob[1]'
mkdir -p "$d/skills" && cp -R "$SRC/Makefile" "$SRC/README.md" "$SRC/docs" "$SRC/eval" "$d/" && cp -R "$SRC/$SKILL" "$d/skills/"
if ( cd / && make -f "$d/Makefile" check ) >/dev/null 2>&1; then
	pass=$((pass + 1)); printf 'ok     a repo path with [ ] via -f still checks\n'
else
	fail=$((fail + 1)); printf 'FAIL   a repo path with [ ] via -f still checks\n'
fi

printf '\n%s passed, %s failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
