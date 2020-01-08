#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh
cd $PROJECT_HOME

# install helm chart
helm3 repo add stable https://kubernetes-charts.storage.googleapis.com/
helm3 install \
  --values $PROJECT_HOME/spinnaker.values.yaml \
  --generate-name \
  --timeout 5m \
  --wait \
  stable/spinnaker
