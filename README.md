# Alfred Architecture Document

Source for "Alfred: The Universal Physical Infrastructure Layer for
Programmable Machines" — the dual-path (Alfred-Native / Alfred Discovery)
hardware and software architecture design document.

## Structure

- `main.tex` — top-level document, `\input`s everything in order.
- `preamble.tex` — shared packages/styling (diagram environment, tables,
  callout boxes, the `\worklogentry` command).
- `sections/01_*.tex` … `sections/20_*.tex` — the numbered sections of the
  document, one file each. Section numbers are assigned automatically by
  LaTeX from `\label`/`\ref`, except inside `diagram` (ASCII) blocks, where
  section/subsection numbers are typed as plain text and must be updated
  by hand if a section is added, removed, or reordered (see note below).
- `sections/99_worklog.tex` — appendix wrapper that pulls in the worklog.
- `worklog/worklog_entries.tex` — **append-only** log of engineering
  sessions, rendered into the PDF appendix.
- `worklog/WORKLOG.md` — plain-text/git-friendly companion to the same log,
  for quick scanning without building the PDF.
- `build/` — build output (gitignored except for the directory itself).

## Building the PDF

```
make            # builds build/main.pdf via latexmk + pdflatex
make clean      # removes build artifacts
```

Requires a TeX Live install with `latexmk`, `pdflatex`, and the packages
listed at the top of `preamble.tex` (all present in a standard/full TeX
Live install).

## Continuing work in a new session

This document is meant to be extended across sessions, not rewritten. At
the start of a new session:

1. Read `worklog/WORKLOG.md` for the most recent entry to pick up context.
2. Make your edits to the relevant `sections/*.tex` file(s).
3. Append a new session entry to **both** `worklog/worklog_entries.tex`
   (as a new `\worklogentry{date}{title}{body}` block at the end of the
   file) and `worklog/WORKLOG.md` (as a new `## YYYY-MM-DD — title`
   section at the end). Do not edit prior entries in either file.
4. Rebuild with `make` and confirm it compiles cleanly before committing.

## If you add, remove, or reorder a section

Cross-references written as `Section~\ref{sec:label}` update themselves
automatically. Cross-references typed as plain text *inside a `diagram`
block* (ASCII art can't contain `\ref`, since `Verbatim` doesn't expand
macros) do **not** — search for `grep -n 'Section [0-9]' sections/*.tex`
after any renumbering and fix any hardcoded numbers it finds by hand.
