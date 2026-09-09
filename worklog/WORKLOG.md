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

## 2026-09-09 — Revision 2 of sepnov_plan.tex: LAN8660/LAN8661 now mandatory

Following a discussion about whether LAN8660/LAN8661 could be shared across
the Greenfield/Brownfield architectures (conclusion: no — RCP isn't a
general transport, and their I2C/SPI/UART pins face peripherals, not a host
controller), the user revised the Sept–Nov plan's hardware architecture.
LAN8660 (Control Endpoint) and LAN8661 (Lighting Endpoint) are now
**mandatory, first-class Greenfield E2B devices** — not the secondary/
time-boxed investigation Revision 1 treated them as. LAN8651 stays the
host-side MAC-PHY behind a programmable MCU only (Clicker 4, Gateway MCU).
The "one MCU+LAN8651 PCB becomes either E2B or Gateway" premise is retired;
the new architecture is three "platform sibling" node classes (E2B-Control/
LAN8660, E2B-Lighting/LAN8661, Gateway/MCU+LAN8651) sharing power/
protection/connector/mechanical/validation philosophy, not schematics.

All 15 files under `sepnov/` from 2026-09-08 were replaced with 23 new
files matching the user's new 22-part structure + final questions.
`main.tex` untouched.

Did more targeted research before writing: confirmed via Microchip's public
VelocityDRIVE sell sheet (DS00006257C) that LAN8660/8661 expose I2C/SPI/UART
digital I/O on the peripheral side, but found no pin-exact datasheet,
register map, or reference schematic is publicly available — that's gated
behind Microchip's secure/NDA documentation program. Called this out
explicitly and repeatedly as the program's highest-leverage, least-
controllable dependency, with an honest fallback if it's late. Also flagged
as an open risk: couldn't confirm public docs explicitly state PLCA support
for the LAN866x endpoint family the way they do for LAN8650/1 and
LAN8670/1/2 — resolved empirically by a three-node PLCA test, not assumed.

Proposed (with "confirm once real docs arrive" caveats): DRV8830-class I2C
motor driver (primary) or PCA9685-class I2C PWM/servo driver (alternate)
for the LAN8660 actuator experiment; PCA9955B-class automotive I2C LED
driver (primary) or TLC59116-class general I2C LED driver (alternate) for
LAN8661 — explicitly not WS2812/WS2814 absent confirmation LAN8661 supports
that single-wire protocol.

PCB structure changed from 3 boards to 5 (Rev A-Control/A-Light, then
Rev B-Control/B-Light/B-Gateway → Rev C family) — flagged as its own risk,
traded deliberately against forcing incompatible silicon onto one board.
Built clean: 37 pages, zero undefined references, zero overfull warnings.
Architecture A holds at 3 pages, Architecture B at 2 (under the ~3-page cap).

**Next session TODO:** once Microchip secure docs/eval hardware for
LAN8660/LAN8661 actually arrive, revisit the candidate driver-IC choices
(Sections 8/9 of the plan) against the real reference design before
schematic freeze — they're reasoned proposals from public-level info only.
