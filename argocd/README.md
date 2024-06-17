# ArgoCD Examples

This directory showcases best practices for using ArgoCD to deploy and manage Linkerd and related Kubernetes resources using GitOps workflows.

## Directory Structure

The `argocd` directory is organized as follows:

```
├── buoyant-operator-example
└── helm-example
    ├── apps
    │   ├── cert-manager
    │   │   ├── base
    │   │   │   ├── cert-manager.yaml
    │   │   │   └── trust-manager.yaml
    │   │   ├── kustomization.yaml
    │   │   ├── ns.yaml
    │   │   └── overlays
    │   │       └── example
    │   └── linkerd-control-plane
    │       ├── base
    │       │   ├── certs
    │       │   │   ├── cert-manager-rbac.yaml
    │       │   │   ├── linkerd-ca-trust-bundle.yaml
    │       │   │   └── linkerd-issuers-certs.yaml
    │       │   ├── linkerd-buoyant-enterprise-secret.yaml
    │       │   ├── linkerd-control-plane.yaml
    │       │   └── linkerd-crds.yaml
    │       ├── kustomization.yaml
    │       ├── ns.yaml
    │       └── overlays
    │           └── example
    │               ├── example-env-control-plane-values.yaml
    │               └── patch.yaml
    └── argocd
        ├── apps
        │   ├── cert-manager.yaml
        │   ├── linkerd-buoyant.yaml
        │   └── linkerd.yaml
        ├── kustomization.yaml
        └── projects
            ├── infra.yaml
            └── linkerd.yaml
```

- **helm-example**: Includes Helm-based configurations for deploying Buoyant Enterprise Linkerd components and related resources with ArgoCD.
    - **apps**: Contains ArgoCD application definitions, manifests, and related resources.
    - **cert-manager**: Contains configurations for Cert-Manager resources.
    - **argocd**: Includes ArgoCD app-of-apps application definitions and project configurations.

## Prerequisites

Before using these examples, ensure the following prerequisites are met:

1. **Install ArgoCD**: Follow the official [ArgoCD installation guide](https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/) to set up ArgoCD on your cluster. For a quick start, you can run the following commands to install ArgoCD with all the required base resources:

   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```
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

Clone this repository and explore the examples within the `argocd` directory. Each sub-directory contains additional instructions explaining how to apply these configurations to your Kubernetes cluster using ArgoCD with that specific deployment method. Feel free to adjust the instructions and descriptions according to your specific use case and audience.