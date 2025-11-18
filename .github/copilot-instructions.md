# AI Assistant Instructions for win32-mutex Repository

## Purpose

This document defines the authoritative operational workflow for AI assistants contributing to the `win32-mutex` repository, a Ruby gem that provides Windows mutex functionality. AI assistants MUST follow these guidelines to ensure safe, consistent, and compliant contributions to the codebase.

## Repository Structure

```
win32-mutex/
├── .expeditor/                    # Chef Expeditor automation configuration
│   ├── config.yml                 # Release automation and versioning rules
│   ├── run_linux_tests.sh         # Linux test execution script
│   ├── run_windows_tests.ps1      # Windows test execution script
│   ├── update_version.sh          # Version update automation
│   └── verify.pipeline.yml        # Verification pipeline configuration
├── .github/                       # GitHub configuration and templates
│   ├── workflows/                 # GitHub Actions CI/CD workflows
│   │   ├── ci-main-pull-request-checks.yml  # Main PR validation pipeline
│   │   ├── lint.yml               # Code linting workflow
│   │   └── unit.yml               # Unit testing workflow
│   ├── CODEOWNERS                 # Code ownership definitions
│   ├── ISSUE_TEMPLATE.md          # Issue reporting template
│   ├── PULL_REQUEST_TEMPLATE.md   # Pull request template
│   └── dependabot.yml            # Dependency update configuration
├── examples/                      # Usage examples and demos
│   └── example_win32_mutex.rb     # Sample implementation
├── lib/                          # Main library code
│   ├── win32-mutex.rb            # Main entry point and compatibility layer
│   └── win32/                    # Core implementation namespace
│       ├── mutex.rb              # Primary mutex implementation
│       └── mutex/                # Version and metadata
│           └── version.rb        # Version constants
├── test/                         # Test suite
│   └── test_win32_mutex.rb       # Unit and integration tests
├── .gitignore                    # Git ignore patterns
├── .rubocop.yml                  # Ruby style guide configuration
├── CHANGELOG.md                  # Release history and changes
├── CHANGES                       # Legacy change log
├── Gemfile                       # Ruby dependency specification
├── MANIFEST                      # File listing for packaging
├── README.md                     # Project documentation
├── Rakefile                      # Build and task automation
├── VERSION                       # Current version identifier
└── win32-mutex.gemspec          # Gem specification and metadata
```

## Tooling & Ecosystem

- **Language**: Ruby
- **Build System**: Rake
- **Testing Framework**: Test::Unit (standard Ruby testing)
- **Linting**: RuboCop (Ruby style guide enforcement)
- **Package Manager**: RubyGems
- **Release Automation**: Chef Expeditor
- **CI/CD**: GitHub Actions + Chef's common workflows
- **Version Control**: Git with GitHub

## Issue (Jira/Tracker) Integration

This repository uses Jira for issue tracking via the Atlassian MCP server. AI assistants MUST:

1. Use MCP tools to fetch Jira issues when provided with issue keys (e.g., `ABC-123`)
2. Parse Jira issue content for: summary, description, acceptance criteria, issue type, labels, story points
3. Reference Jira issue keys in commits and PRs using format `(ABC-123)`
4. Create implementation plans based on Jira issue requirements
5. Seek clarification if acceptance criteria are unclear or missing

**MCP Integration**: The repository is configured with `atlassian-mcp-server` for Jira connectivity via `.vscode/mcp.json`.

## Workflow Overview

AI assistants MUST follow these phases in order:

1. **Intake & Clarify** - Understand requirements and scope
2. **Repository Analysis** - Review existing code and dependencies  
3. **Plan Draft** - Create detailed implementation plan
4. **Plan Confirmation** - User approval gate (MUST respond "yes")
5. **Incremental Implementation** - Small, testable changes
6. **Lint / Style** - RuboCop compliance verification
7. **Test & Coverage Validation** - Ensure test coverage ≥80%
8. **DCO Commit** - Developer Certificate of Origin compliance
9. **Push & Draft PR Creation** - Create draft pull request
10. **Label & Risk Application** - Apply appropriate GitHub labels
11. **Final Validation** - Comprehensive review before completion

