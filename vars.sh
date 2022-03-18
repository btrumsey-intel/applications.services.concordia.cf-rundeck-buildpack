#!/bin/bash

export JRE_URL="https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz"
#export JRE_URL="https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_linux_hotspot_8u212b03.tar.gz"
export RUNDECK_WAR="rundeck-${RUNDECK_VERSION}.war"
export RUNDECK_DIST_URL="https://packagecloud.io/pagerduty/rundeck/packages/java/org.rundeck/${RUNDECK_WAR}/artifacts/${RUNDECK_WAR}/download"