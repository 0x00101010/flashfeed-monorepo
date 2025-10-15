# Claude Context File

This file provides context for AI assistants (like Claude) working on this repository.

## Project Overview

FlashFeed is a monorepo for building and deploying a custom Ethereum L1 and Optimism L2 rollup infrastructure. The project uses a fork of flashbots/rblib (reth-based execution client) and Kurtosis for deployment orchestration.

## Repository Structure

```
flashfeed-monorepo/
├── docs/                      # Design docs, architecture, ADRs
├── infra/                     # Infrastructure configs (Kurtosis, Docker)
├── nodes/rblib/              # Fork of flashbots/rblib (separate git repo)
├── packages/                  # Custom Kurtosis packages
├── scripts/                   # Automation scripts
├── Makefile                   # Build/deploy automation
└── .gitignore                # Git ignore (excludes nodes/rblib/)
```

## Key Concepts

### 1. Nested Git Repository Pattern

- `nodes/rblib/` is a **separate git repository** (fork of flashbots/rblib)
- It's **excluded** from the parent repo's git tracking via `.gitignore`
- Work on rblib is done independently with its own git workflow
- Origin: `git@github.com:0x00101010/rblib.git`
- Upstream: `https://github.com/flashbots/rblib.git`

### 2. Kurtosis Deployment

- **L1**: Uses `ethpandaops/ethereum-package`
- **L2**: Uses `ethpandaops/optimism-package` (which includes L1 automatically)
- Configs are in `infra/kurtosis/{ethereum-l1,optimism-l2}/network_params.yaml`

### 3. Build System

- Primary interface: **Makefile** at repo root
- Run `make help` for all available commands
- Initialization: `make setup` (runs `scripts/init.sh`)

## Common Tasks

### Initial Setup
```bash
make setup  # Clones rblib fork, creates config files
```

### Deployment
```bash
make run-l1  # Deploy Ethereum L1
make run-l2  # Deploy Optimism L2 (includes L1)
make stop    # Stop all enclaves
make clean   # Clean up Docker resources
```

### Working with rblib
```bash
cd nodes/rblib
# Work normally with git
git add . && git commit -m "message" && git push
# Sync with upstream
git fetch upstream && git merge upstream/main
```

### Building rblib
```bash
make build-rblib  # cargo build --release in nodes/rblib/
make test-rblib   # cargo test in nodes/rblib/
```

## Technology Stack

- **Execution Clients**: reth (via rblib fork), op-geth, op-reth
- **Consensus Clients**: lighthouse, teku, prysm
- **Orchestration**: Kurtosis
- **Containerization**: Docker
- **Languages**: Rust (rblib), Starlark (Kurtosis packages)

## Important Notes for AI Assistants

1. **Never modify nodes/rblib/ from parent repo** - It's a separate git repo
2. **Use Makefile for tasks** - Don't suggest raw kurtosis/docker commands
3. **Kurtosis configs are YAML** - Located in `infra/kurtosis/`
4. **Custom packages go in packages/** - For extending optimism-package
5. **scripts/init.sh must work from repo root** - It uses `REPO_ROOT` variable

## File Conventions

- **Documentation**: Markdown in `docs/`
- **ADRs**: Architecture Decision Records in `docs/decisions/`
- **Configs**: YAML files in `infra/kurtosis/`
- **Scripts**: Bash scripts in `scripts/`
- **Custom packages**: Starlark (`.star`) files in `packages/`

## Dependencies

- Kurtosis CLI
- Docker Desktop
- Git with SSH configured (for rblib fork)
- Rust toolchain (for building rblib)

## Useful Context for Prompts

When asking for help, include:
- What component you're working on (L1/L2/rblib/infra)
- Current step in your workflow (setup/deploy/build/test)
- Relevant config files or error messages

Example prompts:
- "Help me customize the L1 network to use 5 geth nodes"
- "How do I modify rblib to add custom RPC endpoints?"
- "Debug why my L2 deployment is failing"
- "Add a new make target for running integration tests"

## Related Resources

- [Kurtosis Docs](https://docs.kurtosis.com)
- [ethereum-package](https://github.com/ethpandaops/ethereum-package)
- [optimism-package](https://github.com/ethpandaops/optimism-package)
- [flashbots/rblib](https://github.com/flashbots/rblib)
- [OP Stack Docs](https://docs.optimism.io/stack/getting-started)
- [Reth Book](https://reth.rs)

## Future Plans

- Custom Kurtosis package in `packages/flashfeed-optimism/`
- Custom Docker images in `infra/docker/`
- Integration tests
- Production deployment configs
- Monitoring and observability setup
