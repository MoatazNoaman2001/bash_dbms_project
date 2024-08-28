#!/bin/bash
listTable(){
	echo "--------------------------------"
	tables=$(ls | grep -v .metadata)
	if [ -z $tables ]; then
		echo "no tables created yet in current database"
	else 
		echo "$tables"
	fi
	echo "--------------------------------"
}

listTable "$1"
