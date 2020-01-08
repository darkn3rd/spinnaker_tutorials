#!/usr/bin/env bash

export PROJECT_HOME=$HOME/projects/spinnaker-ecr
# save varialbe for later usage
echo "PROJECT_HOME=$PROJECT_HOME" >> env.sh

mkdir -p $PROJECT_HOME && cd $PROJECT_HOME
git clone https://github.com/paulbouwer/hello-kubernetes
