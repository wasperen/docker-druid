#!/bin/bash
set -e

# general options
CONF_DIR="conf"
ENVIRONMENT="druid"
DEBUG=1

# class paths
CP_COMMON="conf/druid/_common"
CP_LIB="lib/*"
CP_EXTRA=""

# class
CLASS_DRUID="io.druid.cli.Main"

# if this is the first run, or we ask for a re-init
if [ "$1" = "init" ] || [ ! -f "var/_init" ] ; then
	if [ -d "var" ]; then
		rm -rf var/*
	fi
	if [ -d "log" ]; then
		rm -rf log
	fi
	bin/init
	touch var/_init
	if [ "$1" = "init" ]; then
		exit 0
	fi
fi

JAVA_OPTIONS="$CONF_DIR/$ENVIRONMENT/$1/jvm.config"
CLASS_PATH="$CP_COMMON:$CONF_DIR/$ENVIRONMENT/$1:$CP_LIB:$CP_EXTRA"
if [ -z ${DEBUG+x} ] ; then
	echo $JAVA_OPTIONS
	echo $CLASS_PATH
fi

exec java $(cat $JAVA_OPTIONS | xargs) $JAVA_EXTRA_OPTIONS -cp $CLASS_PATH $CLASS_DRUID server $1
