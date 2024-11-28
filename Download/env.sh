#!/bin/bash
export LINK=$(cat link) && rm link
export TARGET=$(cat target) && rm target
export EXCLUDE=$(cat exclude) && rm exclude
export EXTRA=true
echo "TARGET=$TARGET" >> $GITHUB_ENV
