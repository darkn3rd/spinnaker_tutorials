#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh

MY_REGION=$(aws configure get region \
  --profile ${AWS_PROFILE:-"default"}
)
MY_ACCOUNT=$(aws sts get-caller-identity \
  --query 'Account' \
  --output text
)
MY_ECR_REGISTRY_NAME=my-ecr-registry

# save values for later usage
echo "MY_REGION=$MY_REGION" >> env.sh
echo "MY_ACCOUNT=$MY_ACCOUNT" >> env.sh
echo "MY_ECR_REGISTRY_NAME=$MY_ECR_REGISTRY_NAME" >> env.sh

# configure helm chart values
sed -e "s/REPLACE_REGION/${MY_REGION}/"  \
    -e "s/REPLACE_ACCOUNT/${MY_ACCOUNT}/"  \
    -e "s/ECR_REGISTRY_NAME/${MY_ECR_REGISTRY_NAME}/" \
    $PROJECT_HOME/spinnaker.template.yaml \
       > $PROJECT_HOME/spinnaker.values.yaml
