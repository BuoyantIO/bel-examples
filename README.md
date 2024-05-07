# Buoyant Linkerd Enterprise Examples Repository

Welcome to our Buoyant Enterprise Linkerd examples repository, showcasing best practices and configurations for managing Kubernetes clusters and applications in production using ArgoCD, Flux, Terraform, and related CD tools. This repository provides a structured collection of examples that can serve as a reference for deploying and managing enterprise-grade workloads in Kubernetes environments.

## Table of Contents

- [Introduction](#introduction)
- [Folder Structure](#folder-structure)
- [Examples](#examples)
  - [ArgoCD](#argocd)
  - [Flux](#flux)
    - [Buoyant Cloud & Buoyant Operator Example](#buoyant-operator-example)
    - [Helm Example](#helm-example)
  - [Linkerd TLS Automation Examples](#linkerd-tls-automation-examples)
  - [Terraform](#terraform)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Introduction

In this repository, we demonstrate various deployment patterns and configurations for managing Kubernetes resources using GitOps practices with commong CD tools including ArgoCD, Flux, and Terraform. Additionally, we provide best practice examples of integrating and automating service mesh configurations with Linkerd for at-scale enterprise environments.

## Examples

### ArgoCD

The `argocd` directory contains examples of ArgoCD application manifests for deploying and managing Kubernetes resources.

### Flux

#### Buoyant Cloud & Buoyant Operator Example

The `buoyant-operator-example` directory showcases how to use Flux to manage the deployment of Buoyant Cloud and/or the [Buoyant Lifecycle Operator](https://docs.buoyant.io/buoyant-enterprise-linkerd/latest/features/operator/).

#### Helm Example

The `helm-example` directory provides Flux configurations for deploying applications using Helm releases, organized into different categories.

### Linkerd TLS Automation Examples

This directory houses example issuer, cert, and configuration files to automate TLS management for Linkerd service mesh deployments.

### Terraform

The `terraform` directory includes Terraform configurations for provisioning Kubernetes clusters and associated infrastructure.

## Getting Started

To get started with these examples, clone this repository locally and explore the folders relevant to your interests. Each directory contains README files and detailed examples that can be applied or adapted to your own Kubernetes environments.

## Contributing

We welcome contributions! If you have additional examples or improvements to existing configurations, please fork this repository, make your changes, and submit a pull request.

## License

This repository is licensed under the [MIT License](LICENSE). Feel free to use and modify the examples provided here for your own projects.

---

Feel free to customize this README template further to include specific instructions, prerequisites, or additional details relevant to your audience. Happy documenting and showcasing your enterprise Kubernetes examples!

