# Buoyant Linkerd Enterprise Examples Repository

Welcome to our Buoyant Enterprise Linkerd examples repository, showcasing best practices and configurations for managing Kubernetes clusters and applications in production using ArgoCD, Flux, Terraform, and related CD tools. This repository provides a structured collection of examples that can serve as a reference for deploying and managing enterprise-grade workloads in Kubernetes environments.

## Table of Contents

- [Introduction](#introduction)
- [Folder Structure](#folder-structure)
- [Gitops](#gitops)
  - [ArgoCD](#argocd)
  - [Flux](#flux)
  - [Terraform](#terraform)
- [Linkerd TLS Automation Examples](#linkerd-tls-automation-examples)
- [Architecture References](#architecture-references)
  - [Multicluster Gateway Auth Policy](#multicluster-gateway-auth-policy)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Introduction

In this repository, we demonstrate various deployment patterns and configurations for managing Kubernetes resources using GitOps practices with commong CD tools including ArgoCD, Flux, and Terraform. Additionally, we provide best practice examples of integrating and automating service mesh configurations with Linkerd for at-scale enterprise environments.

## Gitops

### ArgoCD

The `argocd` directory contains examples of ArgoCD application manifests for deploying and managing Linkerd Kubernetes resources.

### Flux

The `flux` directory contains examples of Flux application manifests and kustomize files for deploying and managing Linkerd Kubernetes resources.

### Terraform

The `terraform` directory includes Terraform configurations for provisioning Kubernetes clusters and associated infrastructure.

## Linkerd TLS Automation Examples

This directory houses example issuer, cert, and configuration files to automate TLS management for Linkerd service mesh deployments.

## Architecture References

### Multicluster Gateway Auth Policy

This directory houses configuration examples showcasing how Linkerd's authorization policies can be configured granularly using multicluster gateway mode to achieve zero-trust security and least-priviledged app access segmentation across separate clusters.

## Getting Started

To get started with these examples, clone this repository locally and explore the folders relevant to your interests. Each directory contains README files and detailed examples that can be applied or adapted to your own Kubernetes environments.

## Contributing

We welcome contributions! If you have additional examples or improvements to existing configurations, please fork this repository, make your changes, and submit a pull request.

## License

This repository is licensed under the [MIT License](LICENSE). Feel free to use and modify the examples provided here for your own projects.

---

Feel free to customize this README template further to include specific instructions, prerequisites, or additional details relevant to your audience. Happy documenting and showcasing your enterprise Kubernetes examples!

