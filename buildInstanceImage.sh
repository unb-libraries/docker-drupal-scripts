#!/usr/bin/env bash

# Pull the latest version of the upstream image.
docker pull ${DOCKER_UPSTREAM_IMAGE}

# Install dependencies.
composer install

# Build themes.
vendor/bin/dockworker container:theme:build-all

# Determine date string for tagging
BUILD_DATE=$(date '+%Y%m%d%H%M')
IMAGE_TAG="$BUILD_BRANCH-$BUILD_DATE"

# Build image.
docker build --no-cache -t ${SERVICE_NAME}:${IMAGE_TAG} .
docker tag ${SERVICE_NAME}:${IMAGE_TAG} ${AMAZON_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
docker push ${AMAZON_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}

# Also Tag default build_branch.
docker build -t ${SERVICE_NAME}:${BUILD_BRANCH} .
docker tag ${SERVICE_NAME}:${BUILD_BRANCH} ${AMAZON_ECR_URI}/${SERVICE_NAME}:${BUILD_BRANCH}
docker push ${AMAZON_ECR_URI}/${SERVICE_NAME}:${BUILD_BRANCH}
