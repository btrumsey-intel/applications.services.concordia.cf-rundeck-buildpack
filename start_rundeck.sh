#!/bin/bash
set -e

BASE_PATH=/home/vcap/app
export RDECK_BASE=${BASE_PATH}/rundeck

echo "-----> Making java available"
export PATH=$PATH:${BASE_PATH}/.java/bin

echo "-----> Starting Rundeck"

ADDITIONAL_ARGS="-Dserver.http.port=${PORT}"

JAVA_CALL="java \
    -Dserver.http.port=${PORT} \
    -jar $RDECK_BASE/rundeck.war \
    -b $RDECK_BASE \
    --skipinstall \
    -d"

echo "-----> Executing $JAVA_CALL"
${JAVA_CALL}