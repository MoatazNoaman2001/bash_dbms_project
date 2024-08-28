#!/bin/bash

createDB(){
	while [ true ]
	do 
		echo "____________________________________________"
		echo "enter database name or type exit for return"

		read DBname
		if [ ${DBname,,} = "back" ]; then 
		       echo "back to main"
		       echo "---------------------------------------"return;
	       elif [ ${DBname,,} = "exit" ]; then
		       echo "exited"
		       echo "---------------------------------------"
		       return;
	       elif [ -z ${DBname} ]; then echo "Database name should not be empty"; continue
	       elif ! [[ "${DBname}" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
		       echo "Invalid DB Name it must start with a letter and only contains letters, numbers and underscores"
	       elif [ -d ./Databases/${DBname} ]; then 
		       echo "Database name is already exit"
	       else 
		       mkdir -p ./Databases/${DBname} && echo "database $DBname created" || echo "Failed creation"
		       echo "---------------------------------------"
		       return 
		fi 
	done 		
}

createDB
