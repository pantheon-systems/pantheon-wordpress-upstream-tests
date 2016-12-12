#!/bin/bash

# Echo commands as they are executed, but don't allow errors to stop the script.
set -x

if [ -z "$TERMINUS_SITE" ] || [ -z "$TERMINUS_ENV" ]; then
  echo "TERMINUS_SITE and TERMINUS_ENV environment variables must be set"
  exit 1
fi

# Only delete old environments if there is a pattern defined to
# match environments eligible for deletion. Otherwise, delete the
# current multidev environment immediately.
#
# To use this feature, set MULTIDEV_DELETE_PATTERN to '^ci-' or similar
# in the CI server environment variables.
if [ -z "$MULTIDEV_DELETE_PATTERN" ] ; then
  terminus site delete-env --remove-branch --yes
  exit 0
fi

# List all but the newest two environments.
OLDEST_ENVIRONMENTS=$(terminus site environments --format=bash | sort -k2 | cut -d ' ' -f 1 | grep "$MULTIDEV_DELETE_PATTERN" | sed -e '$d' | sed -e '$d')

# Exit if there are no environments to delete
if [ -z "$OLDEST_ENVIRONMENTS" ] ; then
  exit 0
fi

# Go ahead and delete the oldest environments.
for ENV_TO_DELETE in $OLDEST_ENVIRONMENTS ; do
  terminus site delete-env --env=$ENV_TO_DELETE --remove-branch --yes
done
