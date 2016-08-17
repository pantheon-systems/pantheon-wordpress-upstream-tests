#!/bin/bash

./check-required.sh

set -ex

###
# Delete the environment used for this test run.
###
yes | terminus site delete-env --remove-branch