Each phase ends with: Step Summary + Checklist + "Continue to next step? (yes/no)".

## Detailed Step Instructions

AI assistants MUST adhere to these principles:

- **Smallest cohesive change per commit**
- **Add/adjust tests immediately with each behavior change**
- **Present a mapping of changes to tests before committing**

Example Step Output:
```
Step: Add boundary guard in parser
Summary: Added nil check & size constraint; tests added for empty input & overflow.
Checklist:
- [x] Plan
- [x] Implementation  
- [ ] Tests
Proceed? (yes/no)
```

If user responds other than explicit "yes" → AI MUST pause & clarify.

## Branching & PR Standards

- **Branch Naming**: Use GitHub issue number if available (e.g., `issue-123-fix-mutex-leak`), otherwise kebab-case slug ≤40 chars
- **One logical change set per branch** (MUST)
- **PR MUST remain draft** until: tests pass + lint/style pass + coverage mapping completed
- **Risk Classification** (MUST pick one):
  - **Low**: Localized, non-breaking changes
  - **Moderate**: Shared module / light interface changes  
  - **High**: Public API change / performance / security / migration
- **Rollback Strategy**: `revert commit <SHA>` or feature toggle reference

## Commit & DCO Policy

Commit format (MUST):
```
{{TYPE}}({{OPTIONAL_SCOPE}}): {{SUBJECT}} ({{ISSUE_KEY}})

Rationale (what & why).

Issue: {{ISSUE_KEY or none}}
Signed-off-by: {{Full Name}} <{{email@domain}}>
```

**Missing sign-off → block and request name/email.**

## Testing & Coverage

**Changed Logic → Test Assertions Mapping** (MUST):

| File | Method/Block | Change Type | Test File | Assertion Reference |
|------|--------------|-------------|-----------|-------------------|
| | | | | |

**Coverage Threshold** (MUST): ≥80% changed lines. If below: add tests or refactor for testability.

**Edge Cases** (MUST enumerate for each plan):
- Large input / boundary size
- Empty / nil input  
- Invalid / malformed data
- Platform-specific differences (Windows/Linux behavior)
- Concurrency / timing issues
- External dependency failures (Windows API calls)

**Test Execution**:
```bash
# Run all tests
rake test

# Run specific test file
ruby test/test_win32_mutex.rb

# Run with coverage (if simplecov is available)
COVERAGE=true rake test
```

## Labels Reference

| Name | Description | Typical Use |
|------|-------------|-------------|
| Aspect: Documentation | How do we use this project? | Documentation updates |
| Aspect: Integration | Works correctly with other projects or systems | Integration fixes |
| Aspect: Packaging | Distribution of the projects 'compiled' artifacts | Gem packaging changes |
| Aspect: Performance | Works without negatively affecting the system running it | Performance improvements |
| Aspect: Portability | Does this project work correctly on the specified platform? | Cross-platform fixes |
| Aspect: Security | Can an unwanted third party affect the stability or look at privileged information? | Security fixes |
| Aspect: Stability | Consistent results | Bug fixes, stability improvements |
| Aspect: Testing | Does the project have good coverage, and is CI working? | Test additions/fixes |
| Aspect: UI | How users interact with the interface of the project | API interface changes |
| Aspect: UX | How users feel interacting with the project | Developer experience improvements |
| dependencies | Pull requests that update a dependency file | Dependency updates |
| Expeditor: Bump Version Major | Used by github.major_bump_labels to bump the Major version number | Breaking changes |
| Expeditor: Bump Version Minor | Used by github.minor_bump_labels to bump the Minor version number | Feature additions |
| Expeditor: Skip All | Used to skip all merge_actions | Emergency overrides |
| Expeditor: Skip Changelog | Used to skip built_in:update_changelog | Changelog bypass |
| Expeditor: Skip Habitat | Used to skip built_in:trigger_habitat_package_build | Habitat bypass |
| Expeditor: Skip Omnibus | Used to skip built_in:trigger_omnibus_release_build | Omnibus bypass |
| Expeditor: Skip Version Bump | Used to skip built_in:bump_version | Version bump bypass |
| hacktoberfest-accepted | A PR that has been accepted for credit in the Hacktoberfest project | Hacktoberfest contributions |
| oss-standards | Related to OSS Repository Standardization | Standards compliance |
| Platform: AWS | null | AWS-specific changes |
| Platform: Azure | null | Azure-specific changes |
| Platform: Debian-like | null | Debian/Ubuntu changes |
| Platform: Docker | null | Docker-related changes |
| Platform: GCP | null | Google Cloud changes |
| Platform: Linux | null | Linux-specific changes |
| Platform: macOS | null | macOS-specific changes |
| Platform: RHEL-like | null | RHEL/CentOS changes |
| Platform: SLES-like | null | SLES changes |
| Platform: Unix-like | null | Unix-like platform changes |

