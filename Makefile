# clarify — install by symlink
#
#   make link                     link into every agent CLI installed here
#   make link AGENT=codex         link into one of them (claude | codex | agy)
#   make link PROJECT=/path/repo  link into that repository instead of the home directories
#   make unlink                   remove only the links pointing at this repo (same rules)
#   make status                   show where the skill is linked
#
# The skill itself is `skills/clarify/` — that directory, not the repository root, is what gets
# linked, so the repo can carry a README and a test battery the skill does not ship.
#
# Three CLIs read a `SKILL.md` with YAML frontmatter, and each looks somewhere different:
#
#   agent   global                                      project
#   claude  ~/.claude/skills                            <repo>/.claude/skills
#   codex   $$CODEX_HOME/skills  (~/.codex)             <repo>/.agents/skills
#   agy     ~/.gemini/antigravity-cli/skills            <repo>/.agents/skills
#
# codex and agy share `.agents/skills` at project scope, so one link there serves both — the
# duplicate collapses in `$(sort ...)` below rather than in a special case.
#
# Each target carries the directory that must already exist for it to be written, as
# `guard|destination`. Globally the guard is the CLI's own home: a missing `~/.gemini/antigravity-cli`
# means agy is not installed here, and `make link` skips it rather than conjuring the tree for
# a CLI the user does not run. Under PROJECT= the guard is the repository root instead — there
# `.claude/` and `.agents/` are exactly what we are expected to create.
#
# SKILLS_DIR overrides the destination outright, for a runtime none of the three names:
#   make link SKILLS_DIR=~/.config/agents/skills
# A directory named that explicitly is not a probe for an installed CLI, so it has no guard to
# skip on — `/` stands in — and is created in full rather than reported missing.

NAME    := clarify
# `make -f` from elsewhere passes the path to this file through MAKEFILE_LIST, which make splits on
# whitespace — the pieces no longer name this file. Say so, rather than fail later on a half path.
$(if $(realpath $(lastword $(MAKEFILE_LIST))),,$(error the path to this Makefile contains whitespace; run make from inside the repository instead))
REPO    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SKILL   := $(REPO)/skills/$(NAME)
PROJECT ?=
AGENT   ?= claude codex agy
PAGES    := $(REPO)/docs
PAGES_PORT ?= 8000

CODEX_HOME ?= $(HOME)/.codex

# A `~` reaches make quoted, so nothing ever expands it: `PROJECT=~/repo` would resolve against
# the current directory. Expand a leading `~/`, or a bare `~`, before anything builds a path out of it.
tilde     = $(abspath $(patsubst ~,$(HOME),$(patsubst ~/%,$(HOME)/%,$(1))))

PROJECTD := $(call tilde,$(PROJECT))
SKILLSD  := $(call tilde,$(SKILLS_DIR))

# Make splits every path below on whitespace, so `PROJECT="my proj"` would link into a sibling
# called `my` and report success. A destination make cannot carry is refused before anything is
# written. Only the targets that build destinations care; `check` and `test` never read them.
ifneq ($(filter link unlink status,$(MAKECMDGOALS)),)
# The test runs on the expanded value: `SKILLS_DIR=~/skills` under a spaced HOME splits too.
$(foreach v,$(if $(strip $(SKILLS_DIR)),SKILLSD,$(if $(strip $(PROJECT)),PROJECTD,HOME CODEX_HOME)),$(if $(word 2,$($(v))),$(error $(if $(filter SKILLSD,$(v)),SKILLS_DIR (as expanded),$(if $(filter PROJECTD,$(v)),PROJECT (as expanded),$(v))) contains whitespace, which make cannot carry — use a path without spaces)))
endif

ifeq ($(strip $(PROJECT)),)
tgt_claude := $(HOME)/.claude|$(HOME)/.claude/skills
tgt_codex  := $(CODEX_HOME)|$(CODEX_HOME)/skills
tgt_agy    := $(HOME)/.gemini/antigravity-cli|$(HOME)/.gemini/antigravity-cli/skills
else
tgt_claude := $(PROJECTD)|$(PROJECTD)/.claude/skills
tgt_codex  := $(PROJECTD)|$(PROJECTD)/.agents/skills
tgt_agy    := $(PROJECTD)|$(PROJECTD)/.agents/skills
endif

