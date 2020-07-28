# Kubefreezer

## Description
Freezes the running kubernetes cluster into local yaml manifests.

## Parameters
- CLUSTER_NAME
  - e.g. ```cluster-0```
- NAMESPACES
  - e.g. ```testing,staging,default```
- KUBECONFIG
  - e.g. ```/home/vngu/.kube/config```
- RESOURCES
  - e.g. ```ingresses,configmaps,secrets,deployments```
