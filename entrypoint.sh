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

if [ "$1" = 'init']; then
	if [ -d "var" ]; then
		rm -rf var
	fi
	bin/init
	exit 0
fi

if [ "$1" = 'historical']; then
	java $(cat ${JO_HISTORICAL}) | xargs -cp "${CP_COMMON}:${CP_HISTORICAL}:${CP_LIB}:${CP_EXTRA}" ${CLASS_DRUID} server historical
fi

if []