# An unknown AGENT is a typo, and a typo that silently links nothing is worse than a stop.
UNKNOWN := $(filter-out claude codex agy,$(AGENT))
ifneq ($(UNKNOWN),)
$(error unknown AGENT: $(UNKNOWN) — pick from: claude codex agy)
endif

ifeq ($(strip $(SKILLS_DIR)),)
TARGETS := $(sort $(foreach a,$(AGENT),$(tgt_$(a))))
else
TARGETS := /|$(SKILLSD)
endif

# `guard|destination` carries a `|`, which the shell reads as a pipe in an unquoted `for` list.
QTARGETS := $(foreach t,$(TARGETS),'$(t)')

# "Is $$d our link?" compares where the link lands, not how it is spelled: the same checkout
# reached through a symlinked parent, or linked with a relative path, is still this repo. A
# string compare against readlink would refuse to relink it and refuse to unlink it.
OURS = [ -L "$$d" ] && [ "$$(cd "$$d" 2>/dev/null && pwd -P)" = "$$(cd "$(SKILL)" && pwd -P)" ]

.PHONY: help link unlink status check test pages

help:
	@echo "make link      [AGENT=<a>] [PROJECT=<repo>] [SKILLS_DIR=<dir>]  symlink $(NAME) into each skills directory"
	@echo "make unlink    [AGENT=<a>] [PROJECT=<repo>] [SKILLS_DIR=<dir>]  remove the links this repo owns"
	@echo "make status    [AGENT=<a>] [PROJECT=<repo>] [SKILLS_DIR=<dir>]  report each destination"
	@echo "make check                                                      references resolve, counts and identifiers agree"
	@echo "make test                                                       run the fixture battery over make check and make link"
	@echo ""
	@echo "make pages                                                      preview the docs/ site (PAGES_PORT=$(PAGES_PORT))"
	@echo ""
	@echo "agents: $(AGENT)   (claude | codex | agy)"
	@echo "repo:   $(REPO)"
	@echo "skill:  $(SKILL)"
	@$(foreach t,$(TARGETS),echo "dest:   $(word 2,$(subst |, ,$(t)))/$(NAME)";)