## CI / Release Automation Integration

**GitHub Actions Workflows**:
- `ci-main-pull-request-checks.yml`: Main PR validation pipeline with complexity checks, TruffleHog scanning, and SBOM generation
- `lint.yml`: Ruby code linting with RuboCop
- `unit.yml`: Unit test execution

**Chef Expeditor Release Automation**:
- Automated version bumping based on PR labels
- Changelog generation and maintenance
- RubyGems publication upon release
- Branch cleanup after merge
- Slack notifications for build failures

**Version Bump Mechanism**: Expeditor automatically bumps version based on labels:
- `Expeditor: Bump Version Minor` for feature additions
- Default patch version bump for other changes
- Manual major version bumps for breaking changes

**AI MUST NOT directly edit release automation configs without explicit user instruction.**

## Security & Protected Files

**Protected** (NEVER edit without explicit approval):
- `LICENSE`
- `CODE_OF_CONDUCT*`
- `CODEOWNERS`
- `SECURITY*`
- `.expeditor/config.yml` (release automation)
- `.github/workflows/*.yml` (CI workflow files)
- Secrets or credential placeholders
- Compliance policy docs

**NEVER**:
- Exfiltrate or inject secrets
- Force-push default branch
- Merge PR autonomously
- Insert new binaries
- Remove license headers
- Fabricate issue or label data
- Reference `~/.profile` in auth guidance

## Prompts Pattern (Interaction Model)

After each step AI MUST output:

```
Step: {{STEP_NAME}}
Summary: {{CONCISE_OUTCOME}}
Checklist: 
- [x] {{COMPLETED_PHASE}}
- [ ] {{PENDING_PHASE}}
Prompt: "Continue to next step? (yes/no)"
```

Non-affirmative response → AI MUST pause & clarify.

## Validation & Exit Criteria

Task is **COMPLETE ONLY IF**:

1. Feature/fix branch exists & pushed
2. RuboCop linting passes
3. Tests pass (including platform-specific tests if applicable)
4. Coverage mapping complete + ≥80% changed lines
5. PR open (draft or ready) with required sections
6. Appropriate labels applied
7. All commits DCO-compliant
8. No unauthorized Protected File modifications
9. User explicitly confirms completion

Otherwise AI MUST list unmet items.

## Issue Planning Template

```
Issue: ABC-123
Summary: <from Jira issue>
Acceptance Criteria:
- ...

Implementation Plan:
- Goal:
- Impacted Files:
- Public API Changes:
- Data/Integration Considerations:
- Test Strategy:
- Edge Cases:
- Risks & Mitigations:
- Rollback:

Proceed? (yes/no)
```

## PR Description Canonical Template

Since `.github/PULL_REQUEST_TEMPLATE.md` exists, AI MUST use that template structure and inject additional required sections:

**Existing Template Structure**:
```markdown
### Description
[Please describe what this change achieves]

### Issues Resolved
[List any existing issues this PR resolves, or any Discourse or StackOverflow discussion that's relevant]

### Check List
- [ ] New functionality includes tests
- [ ] All tests pass
- [ ] All commits have been signed-off for the Developer Certificate of Origin
```

**Required Additional Sections to Inject**:
```markdown
### Tests & Coverage
Changed lines: N; Estimated covered: ~X%; Mapping complete.

### Risk & Mitigations
Risk: Low | Mitigation: revert commit SHA

### DCO
All commits signed off.
```

## Idempotency Rules

