# Agent Learnings & Improvements Ledger

This ledger records meaningful updates to the agent configuration in `platform-services` — what improved, why it makes the agents more effective, and what was learned. Governed by **AGT-013**: every pull request must add an entry here.

Add a new dated entry at the top for each change.

---

## 2026-07-11 — chore: migrate to platform-compliance v4.0.0 (CHG-20260711-057)

**Change Record:** CHG-20260711-057

- **Compliance ref**: bumped `reusable-compliance.yml@v3.3.4` → `@v4.0.0` and `platform-compliance-ref` → `v4.0.0` in `compliance.yml`. v4.0.0 promotes AGT-001..015 to `block` on the merge gate for agent-context repos, adds CAT-003 (manifest completeness), and expands the profile `inherits` chain so SEC-004 is enforced via PROF-BASE.
- **AGT-012**: added explicit Build/test, Conventions/architecture, and Safety sections to `copilot-instructions.md` — the completeness check requires all three, with a literal `do not` in the safety section (a bolded `**not**` does not satisfy it).
- **AGT-008**: verified the PreToolUse guard script is committed executable (mode 100755) so the hook is valid in a fresh CI checkout.
- **CAT-003**: `.compliance-manifest.yaml` already declares the `agent` context, matching the on-disk agent surface — reconciled and passing.

**Rule learned:** a MAJOR compliance bump can turn previously-informational agent controls into blocking ones; treat the ledger + PR readiness/retro sections as gate inputs, and never rely on incidental keyword substrings to satisfy instruction-completeness checks — add real, explicit sections.

---

## 2026-07-11 — fix: resolve all policy failures (SEC-004, SEC-005, LIC-001, AGT-008/010/013, SUP-004)

**Change Record:** CHG-20260711-047

- **LIC-001**: Added MIT LICENSE file. A service repository must carry a license so consumers know the terms under which they may use and modify it.
- **SEC-004**: Fixed workflow token permissions. All workflows now declare `permissions: read-all` at the top level; write permissions are scoped to individual jobs only. This prevents accidental token escalation.
- **SEC-005**: Added Semgrep SAST scan workflow. Semgrep with the `p/terraform` ruleset catches HCL security misconfigurations before merge. Combined with tfsec (IAC-004), this gives two independent security scanning perspectives on the Terraform code.
- **AGT-008**: Added PreToolUse safety hook that prompts before destructive operations (force-push, hard-reset, rm -rf). The hook runs a shell guard script — same pattern as platform-compliance.
- **AGT-010**: Added explicit `## Constraints` section to `compliance-gate.agent.md`. The constraints section lists what the agent must not do, making boundaries visible to both operators and automated checks.
- **AGT-013**: Created this ledger. Future PRs must add an entry explaining what improved.
- **SUP-004**: Added release workflow with Syft SBOM generation (`anchore/sbom-action`). Every service release now produces a `sbom.cdx.json` artifact attached to the release.

**Rule learned:** Policy failures that are "not in the merge gate" still appear in every CI run as noise. Fix them early — they are cheap to address and make the output meaningful rather than a wall of known-bad items to ignore.

---

## 2026-07-11 — feat: add SLI/SLO targets and error budget policies to service contracts (PC-0157)

**Change Record:** CHG-20260711-051

- **REL-001 (Prometheus)**: SLO target 99.0% availability; SLI = `/-/healthy` HTTP 200 within 10s over 30-day window
- **REL-001 (Grafana)**: SLO target 99.0% availability; SLI = `/api/health` HTTP 200 within 5s over 30-day window
- **REL-002**: Error budget policies defined for both services with explicit 50% and 100% consumption actions

**Rule learned:** SLO targets in service contracts should be set at service inception, not deferred. The "TBD" placeholder creates compliance debt that is harder to clear later (the team has to agree on targets retroactively). Define the target when you first understand the service's reliability requirements.
