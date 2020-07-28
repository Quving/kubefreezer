#!/bin/bash
docker build -t kubefreezer .
docker run --rm -it \
    -e CLUSTER_NAME='hoou-cluster-0' \
    -e NAMESPACES='testing,staging,default' \
    -e RESOURCES='ingresses,secrets,configmaps,deployments' \
    -v /Users/vngu/.kube/config:/app/kubeconfig \
    -v $(pwd)/data:/var/lib/data \
    kubefreezer:latest

