#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh
cd $PROJECT_HOME

# create ECR repository
aws ecr create-repository --repository-name hello-kubernetes

export REPOSITORY_URI=$(
  aws ecr describe-repositories \
    --repository-names hello-kubernetes \
    --query 'repositories[0].repositoryUri' \
    --output text
)

# save REPOSITORY_URI env var
echo "REPOSITORY_URI=$REPOSITORY_URI" >> env.sh

cd ${PROJECT_HOME}/hello-kubernetes

docker build \
  --no-cache \
  --build-arg IMAGE_VERSION="1.5" \
  --build-arg IMAGE_CREATE_DATE="`date -u +"%Y-%m-%dT%H:%M:%SZ"`" \
  --build-arg IMAGE_SOURCE_REVISION="`git rev-parse HEAD`" \
  --file Dockerfile \
  --tag "hello-kubernetes:1.5" .

# docker login to ECR with current token/password
$(aws ecr get-login --no-include-email)

# push image to ECR repository
docker tag hello-kubernetes:1.5 ${REPOSITORY_URI}:v1.5
docker push ${REPOSITORY_URI}
docker tag hello-kubernetes:1.5 ${REPOSITORY_URI}:latest
docker push ${REPOSITORY_URI}
