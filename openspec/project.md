# Project Context

## Purpose
Homebrew tap for distributing Plan42 CLI binaries. Provides formula definitions and tooling to publish and validate the tap.

## Tech Stack
- Homebrew formulae under `Formula/`
- Makefile helpers invoking Homebrew audit/style commands

## Project Conventions

### Code Style
Follow Homebrew formula conventions (Ruby DSL). Keep version, SHA, and artifact URLs in sync with released binaries.

### Architecture Patterns
Single tap repository with formula definitions. No additional source code beyond the Homebrew DSL and supporting docs.

### Testing Strategy
Run `make lint` to tap locally, audit, and style-check the formula before pushing changes.

### Git Workflow
Use feature branches for formula updates. Include version bumps and checksum changes together; keep commit messages descriptive (e.g., `plan42 1.2.3`).

## Domain Context
Formula installs the `plan42` CLI from published artifacts. Tap name is `plan42/tap` with usage documented in the README.

## Important Constraints
- Ensure URLs and SHA256 hashes match released artifacts to avoid install failures.
- Homebrew audit/style requirements must pass for new versions.

## External Dependencies
- Homebrew tooling (`brew` command)
- Plan42 artifact hosting used in formula URLs
