AA_COMMIT ?=

default_aa_commit := 03fcb12c4cd8471e59e0ea4752e945ea46e7dc65

ifeq ($(AA_COMMIT),)
    aa_commit := $(default_aa_commit)
else
    aa_commit := $(AA_COMMIT)
endif

no_cache :=
ifneq ($(findstring $(aa_commit),$(default_aa_commit)),$(default_aa_commit))
    no_cache := --no-cache
endif

.PHONE: all build build-image-grpc build-image-ttrpc

all: help

help: ## Print this help information
	@awk -F ':|##' '/^[^\t].+?:.*?##/ { printf "\033[36m%-20s\033[0m", $$1; for (i=3; i<=NF; i++) printf " %s", $$i; printf "\n" }' $(MAKEFILE_LIST)

build: build-grpc build-ttrpc ## Build the attestation-agent images with AA_COMMIT to set the commit to build

build-grpc: ## Build the attestation-agent grpc image with AA_COMMIT to set the commit to build
	@echo "\033[1;32mBuilding the attestation-agent for grpc with the commit $(aa_commit) ...\033[0m"
	docker build \
	    $(no_cache) --build-arg AA_COMMIT=$(aa_commit) \
	    -f ./Dockerfile.grpc -t attestation-agent:grpc .

build-ttrpc: ## Build the attestation-agent ttrpc image with AA_COMMIT to set the commit to build
	@echo "\033[1;32mBuilding the attestation-agent for ttrpc with the commit $(aa_commit) ...\033[0m"
	docker build \
	    $(no_cache) --build-arg AA_COMMIT=$(aa_commit) \
	    -f ./Dockerfile.ttrpc -t attestation-agent:ttrpc .
