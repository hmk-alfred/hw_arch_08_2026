# Alfred Architecture Document

Source for "Alfred: The Universal Physical Infrastructure Layer for
Programmable Machines" — the dual-path (Alfred-Native / Alfred Discovery)
hardware and software architecture design document.

## Structure

- `main.tex` — top-level document, `\input`s everything in order.
- `preamble.tex` — shared packages/styling (diagram environment, tables,
  callout boxes, the `\worklogentry` command).
- `sections/01_*.tex` … `sections/22_*.tex` — the numbered sections of the
  document, one file each, matching the final-deliverable structure.
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
