# Agent Learnings & Improvements Ledger

This ledger records meaningful updates to the agent configuration in `platform-services` — what improved, why it makes the agents more effective, and what was learned. Governed by **AGT-013**: every pull request must add an entry here.

Add a new dated entry at the top for each change.

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
