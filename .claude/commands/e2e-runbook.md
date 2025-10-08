---
allowed_tools:
  - "mcp__chrome-devtools__*"
  - "!mcp__chrome-devtools__close_page"
  - "!mcp__chrome-devtools__resize_page"
  - "!mcp__chrome-devtools__emulate_*"
---

# Chrome DevTools MCP Runbook Command

Follow the official E2E execution runbook while respecting the separated operational rules.

## Usage

```
/e2e-runbook [scenario description]
```

Describe the user journey or feature under test. The assistant must then execute the flow exactly as prescribed in the runbook and supporting documents.

## Execution Checklist

1. **Runbook Reference**  
   Load the step-by-step procedure from `docs/e2e-testing/e2e-excute/runbook.md` and follow it sequentially.
2. **Rules Compliance**  
   Apply the operational requirements from `docs/e2e-testing/e2e-excute/rules.md`, including authentication handling, data isolation, tab policy, and clean-up.
3. **Waiting Strategy**  
   Use the prioritised wait guidance in `docs/e2e-testing/e2e-excute/wait-strategy.md` when synchronising with the UI.
4. **Environment Selection**  
   Determine the correct target URL using `docs/e2e-testing/e2e-excute/environments.md` before launching the browser.
5. **Test Case Mapping**  
   Identify matching Gherkin cases via `docs/e2e-testing/e2e-excute/test-cases.md` and execute the relevant feature files from `docs/e2e-testing/features/`.
6. **Credential Policy**  
   Obtain or rotate accounts in accordance with `docs/e2e-testing/e2e-excute/credentials.md`.
7. **Error Handling**  
   When failures occur, diagnose and recover using `docs/e2e-testing/e2e-excute/error-playbook.md`.

## Example

```
/e2e-runbook checkout flow smoke
```

The assistant should consult the referenced documents, choose the correct feature scenarios, execute them in Chrome DevTools MCP, and report outcomes with evidence.
