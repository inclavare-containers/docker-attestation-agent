Attestation Agent (AA) is a service function set for attestation procedure in Confidential Containers. It provides several kinds of service APIs related to attestation.

For more details, please visit [Attestation Agent](https://github.com/confidential-containers/guest-components/blob/main/attestation-agent/README.md)

This repository packages AA into an easy-to-use image.

# Build Attestation Agent (AA) Image

AA offers 2 kinds of interface, gRPC and ttrpc. Please choose corresponding dockerfile to build your AA image.

## Prerequisites

- A Docker-enabled system

## Build Image

```
# download code
git clone --recurse-submodules git@github.com:1570005763/attestation-agent-image.git && cd attestation-agent-image

# build AA image with gRPC interface
docker build -f ./Dockerfile.grpc -t attestation-agent:grpc .

# or build AA image with ttrpc interface
docker build -f ./Dockerfile.ttrpc -t attestation-agent:ttrpc .
```

# Run Attestation Agent (AA) image with Docker

gRPC image and ttrpc image run in a slightly different way.

## Prerequisites

- A Docker-enabled system
- Already have AA image
- TEE-supported CPU, including:
    - Intel TDX
    - Intel SGX DCAP
    - AMD SEV-SNP
    - Azure SEV-SNP CVM
    - Azure TDX CVM
    - Arm Confidential Compute Architecture (CCA)

## Config

You can modify the configuration of AA by setting the following environment variables when starting the container.

### AA_KBC_PARAMS

- Usage： specify the KBC type and KBS address.
- Optional Value: AA_KBC_PARAMS=cc_kbc::{KBS_address}
- Default Value: AA_KBC_PARAMS=cc_kbc::http://127.0.0.1:8085

### RUST_LOG

- Usage： determine log level.
- Optional Value: RUST_LOG={error, warn, info, debug, trace}
- Default Value: RUST_LOG=debug

## gRPC interface

Run image in the background.
```
docker run -d \
    -p 50002:50002 \
    --name attestation-agent-grpc attestation-agent:grpc
```

Or run image in interactive mode.
```
docker run -it \
    -p 50002:50002 \
    --name attestation-agent-grpc attestation-agent:grpc /bin/bash
# when in container, run:
./attestation-agent
```

## ttrpc interface

Run image in the background.
```
docker run -d \
    -v /run/confidential-containers/attestation-agent/:/run/confidential-containers/attestation-agent/ \
    --name attestation-agent-ttrpc attestation-agent:ttrpc
```

Or run image in interactive mode.
```
docker run -it \
    -v /run/confidential-containers/attestation-agent/:/run/confidential-containers/attestation-agent/ \
    --name attestation-agent-ttrpc attestation-agent:ttrpc /bin/bash
# when in container, run:
./attestation-agent
```