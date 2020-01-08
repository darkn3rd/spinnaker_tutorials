#!/usr/bin/env bash

# retrieve earlier variables
source ./env.sh
cd ${PROJECT_HOME}/hello-kubernetes

# make code changes
sed -e 's/#303030/#003399/' \
    -e 's/#505050/#3366cc/' \
    -e 's/#909090/#909090/' \
    static/css/main.css > new.css
mv new.css static/css/main.css

# build new image and use cached layers (only changing main.css)
docker build \
  --build-arg IMAGE_VERSION="1.6" \
  --build-arg IMAGE_CREATE_DATE="`date -u +"%Y-%m-%dT%H:%M:%SZ"`" \
  --build-arg IMAGE_SOURCE_REVISION="`git rev-parse HEAD`" \
  --file Dockerfile \
  --tag "hello-kubernetes:1.6" .

# docker login using refreshed token
$(aws ecr get-login --no-include-email)

# push new image into ECR repository
docker tag hello-kubernetes:1.6 ${REPOSITORY_URI}:v1.6
docker push ${REPOSITORY_URI}
docker tag hello-kubernetes:1.6 ${REPOSITORY_URI}:latest
docker push ${REPOSITORY_URI}
