#!/bin/bash

set -e
function  logInfo() {
    color=`tput setaf 2`
    echo -e $2 "[ ${color}Info$(tput sgr0) ]    $(date "+%D-%T")\t $(tput bold)$1$(tput sgr0)"
}

function  logError() {
    color=`tput setaf 1`
    echo -e $2 "[ ${color}Error$(tput sgr0) ]   $(date "+%D-%T")\t $(tput bold)$1$(tput sgr0)"
}

function  logWarn() {
    color=`tput setaf 3`
    echo -e $2 "[ ${color}Warning$(tput sgr0) ] $(date "+%D-%T")\t $(tput bold)$1$(tput sgr0)"
}

ENVS=( CLUSTER_NAME NAMESPACES RESOURCES )
for env in "${ENVS[@]}"; do
    if [ "${!env}" = "" ]; then
       	logError "Please set a value for $env"
	exit -1
    fi
done

# Setup
mkdir -p /var/lib/data

# Configs
DIRECTORY="/var/lib/data/$(date '+%Y-%m-%d')_$CLUSTER_NAME"
IFS=','
KUBECONFIG='./kubeconfig'
read -ra RESOURCES <<< "$RESOURCES"
read -ra NAMESPACES <<< "$NAMESPACES"

# Start Backup Process
echo ""
echo "########## Create Backup ##########"
echo ""
printf '%s:\t%s\n' "Desination" "$DIRECTORY"
printf '%s:\t%s\n' "Namespaces" "${NAMESPACES[*]}"
printf '%s:\t%s\n' "Resources" "${RESOURCES[*]}"
echo ""
echo ""
echo "Logs:"

mkdir -p $DIRECTORY
for resource in "${RESOURCES[@]}"; do
    printf "\t%s\n" "Create backups for resource: $resource..."
    for namespace in "${NAMESPACES[@]}"; do
        file=$DIRECTORY/$resource"_"$i.yaml

        printf '\t\t%s\n' "Backup '$resource' for '$namespace'"
        kubectl get --kubeconfig $KUBECONFIG $resource -n $namespace -o yaml > $file
    done
done
