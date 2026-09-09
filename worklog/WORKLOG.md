# Worklog

Plain-text/git-friendly companion to the PDF appendix (`sections/99_worklog.tex`,
entries in `worklog/worklog_entries.tex`). Append a new dated entry each
session; never edit or delete a prior entry. Keep this file and
`worklog_entries.tex` in sync — this file is the quick-scan/grep-able index,
`worklog_entries.tex` is the version that renders in the PDF appendix.

## 2026-09-08 — Initial architecture document authored

Set up the project (git repo, multi-file LaTeX build under `sections/`,
this worklog mechanism) and wrote the complete first draft of the Alfred
architecture design document (`main.tex` + 22 section files, ~40+ pages).
Covers both Option A (Alfred-Native/Greenfield) and Option B (Alfred
Discovery/Brownfield) architectures in full technical detail per the
original spec: hardware design (Central Compute, E2B node family, Probe
hardware), software layer stack, Machine IR, Vehicle Knowledge Graph,
firmware generation pipeline, discovery/correlation methodology, active
control safety architecture, deployment/reprogramming, convergence
argument, migration strategy, product family, BOM, MVP roadmap,
competitive differentiation, technical moat, risk assessment (21 items),
next 10 engineering tasks, and a final 12-month-runway recommendation.

No prior session existed — this is the baseline. Built PDF via
`make` (pdflatex, see `Makefile`).

**Next session TODO:** revisit numeric placeholders once real hardware
measurements exist; start logging actual MVP0 build progress against the
roadmap in Section 15 (renumbered as of the 2026-09-08 condensing pass — check the current PDF's table of contents rather than trusting this number going forward).

## 2026-09-08 — New document: Sept–Nov 2026 electrical architecture plan

The user replaced the prior task scope with a narrower, dated deliverable —
a focused electrical-architecture plan for Sept 8–Nov 30, 2026 (10BASE-T1S,
the common Alfred interface-node platform, E2B/Gateway configs, LAN865x/
LAN866x hardware, PCB Revs A/B/C), explicitly excluding central compute,
zonal architecture, firmware generation, SIL/HIL, app software, ADAS,
infotainment, and production certification. Per the user's choice, this is
a **new, separate** document (`sepnov_plan.tex` + `sepnov/*.tex`), not a
replacement of the existing thesis (`main.tex`) — both now build via
`make pdf` / `make plan` / `make all`, sharing `preamble.tex` and this
worklog.

Verified Microchip's LAN866x/LAN865x documentation via web research before
writing (per explicit instruction). **Key finding:** LAN8660/8661/8662 are
Microchip's *VelocityDRIVE endpoint* family — fixed-function, MCU-less
10BASE-T1S devices configured via a network GUI tool (MPLAB Network
Creator), not general-purpose PHY/MAC-PHY silicon for a customer MCU. They
can't run Alfred firmware or speak CAN/LIN, so they can't be the common
node's network component. **LAN8650/LAN8651** (MAC-PHY, SPI, OPEN Alliance
TC6) is the part that actually matches the user's own block diagrams, and
is used as the primary network component throughout Rev A/B/C; LAN8660 is
kept as a secondary, time-boxed investigation only. Also found that MikroE
sells LAN8651-based mikroBUS click boards (MIKROE-5543, MIKROE-6550) that
plug directly into the Clicker 4 — recommended for Week 1 bring-up ahead of
any custom silicon.

Architecture A and Architecture B sections were held to the requested
~3-page cap (verified: both land at exactly 3 pages). Added `pdflscape`
(landscape schedule table) and `amssymb` (checklist markers) to the shared
preamble — affects both documents' builds, additive/harmless to the thesis.
Built clean: thesis 38 pages, plan 29 pages, zero undefined references in
either.

**Next session TODO:** if Rev A schematic work starts, confirm LAN8650 vs
LAN8651 pin-compatibility against the actual datasheet pinout tables before
finalizing the dual-footprint Rev A layout — the recommendation so far is
sourced from product-brief-level material, not a full pin-by-pin datasheet
diff.
