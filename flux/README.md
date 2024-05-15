# Flux Examples

This directory showcases best practices for using Flux to deploy and manage Linkerd and related Kubernetes resources using GitOps worklows.

## Directory Structure

The `flux` directory is organized as follows:

```
├── buoyant-operator-example
└── helm-example
    ├── apps
    │   ├── linkerd
    │   │   ├── certs
    │   │   │   ├── cert-manager-rbac.yaml
    │   │   │   ├── linkerd-ca-trust-bundle.yaml
    │   │   │   └── linkerd-issuers-certs.yaml
    │   │   ├── helmrelease-linkerd-control-plane.yaml
    │   │   ├── helmrelease-linkerd-crds.yaml
    │   │   ├── helmrepo.yaml
    │   │   ├── kustomization.yaml
    │   │   ├── linkerd-enterprise-secret.yaml
    │   │   └── namespace.yaml
    │   └── linkerd-buoyant
    │       ├── helmrelease-linkerd-buoyant.yaml
    │       ├── helmrepo.yaml
    │       ├── kustomization.yaml
    │       ├── linkerd-enterprise-secret.yaml
    │       └── namespace.yaml
    ├── clusters
    │   └── example
    │       ├── apps.yaml
    │       ├── flux-system
    │       │   ├── gotk-components.yaml
    │       │   ├── gotk-sync.yaml
    │       │   └── kustomization.yaml
    │       └── infra.yaml
    └── infra
        └── controllers
            ├── cert-manager.yaml
            └── kustomization.yaml
```

- **helm-example**: Includes Helm-based configurations for deploying Buoyant Enterprise Linkerd components and related resources with Flux.
    - **apps**: Contains Flux HelmRelease definitions, manifests, and related resources.
    - **cert-manager**: Contains configurations for Cert-Manager resources.
    - **clusters**: Provides segmentation per cluster/environment and allows for quick Flux bootstrapping.
    - **infra**: Contains Flux definitions for managing controllers and infrastructure-related resources.

## Prerequisites

Before using these examples, ensure the following prerequisites are met:

1. **Install Flux**: Follow the official [Flux installation guide](https://toolkit.fluxcd.io/guides/installation/) to set up Flux on your cluster. You can also clone this repo and use a command similar to the following to bootstrap Flux and deploy Buoyant Enterprise Linkerd with all the associated repo resources:

   ```bash
   flux bootstrap git \
   --url=ssh://git@github.com:22/Org/repo_name.git \
   --private-key-file=$HOME/path/to/your/git-repo-deployment-key \
   --path=/flux/helm-example/clusters/example
   ```
    **Note:** This bootstrap command above assumes you have a [github deployment key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys) already in place.

2. **Install and Create Sealed-Secrets**: This example makes use of Sealed Secrets to securely manage and store secrets in a public repository. Refer to [Sealed Secrets documentation](https://sealed-secrets.netlify.app/) for installation instructions and examples. For a quick start, you will want to install [kubseal](https://github.com/bitnami-labs/sealed-secrets?tab=readme-ov-file#kubeseal) and run the following commands to create a publicly committable secret:


   ```bash
   # Install Sealed Secrets controller

   helm add repo sealed-secrets https://bitnami-labs.github.io/sealed-secrets 
   helm install sealed-secrets -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets

   # Fetch and store kubeseal encryption cert

   kubeseal --fetch-cert \
   --controller-name=sealed-secrets-controller \
   --controller-namespace=kube-system \
   > $HOME/path/to/pub-sealed-secrets.pem

   # Create and seal a temp secret

   export BUOYANT_LICENSE=<buoyant_license_value>
   kubectl -n linkerd create secret generic buoyant-license \
   --from-literal=license="$BUOYANT_LICENSE" \
   --dry-run=client \
   -o yaml > tmp_secret_buoyant.yaml

   # Create GitOps compatible secret

   kubeseal --format=yaml --cert=$HOME/path/to/pub-sealed-secrets.pem < tmp_secret_buoyant.yaml > linkerd-buoyant-enterprise-secret.yaml
   ```

    Replace `<buoyant_license_value>` with your actual Buoyant license value when creating the secret.

    **Note:** You will need to create a sealed secret in all namespaces where you plan to install Buoyant Enterprise Linkerd components. 


## Usage

Clone this repository and explore the examples within the `flux` directory. Each sub-directory contains additional instructions explaining how to apply these configurations to your Kubernetes cluster using Flux with that specific deployment method. Feel free to adjust the instructions and descriptions according to your specific use case and audience.