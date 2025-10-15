# Infrastructure

## Kurtosis

### Ethereum L1
Deploy a vanilla Ethereum L1 network:
```bash
kurtosis run github.com/ethpandaops/ethereum-package --args-file infra/kurtosis/ethereum-l1/network_params.yaml
```

### Optimism L2
Deploy an OP Stack L2 (includes L1 automatically):
```bash
kurtosis run github.com/ethpandaops/optimism-package --args-file infra/kurtosis/optimism-l2/network_params.yaml
```

## Docker
Custom Docker images and configurations.
