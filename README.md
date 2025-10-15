# FlashFeed Monorepo

A monorepo for FlashFeed infrastructure, containing custom node implementations, deployment configurations, and documentation.

## Repository Structure

```
flashfeed-monorepo/
├── docs/                           # Design docs & architecture
│   ├── architecture/              # Architecture documentation
│   ├── decisions/                 # ADRs (Architecture Decision Records)
│   └── setup/                     # Setup guides
│
├── infra/                         # Infrastructure & deployment configs
│   ├── kurtosis/
│   │   ├── ethereum-l1/          # L1 configs for ethereum-package
│   │   └── optimism-l2/          # L2 configs for optimism-package
│   └── docker/                    # Custom Docker images
│
├── nodes/                         # Forked node implementations
│   └── rblib/                     # Fork of flashbots/rblib (reth-based)
│                                  # (Managed as separate git repo)
│
├── packages/                      # Custom kurtosis packages
│   └── flashfeed-optimism/       # Customized optimism deployment
│
└── scripts/                       # Automation scripts
```

## Quick Start

### 1. Initialize the Repository

Run the setup command to clone the rblib fork and create all necessary files:

```bash
make setup
```

This will:
- Clone your rblib fork into `nodes/rblib/`
- Set up upstream remote to flashbots/rblib
- Create all documentation and configuration templates

### 2. Deploy Ethereum L1 (Vanilla)

Deploy a vanilla Ethereum L1 testnet:

```bash
make run-l1
```

### 3. Deploy Optimism L2

Deploy an OP Stack L2 rollup (automatically includes L1):

```bash
make run-l2
```

### Available Make Commands

Run `make help` to see all available commands:

```bash
make help
```

Common commands:
- `make setup` - Initialize repository
- `make run-l1` - Deploy L1 testnet
- `make run-l2` - Deploy L2 rollup
- `make stop` - Stop all enclaves
- `make clean` - Clean up Docker resources
- `make build-rblib` - Build rblib node
- `make test-rblib` - Test rblib node

## Working with rblib

The `nodes/rblib/` directory is a separate git repository (your fork of flashbots/rblib).

```bash
cd nodes/rblib

# Make changes and commit
git add .
git commit -m "Your changes"
git push origin main

# Sync with upstream flashbots/rblib
git fetch upstream
git merge upstream/main
```

## Customizing Deployments

### Ethereum L1

Edit `infra/kurtosis/ethereum-l1/network_params.yaml` to customize:
- Client types (geth, nethermind, besu, erigon, etc.)
- Number of nodes
- Network parameters

See [ethereum-package documentation](https://github.com/ethpandaops/ethereum-package) for all options.

### Optimism L2

Edit `infra/kurtosis/optimism-l2/network_params.yaml` to customize:
- OP Stack execution clients (op-geth, op-reth, op-erigon, op-nethermind)
- Number of chains (multi-chain Superchain support)
- Alternative DA layers
- Rollup Boost configuration

See [optimism-package documentation](https://github.com/ethpandaops/optimism-package) for all options.

### Advanced: Custom Kurtosis Package

For deeper customization, create your own Kurtosis package in `packages/flashfeed-optimism/` that imports and extends the optimism-package.

## Prerequisites

- [Kurtosis](https://docs.kurtosis.com/install)
- [Docker](https://docs.docker.com/get-docker/)
- Git

## Resources

- [Kurtosis Documentation](https://docs.kurtosis.com)
- [ethereum-package](https://github.com/ethpandaops/ethereum-package)
- [optimism-package](https://github.com/ethpandaops/optimism-package)
- [OP Stack Documentation](https://docs.optimism.io/stack/getting-started)
- [flashbots/rblib](https://github.com/flashbots/rblib)