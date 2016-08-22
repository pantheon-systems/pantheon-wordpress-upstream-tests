#!/bin/bash

set -ex

./check-required.sh

###
# Delete the environment used for this test run.
###
yes | terminus site delete-env --remove-branch
