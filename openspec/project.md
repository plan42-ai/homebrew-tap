# Project notes

## Proxy
- Outbound traffic from our VPCs and runners should go through the debugging-sucks proxy-service, which is a Go-based TLS-inspecting forward proxy behind the AWS GWLB endpoints.
- The proxy enforces an allow list defined in the proxy-service repository; new destinations need to be added there and rolled out via proxy-service-infra before they are reachable.
- For local work, set HTTPS_PROXY/HTTP_PROXY to the environment-specific proxy endpoint and trust the internal CA bundle when TLS interception is enabled.

## Tech stack
- Homebrew tap containing Ruby formula definitions

## Conventions
- Update formula versions and SHA256 in Formula/*.rb when publishing new builds.
- Use brew audit --strict and brew test-bot locally before pushing changes.
- Keep Makefile targets and README instructions in sync with available formulas.

## AI tools
- codex
- claude
