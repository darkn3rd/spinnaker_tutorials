#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh
cd $PROJECT_HOME

# identify and target first pod/gate in cluster
export DECK_POD=$(kubectl get pods \
  --namespace default \
  --selector "cluster=spin-deck" \
  --output jsonpath="{.items[0].metadata.name}"
)
export GATE_POD=$(kubectl get pods \
  --namespace default \
  --selector "cluster=spin-gate" \
  --output jsonpath="{.items[0].metadata.name}"
)

# save values for later usage
echo "DECK_POD=$DECK_POD" >> env.sh
echo "GATE_POD=$GATE_POD" >> env.sh

# forward ports so that they are available on localhost
kubectl port-forward --namespace default $DECK_POD 9000 &
kubectl port-forward --namespace default $GATE_POD 8084 &
