# 🎯 CI/CD Quick Reference

## Status Dashboard

| Workflow | Tests | Duration | Status |
|----------|-------|----------|--------|
| **tests.yml** | 159+ | ~2 min | ✅ Running |
| **build.yml** | 3 OS × 2 Swift | ~10 min | ✅ Running |
| **quality.yml** | 5 checks | ~5 min | ✅ Running |
| **coverage.yml** | 4 jobs | ~8 min | ✅ Running |

## Workflow Triggers

### Automatic (No Action Needed)
```
✅ On push to main or develop
✅ On pull request to main or develop
✅ Daily schedule (2 AM UTC)
```

### Manual Trigger
```bash
git commit --allow-empty -m "Trigger CI"
git push origin feature-branch
```

## Test Commands

### Local Testing (Before Push)
```bash
# Full test suite
swift test

# Specific test
swift test --filter 'GPURenderer'

# Parallel execution (faster)
swift test --parallel

# With coverage
swift test --enable-code-coverage
```

### Build Commands
```bash
# Debug build
swift build

# Release build
swift build -c release

# Verbose output
swift build -v
```

## Common Issues & Solutions

### Issue: Tests Timeout
**Solution:**
```bash
# Increase timeout locally
timeout 120 swift test
```

### Issue: Cache Issues
**Solution:**
- Clear cache: Delete `.build` directory
- Push will automatically rebuild cache

### Issue: Format Check Fails
**Solution:**
```bash
# Install swift-format
brew install swift-format

# Format code
swift-format -i -r Sources/
```

### Issue: SwiftLint Warnings
**Solution:**
```bash
# Install SwiftLint
brew install swiftlint

# Check violations
swiftlint lint Sources/ Tests/

# Fix violations
swiftlint --fix Sources/ Tests/
```

## CI Artifacts

### Downloaded from CI
- Test coverage reports
- Performance metrics
- Build logs

### Location
```
GitHub Actions > [Workflow] > Artifacts
```

## Environment Variables

Available in CI:
```yaml
GITHUB_REF         # Branch reference
GITHUB_SHA         # Commit SHA
GITHUB_ACTOR       # User who triggered
RUNNER_OS          # Operating system
```

## Viewing Results

1. **GitHub Actions Tab**
   - Repository → Actions tab
   - Select workflow
   - View logs and artifacts

2. **Codecov Integration**
   - Coverage reports
   - Trend analysis
   - PR comments with coverage

3. **Status Checks on PR**
   - Green ✅ = All checks pass
   - Red ❌ = Some checks failed
   - Yellow ⏳ = Running

## Debugging Failed Workflows

### Step 1: Read Error Message
```
Search for "Error:" in workflow logs
```

### Step 2: Reproduce Locally
```bash
swift test --filter '[test-name]'
swift build -c release
```

### Step 3: Check Configuration
```
Review .github/workflows/*.yml
Verify Swift version matches
Check dependencies in Package.swift
```

### Step 4: View Full Logs
- Click "Raw logs" in workflow
- Search for specific error
- Check timestamps for duration

## Performance Optimization

### For Faster CI
1. **Local pre-checks:**
   ```bash
   swift build && swift test
   ```

2. **Parallel execution:**
   - Already enabled in CI
   - Saves ~50% time

3. **Caching:**
   - Automatic on second run
   - Manual clear: Delete `.build`

### For Faster Local Testing
```bash
# Parallel + incremental
swift test --parallel

# Skip integration tests
swift test --filter '!Integration'

# Test specific component
swift test --filter 'LuxeCard'
```

## Required for All PRs

✅ **Must Pass:**
1. All tests (swift test)
2. SwiftLint (swiftlint lint)
3. Build (swift build)
4. Format (swift-format)

✅ **Recommended:**
1. Local testing before push
2. Code review
3. No conflicts with main

## Emergency: Disable CI

**Not Recommended** - Only for critical hotfixes:

```bash
git commit --allow-empty --no-verify -m "Emergency fix"
git push --no-verify origin main
```

**Note:** This bypasses all checks - should be rare!

## Getting Help

| Issue | Resource |
|-------|----------|
| Swift Errors | Swift Docs: swift.org |
| Test Failures | Check test logs in CI |
| Build Issues | Run `swift build -v` locally |
| CI Questions | Check .github/CI-README.md |

## Monthly Maintenance

- [ ] Review failed CI runs
- [ ] Update Swift version if needed
- [ ] Review security reports
- [ ] Check coverage trends
- [ ] Update dependencies

## Useful Commands for Developers

```bash
# Check Swift version
swift --version

# List all test suites
swift test --list

# Run tests with verbose output
swift test -v

# Clean build cache
rm -rf .build

# Generate documentation
swift package generate-documentation

# Format all code
swift-format -i -r Sources/ Tests/

# Lint check
swiftlint lint --strict Sources/
```

## Key Metrics

Current Status:
- ✅ 159+ Tests Passing
- ✅ 47 Test Suites
- ✅ GPU Pipeline Operational
- ✅ All Platforms Supported
- ✅ Zero Security Issues

Target Metrics:
- 🎯 80%+ Code Coverage
- 🎯 <2 minute CI time
- 🎯 <20 second build (release)
- 🎯 Zero regressions

---

**Quick Reference Version:** 1.0  
**Last Updated:** March 14, 2026
