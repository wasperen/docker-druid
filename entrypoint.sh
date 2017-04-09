#!/bin/bash
set -e

# java options
JO_HISTORICAL = "conf/druid/historical/jvm.conf"
JO_BROKER     = "conf/druid/broker/jvm.conf"
JO_COORDINATOR= "conf/druid/coordinator/jvm.conf"
JO_OVERLORD   = "conf/druid/overlord/jvm.conf"
JO_MIDDLEMGR  = "conf/druid/middleManager/jvm.conf"
JO_EXTRA      = ""

# class paths
CP_COMMON     = "conf/druid/_common"
CP_HISTORICAL = "conf/druid/historical"
CP_BROKER     = "conf/druid/broker"
CP_COORDINATOR= "conf/druid/coordinator"
CP_OVERLORD   = "conf/druid/overlord"
CP_MIDDLEMGR  = "conf/druid/moddleManager"
CP_LIB        = "lib/*"
CP_EXTRA      = ""

# class
CLASS_DRUID   = "io.druid.cli.Main"

cd /opt/druid/current

# if this is the first run, or we ask for a re-init
if [ "$1" = 'init'] || [! -d "var" ]; then
	if [ -d "var" ]; then
		rm -rf var
	fi
	bin/init
	if [ "$1" = 'init' ]; then
		exit 0
	fi
fi

# services to start
if [ "$1" = 'historical']; then
	JAVA_OPTIONS = $JO_HISTORICAL
	CLASS_PATH = "$CP_COMMON:$CP_HISTORICAL:$CP_LIB:$CP_EXTRA"
fi

if [ "$1" = 'broker']; then
	JAVA_OPTIONS = $JO_BROKER
	CLASS_PATH = "$CP_COMMON:$CP_BROKER:$CP_LIB:$CP_EXTRA"
fi

if [ "$1" = 'coordinator']; then
	JAVA_OPTIONS = $JO_COORDINATOR
	CLASS_PATH = "$CP_COMMON:$CP_COORDINATOR:$CP_LIB:$CP_EXTRA"
fi

if [ "$1" = 'overlord']; then
	JAVA_OPTIONS = $JO_OVERLORD
	CLASS_PATH = "$CP_COMMON:$CP_OVERLORD:$CP_LIB:$CP_EXTRA"
fi

if [ "$1" = 'middleManager']; then
	JAVA_OPTIONS = $JO_MIDDLEMGR
	CLASS_PATH = "$CP_COMMON:$CP_MIDDLEMGR:$CP_LIB:$CP_EXTRA"
fi

exec java $(cat $JAVA_OPTIONS) | xargs -cp $CLASS_PATH $CLASS_DRUID server $1