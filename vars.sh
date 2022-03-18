#!/usr/bin/env bash

#export JRE_URL="https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_linux_hotspot_8u212b03.tar.gz"
export JRE_URL="https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz"
export RUNDECK_WAR="rundeck-${RUNDECK_VERSION}.war"
export RUNDECK_DIST_URL="https://packagecloud.io/pagerduty/rundeck/packages/java/org.rundeck/${RUNDECK_WAR}/artifacts/${RUNDECK_WAR}/download"