#!/bin/bash
dropDB(){
	while true; do
	     	echo  "-----------------------------------------"
		if [ -z "$(ls ./Databases 2> /dev/null)" ];then
		       	echo "there is no databases to drop"
		       	echo "-----------------------------------------"
			exit
		fi
		echo "Enter db name to drop or type 'exit' to return to the main menu"
    		read -r DBname
    		if [[ ${DBname,,} = "back" ]]; then
        		echo "Back to main menu"
        		echo "-----------------------------------------"
        		return
    		elif [[ ${DBname,,} = "exit" ]] ; then
        		echo "-----------------------------------------"
        		return
    		elif ! [[ "$DBname" =~ ^[a-zA-Z][A-Za-z_0-9]*$ ]]; then
        		echo "Invalid Database Name"
    		elif ! [ -d "./Databases/$DBname" ]; then
        		echo "Database '$DBname' doesn't exist"
    		elif [ -d "./Databases/$DBname" ]; then
        		rm -r "./Databases/$DBname" && echo "DB '$DBname' deleted" || echo "Failed to delete DB '$DBname'"
        		echo "-----------------------------------------"
        		break
    		fi
	done
}
dropDB
