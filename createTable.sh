#i/bin/bash

while  true ; do
    echo  "-----------------------------------------"
    read -rp "Enter Table Name you want to create or type 'exit' or back  to return to DB dashboard: $1" tableName
    if [[ ${tableName,,} =~ "back" ]]; then
        echo  "-----------------------------------------"
        exit
    elif [[ ${tableName,,} = "exit" ]]; then
        echo  "-----------------------------------------"
        exit
    elif [ -z $tableName ]; then
        echo "Table name can't be empty"
        continue
    elif ! [[ "$tableName" =~ ^[a-zA-Z][A-Za-z_0-9]*$ ]]; then
        echo "Invalid table name it must start with a letter and only contains letter numbers and underscores"
    elif [[ -f "./$tableName" || -f "./$tableName.metadata" ]]; then
        echo "Table '$tableName' Already exists"
    else
        #touch  $tableName  && echo "table '$tableName' created" || echo "Failed to create table '%tableName' \n"
        break
    fi
done

while [ true ]; do
    echo  "-----------------------------------------"
    read -rp "Enter number of columns in your table type exit to abort :" col
    if [[ ${col,,} = "exit" || ${col,,} = "back" ]]; then
        echo "Creation aborted"
        echo  "-----------------------------------------"
        exit
    elif ! [[ $col =~ ^[0-9]*$ ]]; then
        echo "That's not a number"
        continue
    elif (( $col > 10 || $col <= 0 )); then
        echo "Number of columns must be an integer between 1 And 10"
        continue
    else
        echo  "-----------------------------------------"
        break
    fi
done

echo "Enter your columns labels Note 1st is the primary key  : "
for (( i=0 ; i < $col ; i++ )); do
    echo  "-----------------------------------------"
    read -rp "Enter col number $((i+1)) label: " colabel
    if [ -z "$colabel" ]; then
        echo "Columns label can't be empty"
        ((i--))
        continue
    elif ! [[ "$colabel" =~ ^[a-zA-Z][A-Za-z_0-9]*$ ]]; then
        echo "Invalid column label it must start with a letter and only contains letter numbers and underscores"
        ((i--))
        continue
    elif [[ "${line1[*]}" =~ ${colabel} ]] ; then
        echo "label '$colabel' already exists "
        ((i--))
        continue
    else
        read -p   "type of '$colabel' string or integer (s/i) : " coltype
        case $coltype in
            "s"|"S" ) line2[${i}]="string" ;;
            "i"|"I" ) line2[${i}]="integer" ;;
            * ) echo "invalid type "; ((i--)) ; continue ;;
        esac

        if (( i == 0 )); then
            line3[${i}]="NOTNULL"
            echo "'$colabel' is PK and can't be NULL by default"
        else
            read -p   "Can column '$colabel'  be null (y/n) ? " coltype
            case $coltype in
                "y"|"Y" ) line3[${i}]="NULL" ;;
                "n"|"N" ) line3[${i}]="NOTNULL" ;;
                * ) echo "invalid type "; ((i--)) ; continue ;;
            esac
        fi
        line1[${i}]="$colabel"
    fi
done

touch  $tableName
echo "${line1[@]}" > ./$tableName.metadata
echo "${line2[@]}" >> ./$tableName.metadata
echo "${line3[@]}" >> ./$tableName.metadata
echo "Table '$tableName' created successfully."
echo  "-----------------------------------------"
