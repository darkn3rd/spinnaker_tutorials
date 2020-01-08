#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh

spin application save \
  --application-name my-app \
  --owner-email someone@example.com \
  --cloud-providers kubernetes


sed -e "s/REGION/${MY_REGION}/"  \
    -e "s/ACCOUNT/${MY_ACCOUNT}/"  \
    -e "s/ECR_REGISTRY_NAME/${MY_ECR_REGISTRY_NAME}/" \
    $PROJECT_HOME/hello-kubernetes.template.json \
       > $PROJECT_HOME/hello-kubernetes.json

spin pipeline save -f hello-kubernetes.json
