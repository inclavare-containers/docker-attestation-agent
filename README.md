Attestation Agent (aka AA) is a service for the attestation procedure in
Confidential Computing. It provides several kinds of service APIs related
to attestation.

This repository packages AA into an easy-to-use image.

For more details, please visit the upstream of [Attestation Agent](https://github.com/confidential-containers/guest-components/blob/main/attestation-agent/README.md).

# Build AA Image

AA offers 2 kinds of interface, gRPC and ttrpc. Please choose the corresponding
Dockerfile to build your AA image.

## Prerequisites

- Ensure Docker is installed on your system

## Build Image

```shell
# download code
git clone --recurse-submodules \
    https://github.com/inclavare-containers/attestation-agent.git && \
    cd attestation-agent

# build AA image with gRPC interface
docker build -f ./Dockerfile.grpc -t attestation-agent:grpc .

# or build AA image with ttrpc interface
docker build -f ./Dockerfile.ttrpc -t attestation-agent:ttrpc .
```

# Run AA image with Docker

gRPC or ttrpc image runs in a slightly different way.

## Prerequisites

- Ensure Docker is installed on your system
- AA image is installed
- The running platform supports a CPU-TEE, including:
    - Intel TDX
    - Intel SGX
    - AMD SEV-SNP
    - Azure SEV-SNP CVM
    - Azure TDX CVM
    - Arm Confidential Compute Architecture (CCA)

## Configuration

You can modify the configuration of AA by setting the following environment
variables when starting the container.

### AA_KBC_PARAMS

- Usage: specify the KBC type and KBS address
- Optional Value: AA_KBC_PARAMS=cc_kbc::{KBS_address}
- Default Value: AA_KBC_PARAMS=cc_kbc::http://127.0.0.1:8085

### RUST_LOG

- Usage: determine log level.
- Optional Value: RUST_LOG={error, warn, info, debug, trace}
- Default Value: RUST_LOG=debug

## Run AA image with gRPC interface

Run `attestation-agent:grpc` image.
```shell
docker run -d \
    -p 50002:50002 \
    --name attestation-agent-grpc attestation-agent:grpc
```

## Run AA image with ttrpc interface

Run `attestation-agent:ttrpc` image.
```shell
docker run -d \
    -v /run/confidential-containers/attestation-agent/:/run/confidential-containers/attestation-agent/ \
    --name attestation-agent-ttrpc attestation-agent:ttrpc
```
