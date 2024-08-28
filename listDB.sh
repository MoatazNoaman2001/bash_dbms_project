#i/bin/bash

listDB(){ 
	if ! [ -d "./Databases" ]; then
		echo "No Database Folder"
		return;
	fi
	echo "----------------------------"
	dbs=$(ls -F Databases | grep "/")
	if ! [ -d "./Databases" ] || [ -z $dbs ]; then 
		echo "currently no database created"
	else 
		echo "---------------------------------"
		echo "databases: "
		for i in $dbs
		do 
			echo ${i%/}
		done 
	fi 
	echo "------------------------------"		
}

listDB
