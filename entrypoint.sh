#!/bin/bash
set -e

# general options
CONF_DIR      = "conf"
ENVIRONMENT   = "druid"

# class paths
CP_COMMON     = "conf/druid/_common"
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

JAVA_OPTIONS = "$CONF_DIR/$ENVIRONMENT/$1/jvm.conf"
CLASS_PATH   = "$CP_COMMON:$CONF_DIR/$ENVIRONMENT/$1:$CP_LIB:$CP_EXTRA"

exec java $(cat $JAVA_OPTIONS) | xargs -cp $CLASS_PATH $CLASS_DRUID server $1