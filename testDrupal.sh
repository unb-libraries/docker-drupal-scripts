#!/usr/bin/env bash
# Runs Drupal tests.
docker exec ${DOCKER_DRUPAL_CONTAINER_NAME} drush --root=${APP_WEBROOT} --uri=default en --yes simpletest

TESTS[0]='\Drupal\user\Tests\UserLoginTest'
TESTS[1]='\Drupal\node\Tests\PageViewTest'
TESTS[2]='\Drupal\system\Tests\File\UrlRewritingTest'
TESTS[3]='\Drupal\file\Tests\FilePrivateTest'

for TEST_CLASS in TESTS; do
  docker exec ${DOCKER_DRUPAL_CONTAINER_NAME} su nginx -s /bin/sh -c "php ${APP_WEBROOT}/core/scripts/run-tests.sh --url http://127.0.0.1 --php /usr/bin/php --die-on-fail --class '${TEST_CLASS}'"
done
