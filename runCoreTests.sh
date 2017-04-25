#!/usr/bin/env bash
docker-compose build
docker-compose up -d
travis/waitForDeploy.sh
travis/testDrupal.sh
travis/generatePersistentContent.sh
docker-compose stop
sleep 30
docker-compose up -d
travis/waitForDeploy.sh
travis/testDrupal.sh
travis/testPersistentContent.sh
docker exec -i -t ${DOCKER_DRUPAL_CONTAINER_NAME} /scripts/runTests.sh