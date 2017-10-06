#!/usr/bin/env sh
set -e

# Delete files from parent repo build, allowing a local build.
rm -rf ${TMP_DRUPAL_BUILD_DIR}
mkdir -p ${TMP_DRUPAL_BUILD_DIR}

rm -f /usr/bin/drupal
