#!/bin/bash

# Apply multicluster CRDs
kubectl apply -f cluster1-multicluster-crds.yaml

# Deploy the frontend client and Emojivoto application components
kubectl apply -f cluster1-client-deploy.yaml
kubectl apply -f cluster1-emojivoto-deploy.yaml

# Set up Kong Ingress for routing within the cluster
kubectl apply -f cluster1-kong-ingress.yaml

# Deploy the Backend namespace where Cluster2 server will be mirrored
kubectl apply -f cluster1-backend-ns.yaml

# Create empty shadow services for HTTPRoute rewrites
kubectl apply -f cluster1-empty-httproute-svcs.yaml

# Configure HTTPRoute rewrite rules
kubectl apply -f cluster1-app-httproute-rewrite.yaml
kubectl apply -f cluster1-emojivoto-httproute-rewrite.yaml

# Define granular and restrictive Linkerd authentication policies
kubectl apply -f cluster1-auth.yaml
