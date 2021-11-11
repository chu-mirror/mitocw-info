#!/bin/sh

# require password of database to execute this script
if [ $# -lt "2" ]; then
	echo "usage: build.sh <password> scheme|database|backup"
	exit 1
fi
passwd=$1

# the order matters
data_files="instructor course instruction prerequisite"

build_scheme () {
	mysql -p$passwd mitocw < mitocw_scheme.sql
}

build_database () {
	build_scheme
	awk -f sql_insert.awk $data_files | mysql -p$passwd mitocw
}

case $2 in
	"scheme") build_scheme ;;
	"database") build_database ;;
	"backup") mysqldump -p$passwd mitocw > mitocw_scheme.sql;;
esac
