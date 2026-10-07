# AGENTS.md — AI Agent Instructions for openshift/velero-plugin-for-gcp

## Project Overview
This is the OpenShift fork of the Velero Plugin for Google Cloud Platform (GCP). It provides Velero plugins for GCP services: an object store plugin for Google Cloud Storage (GCS) and a volume snapshotter plugin for GCE Persistent Disks. Maintained on the `oadp-dev` branch with UBI-based container images for the OADP ecosystem.

- **Primary Language**: Go
- **Module**: `github.com/vmware-tanzu/velero-plugin-for-gcp`
- **Default Branch**: `oadp-dev`

## Build Instructions
```bash
# Build the plugin binary locally
make local

# Build container image
make container
```

## Test Instructions
```bash
# Run all tests
make test

# Run CI checks (modules verification + tests)
make ci

# Run specific tests
go test ./velero-plugin-for-gcp/... -run TestName

# Vet code
go vet ./...
```

## Module Management
```bash
# Update Go modules
make modules

# Verify modules are tidy
make verify-modules
```

## Code Conventions
- Plugin implementations in `velero-plugin-for-gcp/` directory
- Follow Velero plugin interface patterns (ObjectStore, VolumeSnapshotter)
- Google Cloud Go SDK for API interactions
- Changelog entries in `changelogs/`
- Example configurations in `examples/`

## Project Structure
```
velero-plugin-for-gcp/  - Plugin implementation
  object_store.go       - GCS object store plugin
  volume_snapshotter.go - GCE Persistent Disk volume snapshotter
changelogs/             - Release changelog entries
examples/               - Example Velero configurations for GCP
hack/                   - Build and CI scripts
```

## CI/CD
- GitHub Actions workflows in `.github/workflows/`:
  - `push.yml` — Push CI
  - `pr-merge.yml` — PR merge automation
  - `auto_assign_prs.yml` — Auto-assign PR reviewers
  - `auto_request_review.yml` — Auto-request reviews
- Reproduce CI locally:
  ```bash
  make ci
  ```

## Common Tasks

### Modifying the GCS object store plugin
1. Edit `velero-plugin-for-gcp/object_store.go`
2. Run tests: `make test`
3. Add changelog entry

### Modifying the GCE disk snapshotter
1. Edit `velero-plugin-for-gcp/volume_snapshotter.go`
2. Run tests: `make test`
3. Add changelog entry

### Updating OADP-specific patches
- OADP patches live on the `oadp-dev` branch
- UBI-based Dockerfile: `Dockerfile.ubi`
