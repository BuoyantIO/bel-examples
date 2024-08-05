#!/bin/bash

# Apply multicluster CRDs
kubectl apply -f cluster2-multicluster-crds.yaml

# Set up authentication policies for the "App" and Emojivoto gateways
kubectl apply -f cluster2-gateway-app-auth.yaml
kubectl apply -f cluster2-gateway-emojivoto-auth.yaml

# Deploy the gateway applications
kubectl apply -f cluster2-gateway-app-deploy.yaml
kubectl apply -f cluster2-gateway-emojivoto-deploy.yaml

# Deploy the backend components
kubectl apply -f cluster2-server-deploy.yaml
kubectl apply -f cluster2-emojivoto-deploy.yaml

# Configure service mirroring RBAC and permissions
kubectl apply -f cluster2-app-servicemirror.yaml
kubectl apply -f cluster2-emojivoto-servicemirror.yaml

# Define granular authentication policies
kubectl apply -f cluster2-auth.yaml

