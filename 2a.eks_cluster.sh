#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh

export TIMESTAMP=$(date +%s)
export CLUSTER_NAME=attractive-sculpture-${TIMESTAMP}
# save CLUSTER_NAME env var for later use
echo "CLUSTER_NAME=$CLUSTER_NAME" >> env.sh

eksctl create cluster \
  --name=${CLUSTER_NAME} \
  --full-ecr-access \
  --kubeconfig=${PROJECT_HOME}/${CLUSTER_NAME}-kubeconfig.yaml

export KUBECONFIG=${PROJECT_HOME}/${CLUSTER_NAME}-kubeconfig.yaml
# save KUBECONFIG env var for later use
echo "KUBECONFIG=$KUBECONFIG" >> env.sh
