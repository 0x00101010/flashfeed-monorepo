.PHONY: help setup clean run-l1 run-l2 stop build test docs

# Default target
help:
	@echo "FlashFeed Monorepo - Available Commands"
	@echo ""
	@echo "Setup & Installation:"
	@echo "  make setup          - Initialize repository (clone rblib fork, create configs)"
	@echo "  make clean          - Clean Kurtosis enclaves and Docker resources"
	@echo ""
	@echo "Deployment:"
	@echo "  make run-l1         - Deploy Ethereum L1 testnet"
	@echo "  make run-l2         - Deploy Optimism L2 rollup (includes L1)"
	@echo "  make stop           - Stop all running Kurtosis enclaves"
	@echo ""
	@echo "Development:"
	@echo "  make build-rblib    - Build rblib node"
	@echo "  make test-rblib     - Test rblib node"
	@echo ""
	@echo "Documentation:"
	@echo "  make docs           - Generate/view documentation"

# Setup the repository
setup:
	@echo "Running initialization script..."
	@bash scripts/init.sh

# Clean up Kurtosis enclaves and Docker resources
clean:
	@echo "Cleaning up Kurtosis enclaves..."
	@kurtosis enclave rm -a || true
	@echo "Pruning Docker resources..."
	@docker system prune -f

# Deploy Ethereum L1
run-l1:
	@echo "Deploying Ethereum L1 testnet..."
	@kurtosis run github.com/ethpandaops/ethereum-package \
		--enclave ethereum-l1 \
		--args-file infra/kurtosis/ethereum-l1/network_params.yaml

# Deploy Optimism L2 (includes L1)
run-l2:
	@echo "Deploying Optimism L2 rollup..."
	@kurtosis run github.com/ethpandaops/optimism-package \
		--enclave optimism-l2 \
		--args-file infra/kurtosis/optimism-l2/network_params.yaml

# Stop all Kurtosis enclaves
stop:
	@echo "Stopping all Kurtosis enclaves..."
	@kurtosis enclave stop -a

# Build rblib
build-rblib:
	@if [ ! -d "nodes/rblib" ]; then \
		echo "Error: nodes/rblib not found. Run 'make setup' first."; \
		exit 1; \
	fi
	@echo "Building rblib..."
	@cd nodes/rblib && cargo build --release

# Test rblib
test-rblib:
	@if [ ! -d "nodes/rblib" ]; then \
		echo "Error: nodes/rblib not found. Run 'make setup' first."; \
		exit 1; \
	fi
	@echo "Testing rblib..."
	@cd nodes/rblib && cargo test

# Documentation
docs:
	@echo "Opening documentation..."
	@echo "Documentation is located in docs/"
	@ls -la docs/