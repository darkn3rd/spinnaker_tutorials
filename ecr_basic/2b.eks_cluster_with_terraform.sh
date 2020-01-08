#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh
cd $PROJECT_HOME

# get name of cluster
TIMESTAMP=$(date +%s)

# set Terraform variables
export TF_VAR_eks_cluster_name=attractive-sculpture-${TIMESTAMP}
export TF_VAR_region=$(aws configure get region \
  --profile ${AWS_PROFILE:-"default"}
)
# save Terraform vars for later use
echo "TF_VAR_eks_cluster_name=$TF_VAR_eks_cluster_name" >> env.sh
echo "TF_VAR_region=$TF_VAR_region" >> env.sh

# dangerous
terraform apply  -auto-approve

export KUBECONFIG=${PROJECT_HOME}/kubeconfig_${TF_VAR_eks_cluster_name}
# save KUBECONFIG env var for later use
echo "KUBECONFIG=$KUBECONFIG" >> env.sh
