# platform-services — Agent Guidelines

`platform-services` is a governed repository. All compliance rules come from the mother repo:

> **[platform-compliance](https://github.com/ashuangiras/platform-compliance)**  
> Profile: **`PROF-SERVICE-V1`** | Compliance ref: **`v3.3.3`**  
> Profile definition: [04-profiles/PROF-SERVICE-V1.yaml](https://github.com/ashuangiras/platform-compliance/blob/main/04-profiles/PROF-SERVICE-V1.yaml)

Do **not** add governance objects (controls, policies, bindings) here — all governance changes go to platform-compliance.

## Repository context

- **Type:** `service`
- **Technology contexts:** github,github-actions,agent
- **Compliance workflow:** `.github/workflows/compliance.yml` — runs on every PR
- **Manifest:** `.compliance-manifest.yaml` — declares profile and contexts

## Service repo

This repository contains a deployable service. Key controls: OBS-001 (health endpoint), RUN-001/002 (non-root, read-only container), SEC-001 (no secrets in code), QUA-001–004 (code quality), TST-001/002 (tests + coverage), API-001 (OpenAPI spec).

## Delivery model

- `main` is protected: **1 required review + CODEOWNERS + `Compliance: Merge Gate` status check + required commit signatures**.
- All changes land via **PR + bootstrap-merge** (single developer) — see the `pr-engineer` agent.
- Every PR body must include a **Change Record** (`CHG-YYYYMMDD-NNN`) and a completed **Agent Readiness & Retro** section (required by CHG-001 and AGT-014).

## Universal pre-flight (before any work)

1. Confirm `git rev-parse --abbrev-ref HEAD` is **not** `main`. Create a branch: `git checkout -b <area>/<slug>`.
2. Identify which controls apply to your change.
3. Check `.compliance-manifest.yaml` before adding a new technology context.

## Universal post-flight (before opening a PR)

1. Language/tool-specific checks pass (fmt, lint, validate, tfsec — see the author agent).
2. No BLOCK-level compliance gate failures on the branch.
3. PR body has **Change Record** and **Agent Readiness & Retro** section.

## Quick reference

```bash
forge validate <file> --compliance-dir /path/to/platform-compliance
forge check all  --compliance-dir /path/to/platform-compliance
forge gate merge --compliance-dir /path/to/platform-compliance
```
