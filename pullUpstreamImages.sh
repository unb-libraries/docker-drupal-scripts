#!/usr/bin/env bash
docker pull mysql:$MYSQL_VERSION
docker pull "$DOCKER_IMAGE_PARENT"
