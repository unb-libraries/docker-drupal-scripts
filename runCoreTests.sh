#!/usr/bin/env bash
docker-compose build
docker-compose up -d
travis/upstream/waitForDeploy.sh
travis/upstream/testDrupal.sh

# Test persistent content
travis/upstream/generatePersistentContent.sh
docker-compose stop
sleep 30
docker-compose up -d
travis/upstream/waitForDeploy.sh
travis/upstream/testPersistentContent.sh

# Run tests
docker exec -i -t ${DOCKER_DRUPAL_CONTAINER_NAME} /scripts/runTests.sh
