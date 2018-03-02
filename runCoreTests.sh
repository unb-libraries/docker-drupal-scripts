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
travis/upstream/testDrupal.sh
travis/upstream/testPersistentContent.sh

# PHP unit tests
DOCKER_EXEC_STRING="docker exec $DOCKER_DRUPAL_CONTAINER_NAME}"
DOCKER_EXEC_DRUSH="$DOCKER_EXEC_STRING drush --yes --root=/app/html --uri=default"
DRUPAL_TEST_CLASS_ARR=(${DRUPAL_TEST_CLASSES//:/ })

$DOCKER_EXEC_DRUSH en simpletest

for CUR_TEST_CLASS in "${DRUPAL_TEST_CLASS_ARR[@]}"
do
    $DOCKER_EXEC_STRING su nginx -s /bin/sh -c "php /app/html/core/scripts/run-tests.sh --url http://127.0.0.1 --php /usr/bin/php --die-on-fail --class '$CUR_TEST_CLASS'"
done

$DOCKER_EXEC_DRUSH pm-uninstall simpletest

# Behat tests
docker exec -i -t ${DOCKER_DRUPAL_CONTAINER_NAME} /scripts/runTests.sh
