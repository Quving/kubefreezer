[![Build Status](https://drone.quving.com/api/badges/Quving/kubefreezer/status.svg)](https://drone.quving.com/Quving/kubefreezer)

# Kubefreezer
Freezes the running kubernetes cluster into local yaml manifests.

## Motivation
Backups are always useful. Especially when the configuration effort is high like with Kubernetes. Usually you have a few manifests lying around locally. However, over time, they become outdated, because you have made a few small adjustments with "kubectl edit". These undocumented changes accumulate over time and are then simply no longer traceable.

Nowadays there is more and more middleware software available that overlays the kubectl layer to make it easier to use. Rancher for example offers a graphical interface to the kubernetes cluster. With AWS, Azure, Redshift and Google also offer such possibilities. Especially here it is important to store the configurations in a uniform, kubectl conform way somewhere. This is what Kubefreezer offers.

## Environment Variables

| Environment Variable  | Description | Example  |
|---------------------- |----------|-------------|
| CLUSTER_NAME          | Name of the kubernetes-cluster to be backed up  | 'test-cluster-0' |
| NAMESPACES            | Relevant namespaces to be secured | 'default,production,staging,testing' |
| RESOURCES             | Relevant resources to be secored  | 'ingresses.configmaps,secrets,deployments' |
| KUBECTL_OPTIONS (optional) | Options that is passed to kubectl.  | '--insecure-skip-tls-verify' |


## Usage
```bash
#!/bin/bash
docker build -t kubefreezer .
docker run --rm -it \
    -e CLUSTER_NAME='testing-cluster-0' \
    -e NAMESPACES='testing,staging,production,default' \
    -e RESOURCES='ingresses,secrets,configmaps,deployments' \
    -v /path/to/kubeconfig:/app/kubeconfig \
    -v /path/to/backup-dir/:/var/lib/data \
    kubefreezer:v1.1.0
```

## Full Example Script
```
#!/bin/bash
#
# Author:
# Quving (https://github.com/Quving)
#
# Description
# This script creates a backup of the kubernetes-cluster using kubectl. It creates snapshots of different resources.

BACKUP_DIR=manifests/$(date +%F)

mkdir -p $BACKUP_DIR

docker run --rm -it \
    -e CLUSTER_NAME='quving' \
    -e NAMESPACES='default,apps,infrastructure' \
    -e RESOURCES='ingresses,secrets,configmaps,deployments,certificates' \
    -v $(pwd)/kubeconfig:/app/kubeconfig \
    -v $(pwd)/$BACKUP_DIR:/var/lib/data \
    quving/kubefreezer:v1.0.0

```
