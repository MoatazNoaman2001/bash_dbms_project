#!/bin/bash
dropTable(){
	echo "---------------------------------"
	if [ -z "$(ls)" ]; then 
		echo "No tables created in current database"
		exit;
	fi
	read -rp "Enter Table Name to Delete or Exit to return to Main menu: $1" tableName

	if ![[ ${tableName,,} = "back" || ${tableName,,} = "exit" ]]; then 
		echo "---------------------------------"
		exit;
	elif [ -z "$tableName" ]; then 
		echo "table name should not to be empty"
		continue;
	elif ! [[ "$tableName" =~ ^[a-zA-Z][A-Za-z_0-9]*$ ]]; then
            	echo "Invalid table name. It must start with a letter and only contain letters, numbers, and underscores."
        elif ! [ -f "./$tableName" ] && ! [ -f "./$tableName.metadata" ]; then
            	echo "Table '$tableName' doesn't exist"
        else
		if [ -f "./$tableName" ]; then
                    rm -f "./$tableName"
                    if [ $? -ne 0 ]; then
                        echo "Failed to delete '$tableName'"
                        echo  "-----------------------------------------"
                        exit 1
                    else
                        echo "Data of '$tableName' is deleted"
                    fi
                fi
                if [ -f "./$tableName.metadata" ]; then
                    rm -f "./$tableName.metadata"
                    if [ $? -ne 0 ]; then
                        echo "Failed to delete '$tableName.metadata'"
                        echo  "-----------------------------------------"
                        exit 1
                    else
                        echo "Metadata for '$tableName' is deleted"
                    fi
                fi
                echo "'$tableName' is deleted successfully"
                echo  "-----------------------------------------"
		exit 0
	fi
}
dropTable $1
