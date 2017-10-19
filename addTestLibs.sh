#!/usr/bin/env sh
set -e

# Add upstream depenedencies for testing
cd ${DRUPAL_BEHAT_TESTING_ROOT}
curl -O https://raw.githubusercontent.com/unb-libraries/drupal-behat-testing-libraries/8.x-1.x/composer.json