**Re-entry Detection Order** (MUST):
1. Branch existence (`git rev-parse --verify <branch>`)
2. PR existence (`gh pr list --head <branch>`)
3. Uncommitted changes (`git status --porcelain`)

**Delta Summary** (MUST):
- Added Sections:
- Modified Sections:
- Deprecated Sections:
- Rationale:

## Failure Handling

**Decision Tree** (MUST):
- Labels fetch fails → Abort; prompt: "Provide label list manually or fix auth. Retry? (yes/no)"
- Issue fetch incomplete → Ask: "Missing acceptance criteria—provide or proceed with inferred? (provide/proceed)"
- Coverage < threshold → Add tests; re-run; block commit until satisfied
- Missing DCO → Request user name/email
- Protected file modification attempt → Reject & restate policy

## Glossary

- **Changed Lines Coverage**: Portion of modified lines executed by assertions
- **Implementation Plan Freeze Point**: No code changes allowed until approval
- **Protected Files**: Policy-restricted assets requiring explicit user authorization
- **Idempotent Re-entry**: Resuming workflow without duplicated or conflicting state
- **Risk Classification**: Qualitative impact tier (Low/Moderate/High)
- **Rollback Strategy**: Concrete reversal action (revert commit / disable feature)
- **DCO**: Developer Certificate of Origin sign-off confirming contribution rights

## Quick Reference Commands

```bash
# Ruby development workflow
git checkout -b issue-123-fix-mutex-leak
bundle install
rubocop --auto-correct  # Fix style issues
rake test              # Run test suite
git add .
git commit -m "fix(mutex): prevent memory leak in cleanup (issue-123)" -s
git push -u origin issue-123-fix-mutex-leak
gh pr create --base main --head issue-123-fix-mutex-leak --title "#123: Fix mutex memory leak" --draft
gh pr edit <PR_NUMBER> --add-label "Aspect: Stability"

# Testing and coverage
rake test                    # Run all tests
ruby test/test_win32_mutex.rb # Run specific test
COVERAGE=true rake test      # Run with coverage (if available)

# Linting
rubocop                      # Check style
rubocop --auto-correct       # Auto-fix issues
rubocop --auto-gen-config    # Generate config for legacy code
```

## AI-Assisted Development & Compliance

- ✅ Create PR with `ai-assisted` label (if label doesn't exist, create it with description "Work completed with AI assistance following Progress AI policies" and color "9A4DFF")
- ✅ Include "This work was completed with AI assistance following Progress AI policies" in PR description

### Jira Ticket Updates (MANDATORY)

- ✅ **IMMEDIATELY after PR creation**: Update Jira ticket custom field `customfield_11170` ("Does this Work Include AI Assisted Code?") to "Yes"
- ✅ Use atlassian-mcp tools to update the Jira field programmatically
- ✅ **CRITICAL**: Use correct field format: `{"customfield_11170": {"value": "Yes"}}`
- ✅ Verify the field update was successful

### Documentation Requirements

- ✅ Reference AI assistance in commit messages where appropriate
- ✅ Document any AI-generated code patterns or approaches in PR description
- ✅ Maintain transparency about which parts were AI-assisted vs manual implementation

### Workflow Integration

This AI compliance checklist should be integrated into the main development workflow Step 4 (Pull Request Creation):

```
Step 4: Pull Request Creation & AI Compliance
- Step 4.1: Create branch and commit changes WITH SIGNED-OFF COMMITS
- Step 4.2: Push changes to remote
- Step 4.3: Create PR with ai-assisted label
- Step 4.4: IMMEDIATELY update Jira customfield_11170 to "Yes"
- Step 4.5: Verify both PR labels and Jira field are properly set
- Step 4.6: Provide complete summary including AI compliance confirmation
```

- **Never skip Jira field updates** - This is required for Progress AI governance
- **Always verify updates succeeded** - Check response from atlassian-mcp tools
- **Treat as atomic operation** - PR creation and Jira updates should happen together
- **Double-check before final summary** - Confirm all AI compliance items are completed

### Audit Trail

All AI-assisted work must be traceable through:

1. GitHub PR labels (`ai-assisted`)
2. Jira custom field (`customfield_11170` = "Yes")
3. PR descriptions mentioning AI assistance
4. Commit messages where relevant
