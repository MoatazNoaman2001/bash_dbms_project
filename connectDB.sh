#!/bin/bash

checkDB(){
	while [ true ]
	do 
		echo --------------------------------
		dbs=(ls -F ./Databases)

		if ! [ -d Databases ] || [ -z "$dbs" ]; then 
		       echo "No Database created before"; exit; 
		fi 
		echo "enter databse name: "
		read -r name 
		if [ ${name,,} == "back" ]; then
			echo 'return to main menu';
			echo "--------------------------------------"
			return;
		elif [ ${name,,} == "exit" ]; then
			echo "--------------------------------------"
			exit;
		elif ! [[ ${name} =~ ^[a-zA-Z][a-zA-Z0-9_] ]]; then
			echo "invalid database name"
		elif ! [ -d "./Databases/$name" ]; then 
			echo "no database exit with that name"
		else 
			cd "./Databases/$name" && echo "successfully connected to database" || "Failed Connection"
			echo "-------------------------------------"
			return;
		fi 
	done
}

createTable(){
	../../createTable "$1"
}

dropTable(){
	../../dropTable "$1"
}

listTables(){
	../../listTable "$1"
}


connectDB{
	checkDB
	PS3="Connected to DB '$DBname' || choose your option or press Enter to show options again: "
  	select task in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "back to main"
  	do
   	 if [ ${REPLY,,} = "back"  ]; then
      		echo  "-----------------------------------------"
     		 return
  	 elif [ ${REPLY,,} = "exit" ]; then
      		echo  "-----------------------------------------"
      		return
    	fi
    	
	case $task in 
		"Create Table") createTable "$DBname" ;;
		"List Table") listTables "$DBname" ;;
		"Drop Table") dropTable "$DBname" ;;
		* ) echo "still in dev mode" ;;
	esac

  done
}

connectDB