# A destination that is already our link is reported and counted, not relinked. Anything else
# occupying the name — a real directory, or a link into some other checkout — is refused and
# left alone: the one thing `make link` must never do is delete a skill it did not install.
link:
	@n=0; \
	for t in $(QTARGETS); do \
		guard=$${t%%|*}; dir=$${t##*|}; d="$$dir/$(NAME)"; \
		if [ ! -d "$$guard" ]; then echo "skip     $$d — $$guard does not exist"; continue; fi; \
		if [ -L "$$d" ]; then \
			if $(OURS); then echo "ok       $$d already linked"; n=$$((n+1)); continue; fi; \
			echo "refusing $$d is a symlink to $$(readlink "$$d") — resolve it, then re-run" >&2; exit 1; \
		elif [ -e "$$d" ]; then \
			echo "refusing $$d exists and is not a symlink — move it aside first" >&2; exit 1; \
		fi; \
		mkdir -p "$$dir" && ln -s "$(SKILL)" "$$d" || exit 1; \
		echo "linked   $$d -> $(SKILL)"; n=$$((n+1)); \
	done; \
	if [ $$n -eq 0 ]; then echo "nothing linked — no skills directory found for: $(AGENT)" >&2; exit 1; fi; \
	echo "invoke it with:  clarify   (or /clarify in a slash-command harness)"

unlink:
	@for t in $(QTARGETS); do \
		dir=$${t##*|}; d="$$dir/$(NAME)"; \
		if $(OURS); then rm "$$d"; echo "unlinked $$d"; \
		elif [ -L "$$d" ]; then echo "skip     $$d — links to $$(readlink "$$d"), not this skill"; \
		elif [ -e "$$d" ]; then echo "skip     $$d — not a symlink, leaving it alone"; \
		else echo "none     $$d"; fi; \
	done

status:
	@echo "skill    $(SKILL)"
	@for t in $(QTARGETS); do \
		dir=$${t##*|}; d="$$dir/$(NAME)"; \
		if [ -L "$$d" ]; then echo "link     $$d -> $$(readlink "$$d")"; \
		elif [ -e "$$d" ]; then echo "other    $$d exists and is not a symlink"; \
		else echo "none     $$d"; fi; \
	done

# Self-containment is this skill's whole premise: every path it cites must resolve inside
# `skills/$(NAME)/`, every file in reference/ must be named by SKILL.md (dotfiles aside; a
# subdirectory is refused, since every scan below would skip it), and no cited path may reach
# through a parent. Two counts are checked on top of that, because both are load-bearing and
# both are the kind of number prose keeps after the table it describes has moved on:
#
# Counts are only half of it. A rename keeps every count intact while leaving the other file
# pointing at a row that no longer exists, so identifiers are matched across files as well:
# the frontmatter `name` against the skill directory, the phase chain against the Workflow table,
# every other phase chain the prose or the page prints against that same chain (a chain that names
# none of the skill's phases, such as RED → GREEN → REFACTOR, is someone else's), every row
# `reference/detect.md` maps a non-English trigger onto against the translation table it claims
# to key into, the published page's copy of that table against its rows, and the page's copies of
# the grounding table, the lock block and its one-line short form against `reference/grounding.md` and
# `reference/lock.md`. Those are the edits that pass a count check and still break a reader.
#
#   phases              the workflow a reader is told to run, counted as the rows of the Workflow
#                       table in SKILL.md — a sixth phase nobody renamed the prose for is a phase
#                       half the readers skip.
#   evaluative words    the rows of the translation table, which is the part of this skill people
#                       actually copy — prose claiming eight while the table holds nine is how a
#                       word silently loses its default.
#
# The prose writes both counts in words, so the check maps three..ten rather than pretending prose
# says `5`. The published page writes them as digits in its fact strip, which the word scan cannot
# see, so a second scan reads the digits — anchored to the phrases `N phases` and `N evaluative
# words`, hyphenated (`N-phase`) as well as spaced and in any case, exactly as the word scan is,
# rather than to any markup. Any such phrase counts, even one about something else: a check
# that skips a phrasing can skip a real claim silently, and a false match only asks for a reword. Both
# scans read every prose file and docs/index.html with its tags stripped, lines joined so a claim
# wrapped over a line break still counts, and a number word must start a word (`written phase` is
# not `ten phase`). A page that says four while the workflow has five is the drift a reader is most
# likely to meet and least able to check. `tools/check.sh` is the battery that keeps this recipe honest — run `make test`
# after editing anything below.
#
# The reference sweep runs the other direction from the citation scan — cited-but-missing is one
# failure, present-but-uncited is the other, and only the first is visible to someone reading.
#
# DOCS is one list for every scan that reads prose: a check that names its own subset is how a file
# quietly escapes every one of them. It spans the repo README as well as the skill, because the
# README cites the same reference files and repeats the same counts. The shell globs it after the
# cd, so `make -f <path>/Makefile check` from another directory reads the skill's files rather than
# nothing. A name cited in the skill has to resolve inside the skill directory; a root file such as
# the README may also cite repository paths (`eval/README.md`). The README may point into the skill,
# never the other way. Markdown link targets are resolved against the citing file's directory, and
# are held to the same no-parent rule as code spans. No `case` inside a `$$( … )` in this recipe:
# macOS runs it with bash 3.2, whose parser closes the substitution at a case pattern's `)`.
DOCS := *.md skills/$(NAME)/*.md skills/$(NAME)/reference/*.md

check:
	@cd "$(REPO)" || exit 1; \
	fail=0; \
	misses=$$( \
		for f in $(DOCS); do \
			grep -ohE '`(\./)?[A-Za-z][A-Za-z0-9._/-]*\.md`' "$$f" | tr -d '`' | sed 's|^\./||' | sort -u | while read -r ref; do \
				hit=; for r in "$(SKILL)" "$(SKILL)/reference" "$(REPO)"; do \
					[ "$${f#skills/}" != "$$f" ] && [ "$$r" = "$(REPO)" ] && continue; \
					[ -f "$$r/$$ref" ] && hit=1; \
				done; [ -n "$$hit" ] || echo "MISS $$f -> $$ref"; \
			done; \
			awk '{ sub(/\r$$/,""); l=$$0; k=0; while (k < 3 && substr(l,1,1) == " ") { l=substr(l,2); k++ } fe=""; if (l ~ /^```/) { match(l,/^`+/); fe=substr(l,1,RLENGTH) } else if (l ~ /^~~~/) { match(l,/^~+/); fe=substr(l,1,RLENGTH) } if (!c) { if (fe != "") { c=1; fc=substr(fe,1,1); fn=length(fe); next } print; next } if (fe != "" && substr(fe,1,1) == fc && length(fe) >= fn && substr(l,length(fe)+1) ~ /^[ \t]*$$/) c=0 }' "$$f" | sed 's/`[^`]*`//g' | grep -oE '][(]<?[^)# <>]*[.]md[)# >]' | sed 's/^](<*//; s/.$$//' | sort -u | while read -r ref; do \
				[ "$${ref#*://}" != "$$ref" ] && continue; \
				[ -f "$$(dirname "$$f")/$$ref" ] || echo "MISS $$f -> $$ref"; \
			done; \
		done); \
	if [ -n "$$misses" ]; then echo "$$misses" >&2; fail=1; fi; \
	for f in "$(SKILL)"/reference/*; do \
		[ -e "$$f" ] || continue; \
		b=$$(basename "$$f"); \
		if [ -d "$$f" ]; then echo "MISS reference/$$b is a directory — the scans read reference/*.md only, so reference/ stays flat" >&2; fail=1; continue; fi; \
		grep -qF "reference/$$b" "$(SKILL)/SKILL.md" || { echo "MISS reference/$$b exists but SKILL.md never names it" >&2; fail=1; }; \
	done; \
	if { grep -noE '`[^`]*`' $(DOCS); grep -noE '][(][^)]*[)]' $(DOCS); } | grep -v '://' | grep -E '\.\./' >&2; then \
		echo "MISS a cited path reaches through a parent directory" >&2; fail=1; \
	fi; \
	pagesrc=$$( [ -f docs/index.html ] && sed 's/<[^>]*>/ /g' docs/index.html | tr '\n' ' ' | tr -s ' ' ); \
	claimsrc=$$( { cat $(DOCS); printf ' %s' "$$pagesrc"; } | tr '\n' ' ' | tr -s ' ' ); \
	p=; w=; \
	if [ -f "$(SKILL)/SKILL.md" ]; then \
		p=$$(awk '/^\| Phase \| Focus \|/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{c++;next} t{exit} END{print c+0}' "$(SKILL)/SKILL.md"); \
		pclaimed=$$(printf '%s' "$$claimsrc" | grep -oiE '(^|[^A-Za-z])(three|four|five|six|seven|eight|nine|ten)[- ]phase' | tr 'A-Z' 'a-z' | sed 's/^[^a-z]*//' | cut -d- -f1 | cut -d' ' -f1 | sort -u); \
		pdigits=$$(printf '%s' "$$claimsrc" | grep -oiE '(^|[^0-9A-Za-z.])[0-9]+[- ]phase' | grep -oE '[0-9]+' | sort -u); \
		if [ -z "$$pclaimed$$pdigits" ]; then \
			echo "MISS no phase-count claim found — this check has drifted from the prose" >&2; fail=1; \
		fi; \
		for c in $$pclaimed; do \
			case $$c in three) v=3;; four) v=4;; five) v=5;; six) v=6;; seven) v=7;; eight) v=8;; nine) v=9;; ten) v=10;; *) v=0;; esac; \
			[ "$$v" = "$$p" ] || { echo "MISS phase count claims $$c ($$v), SKILL.md tabulates $$p" >&2; fail=1; }; \
		done; \
		for c in $$pdigits; do \
			[ "$$c" = "$$p" ] || { echo "MISS phase count claims $$c, SKILL.md tabulates $$p" >&2; fail=1; }; \
		done; \
		w=$$(awk '/^\| Word \| Axis/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{c++;next} t{exit} END{print c+0}' "$(SKILL)/SKILL.md"); \
		wclaimed=$$(printf '%s' "$$claimsrc" | grep -oiE '(^|[^A-Za-z])(three|four|five|six|seven|eight|nine|ten)[- ]evaluative' | tr 'A-Z' 'a-z' | sed 's/^[^a-z]*//' | cut -d- -f1 | cut -d' ' -f1 | sort -u); \
		wdigits=$$(printf '%s' "$$claimsrc" | grep -oiE '(^|[^0-9A-Za-z.])[0-9]+[- ]evaluative' | grep -oE '[0-9]+' | sort -u); \
		if [ -z "$$wclaimed$$wdigits" ]; then \
			echo "MISS no evaluative-word-count claim found — this check has drifted from the prose" >&2; fail=1; \
		fi; \
		for c in $$wclaimed; do \
			case $$c in three) v=3;; four) v=4;; five) v=5;; six) v=6;; seven) v=7;; eight) v=8;; nine) v=9;; ten) v=10;; *) v=0;; esac; \
			[ "$$v" = "$$w" ] || { echo "MISS evaluative-word count claims $$c ($$v), SKILL.md tabulates $$w" >&2; fail=1; }; \
		done; \
		for c in $$wdigits; do \
			[ "$$c" = "$$w" ] || { echo "MISS evaluative-word count claims $$c, SKILL.md tabulates $$w" >&2; fail=1; }; \
		done; \
	fi; \
	nm=$$(awk -F'[: ]+' '/^name:/{gsub(/["\047]/,"",$$2); print $$2; exit}' "$(SKILL)/SKILL.md"); \
	[ "$$nm" = "$(NAME)" ] || { echo "MISS frontmatter name is '$$nm', the skill directory is '$(NAME)'" >&2; fail=1; }; \
	chain=$$(grep -m1 -oE '^`[A-Z]+( → [A-Z]+)+`' "$(SKILL)/SKILL.md" | tr -d '`' | sed 's/ → /@/g' | tr '@' '\n'); \
	rows=$$(awk '/^\| Phase \| Focus \|/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{split($$0,a,"|"); k=a[2]; gsub(/[` ]/,"",k); print k; next} t{exit}' "$(SKILL)/SKILL.md"); \
	if [ -z "$$chain" ] || [ "$$chain" != "$$rows" ]; then \
		echo "MISS the phase chain and the Workflow table do not name the same phases in the same order" >&2; fail=1; \
	fi; \
	keys=$$(awk '/^\| Word \| Axis/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{split($$0,a,"|"); k=a[2]; gsub(/^ +| +$$/,"",k); print k; next} t{exit}' "$(SKILL)/SKILL.md"); \
	dangling=$$(awk '/^\| Japanese \| Lands on the row \|/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{split($$0,a,"|"); v=a[3]; gsub(/^ +| +$$/,"",v); print v; next} t{exit}' "$(SKILL)/reference/detect.md" \
		| while read -r v; do printf '%s\n' "$$keys" | grep -qxF "$$v" || echo "MISS detect.md maps a trigger onto row '$$v', which the translation table does not define"; done); \
	if [ -n "$$dangling" ]; then echo "$$dangling" >&2; fail=1; fi; \
	ntrig=$$(awk '/^\| Japanese \| Lands on the row \|/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{c++;next} t{exit} END{print c+0}' "$(SKILL)/reference/detect.md"); \
	[ "$$ntrig" -gt 0 ] || { echo "MISS no trigger table found in reference/detect.md — this check has drifted from the file" >&2; fail=1; }; \
	stray=$$(printf '%s\n' "$$claimsrc" | grep -oE '[A-Z]+( → [A-Z]+)+' | sort -u | while read -r c; do \
		cs=$$(printf '%s\n' "$$c" | sed 's/ → /@/g' | tr '@' '\n'); \
		printf '%s\n' "$$cs" | grep -qxF "$$chain" || continue; \
		[ "$$cs" = "$$chain" ] || echo "MISS a phase chain reads '$$c', SKILL.md runs the Workflow table's phases"; done); \
	if [ -n "$$stray" ]; then echo "$$stray" >&2; fail=1; fi; \
	if [ -f docs/index.html ]; then \
		pkeys=$$(awk '/<section id="words">/{t=1} t&&/<\/section>/{exit} t' docs/index.html | grep -oE '<tr><td>[^<]*</td>' | sed 's/^<tr><td>//; s/<\/td>$$//'); \
		[ "$$pkeys" = "$$keys" ] || { echo "MISS the page's translation table does not name the rows SKILL.md defines, in the same order" >&2; fail=1; }; \
		groles=$$(awk '/^\| Role \| Source \|/{t=1;next} t&&/^\| *:?---/{next} t&&/^\|/{print;next} t{exit}' "$(SKILL)/reference/grounding.md" \
			| sed 's/\*\*//g; s/`//g; s/^| *//; s/ *|$$//; s/ *| */|/g'); \
		proles=$$(awk '/<th>Role<\/th><th>Source<\/th>/{t=1;next} t&&/<\/tbody>/{exit} t&&/<tr><td>/' docs/index.html \
			| sed 's/^ *<tr><td>//; s/<\/td><\/tr> *$$//; s/<\/td><td>/|/g; s/<[^>]*>//g; s/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g'); \
		[ -n "$$groles" ] && [ "$$proles" = "$$groles" ] || { echo "MISS the page's grounding table differs from reference/grounding.md" >&2; fail=1; }; \
		lshort=$$(grep -m1 '^lock: ' "$(SKILL)/reference/lock.md" | tr -s ' '); \
		pshort=$$(awk '/<pre><code>lock: /{t=1} t{print} t&&/<\/code><\/pre>/{exit}' docs/index.html \
			| sed 's/<[^>]*>//g; s/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g' | tr '\n' ' ' | tr -s ' ' | sed 's/ $$//'); \
		[ -n "$$lshort" ] && [ "$$pshort" = "$$lshort" ] || { echo "MISS the page's short lock differs from reference/lock.md" >&2; fail=1; }; \
		lblock=$$(awk '/^## Locked instruction$$/{t=1} t&&/^```/{exit} t' "$(SKILL)/reference/lock.md" | tr -s ' ' | sed 's/ $$//'); \
		pblock=$$(awk '/<pre><code>## Locked instruction/{t=1} t{print} t&&/<\/code><\/pre>/{exit}' docs/index.html \
			| sed 's/<[^>]*>//g; s/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g' | tr -s ' ' | sed 's/ $$//'); \
		[ -n "$$lblock" ] && [ "$$pblock" = "$$lblock" ] || { echo "MISS the page's lock block differs from reference/lock.md" >&2; fail=1; }; \
	fi; \
	if [ $$fail -eq 0 ]; then echo "self-contained: all references resolve inside $(SKILL), $$p phases, $$w evaluative words, identifiers matched across files"; else exit 1; fi

# GitHub Pages serves docs/ as static files on `main`; this only previews the same tree locally,
# so what you see here is what the published site is.
pages:
	@echo "serving $(PAGES) at http://localhost:$(PAGES_PORT)/ — ctrl-c to stop"
	@python3 -m http.server $(PAGES_PORT) --directory "$(PAGES)"

# The check checks the skill; this checks the check.
test:
	@sh "$(REPO)/tools/check.sh"
