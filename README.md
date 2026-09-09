# Alfred Architecture Documents

Two related but independent LaTeX documents live in this project, sharing
a preamble, build system, and worklog:

1. **`main.tex` → `build/main.pdf`** — "Alfred: The Universal Physical
   Infrastructure Layer for Programmable Machines," the long-range,
   company-thesis-level architecture document (dual-path Alfred-Native /
   Alfred Discovery hardware and software architecture).
2. **`sepnov_plan.tex` → `build/sepnov_plan.pdf`** — "Alfred Common
   Interface-Node Platform: September 8 – November 30, 2026 Electrical
   Architecture Development Plan," a narrower, dated execution plan for a
   specific engineering program (10BASE-T1S, the common Alfred
   interface-node platform, E2B/Gateway configurations, LAN865x/LAN866x
   hardware, PCB Revs A/B/C). Central-compute selection, zonal computing,
   firmware generation, SIL/HIL, application software, autonomous driving,
   infotainment, and production certification are explicitly out of scope
   for this document.

They are separate documents on purpose (see the 2026-09-08 worklog entries)
— the plan does not replace or supersede the thesis.

## Structure

- `main.tex` / `sepnov_plan.tex` — top-level documents, each `\input`s its
  own section files in order.
- `preamble.tex` — **shared** packages/styling (diagram environment,
  tables, callout boxes, the `\worklogentry` command). A change here
  affects both documents' builds.
- `sections/01_*.tex` … `sections/20_*.tex` — the thesis's sections.
  Section numbers are assigned automatically by LaTeX from `\label`/`\ref`,
  except inside `diagram` (ASCII) blocks, where section/subsection numbers
  are typed as plain text and must be updated by hand if a section is
  added, removed, or reordered (see note below).
- `sepnov/01_*.tex` … `sepnov/15_*.tex` — the Sept–Nov plan's sections,
  same numbering caveat applies.
- `sections/99_worklog.tex` and `sepnov/99_worklog.tex` — each document's
  appendix wrapper; both pull in the **same** shared worklog file.
- `worklog/worklog_entries.tex` — **append-only** log of engineering
  sessions, rendered into *both* PDFs' appendices. Because it is shared,
  entries must not `\ref` a label that only exists in one of the two
  documents — refer to sections by plain-text name instead (see the header
  comment in the file).
- `worklog/WORKLOG.md` — plain-text/git-friendly companion to the same log,
  for quick scanning without building either PDF.
- `build/` — build output (gitignored except for the directory itself).

## Building the PDFs

```
make            # builds build/main.pdf (thesis)
make plan       # builds build/sepnov_plan.pdf (Sept-Nov execution plan)
make all        # builds both
make clean      # removes build artifacts for both
```

Requires a TeX Live install with `latexmk`, `pdflatex`, and the packages
listed at the top of `preamble.tex` (all present in a standard/full TeX
Live install).

## Continuing work in a new session

Both documents are meant to be extended across sessions, not rewritten. At
the start of a new session:

1. Read `worklog/WORKLOG.md` for the most recent entries to pick up context
   — note which document(s) the most recent session touched.
2. Make your edits to the relevant `sections/*.tex` or `sepnov/*.tex`
   file(s), depending on which document the work belongs to.
3. Append a new session entry to **both** `worklog/worklog_entries.tex`
   (as a new `\worklogentry{date}{title}{body}` block at the end of the
   file, using plain-text section references only — see above) and
   `worklog/WORKLOG.md` (as a new `## YYYY-MM-DD — title` section at the
   end). Do not edit prior entries in either file.
4. Rebuild with `make all` and confirm both documents compile cleanly
   before committing.

## If you add, remove, or reorder a section (in either document)

Cross-references written as `Section~\ref{sec:label}` update themselves
automatically. Cross-references typed as plain text *inside a `diagram`
block* (ASCII art can't contain `\ref`, since `Verbatim` doesn't expand
macros) do **not** — search for `grep -n 'Section [0-9]' sections/*.tex` or
`sepnov/*.tex` after any renumbering and fix any hardcoded numbers it finds
by hand.
