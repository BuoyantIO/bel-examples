# Terraform Examples

This directory showcases best practices for using Terraform to deploy and manage Linkerd and related Kubernetes resources using Gitops worklflows.

## Directory Structure

The `terraform` directory is organized as follows:

```
├── environments
│   └── example
│       ├── certs
│       │   ├── cert-manager-rbac.yaml
│       │   ├── linkerd-ca-trust-bundle.yaml
│       │   └── linkerd-issuers-certs.yaml
│       ├── main.tf
│       ├── providers.tf
│       └── vars.tf
└── modules
    ├── cert-manager
    │   ├── main.tf
    │   └── vars.tf
    ├── linkerd
    │   ├── linkerd-buoyant-enterprise-secret.yaml
    │   ├── main.tf
    │   └── vars.tf
    └── linkerd-buoyant
        ├── main.tf
        └── vars.tf
```

- **environments/example**: Contains Terraform configurations for deploying various components within a specific environment.
- **modules/**: Contains reusable Terraform modules for deploying specific Kubernetes resources.
    - **cert-manager**: A module for deploying Cert-Manager, a certificate management controller for Kubernetes.
    - **linkerd**: A module for deploying Linkerd, a service mesh for Kubernetes.
    - **linkerd-buoyant**: A module for deploying Buoyant Enterprise Linkerd components.

## Prerequisites

Before using these examples, ensure the following prerequisites are met:

1. **Terraform Installed**: Ensure Terraform is installed on your machine. You can download it from the official Terraform website.

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

To deploy the resources defined in this directory, navigate to the environments/example directory and run the following Terraform commands:

```
terraform init
terraform plan
terraform apply
```

Ensure you review the plan output to confirm the actions Terraform will take before applying the changes.
Modules Overview

Each module within the modules directory is designed to be reusable and can be invoked from the environments/example/main.tf file. Review the main.tf file in each module directory for specific usage instructions and required variables.