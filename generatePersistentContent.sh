#!/usr/bin/env sh
# Generate content to test persistence in a restart.
DRUSH_COMMAND="docker exec ${DOCKER_DRUPAL_CONTAINER_NAME} drush --yes --root=/app/html --uri=default"

${DRUSH_COMMAND} en --yes devel_generate
${DRUSH_COMMAND} --yes genc 5 --types=${TEST_PERSISTENCE_TYPES}
${DRUSH_COMMAND} pm-uninstall devel_generate
