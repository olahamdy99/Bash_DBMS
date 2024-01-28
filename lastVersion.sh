#!/bin/bash


echo -e "\n----------------------- Welcome DBMS -----------------------"
echo -e "\n+-------- Written by: Ebtesam Roshdy & Ola Hamdy. ---------+"

# Main menu
function mainMenu 
{
    while true
    do
        echo -e "\n+---------Main Menu-------------+"
        echo "| 1. Create DB                  |"
        echo "| 2. Select DB                  |"
        echo "| 3. Rename DB                  |"
        echo "| 4. Drop DB                    |"   
        echo "| 5. Show DB                    |"               
        echo "| 6. Exit                       |"
        echo "+-------------------------------+"
        read -p "Enter Choice: " choose

        case $choose in
            1)
                CreateDB ;;
            2)
                SelectDB ;;
            3)
                RenameDB ;;
            4)
                DropDB ;;
            5)
                ShowDBS ;;
            6)
                echo -e "Exiting the DBMS script.\n\n"
                exit ;;
            *)
                echo "Wrong Choice. Please try again.\n\n" ;;
        esac
    done
}


#--------------------------------------------

# SelectDB function
function SelectDB
{
    read -p "Enter Database Name: " nameDB

    if [ -d "./DBMS/$nameDB" ]; then
        echo "Database $nameDB was Successfully Selected"
        cd ./DBMS/$nameDB
        tablesMenu 

    else
        echo "Database $nameDB wasn't found"
        while true; do
            Re_entry
            read -p "Enter your choice (1, 2, or 3): " choice

            case $choice in
                1)
                   SelectDB
                    break ;;
                2)
                    mainMenu ;;
                3)
                    echo -e "Exiting the DBMS script.\n\n"
                    exit ;;
                *)
                    echo "Invalid choice." ;;
            esac
        done
    fi
}
#---------------------------------------------------
# CreateDB function
function CreateDB
{
    read -p "Enter name Database: " nameDB

    while true
    do
                if [[ ${#nameDB} -le 2 || ! $nameDB =~ ^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
		    echo "Invalid database name."
		    read -p "Enter name Database: " nameDB
        elif [ -d "./DBMS/$nameDB" ]; then
            echo "Database '$nameDB' already exists. Choose an action:"
            while true; do

                Re_entry

                read -p "Enter your choice (1, 2, or 3): " choice

                case $choice in
                    1)
                        CreateDB
                        ;;
                    2)
                        mainMenu ;;
                    3)
                        echo -e "Exiting the DBMS script.\n\n"
                        exit ;;
                    *)
                        echo "Invalid choice." ;;
                esac
            done
        else
            break
        fi
    done

    mkdir -p "./DBMS/$nameDB"
    echo "Database Created Successfully: $nameDB"
}
#--------------------------------
# ShowDBS function
function ShowDBS
{
    echo -e "\n+--------- List of Databases ---------------+"

    if [ -n "$(ls -A ./DBMS)" ]; then
        for dbName in ./DBMS/*; do
            dbName=$(basename "$dbName")
            echo "| $dbName"
        done
    else
        echo "| No databases found."
    fi

    echo "+-------------------------------------------+"

    mainMenu
}

#---------------------------------
#function Rename database
function RenameDB 
{
    if [ -z "$(ls -a ./DBMS)" ]; then
        echo "Error: No databases found. There's nothing to Rename."
        mainMenu
    fi

    read -p "Enter Current Database Name: " nameDB

    if [ -d "./DBMS/$nameDB" ]; then
        while true; do
            read -p "Enter New Database Name: " newName

            if [[ ${#newName} -le 2 || ! $newName =~ ^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
                echo "Invalid database name."
            elif [ -d "./DBMS/$newName" ]; then
                echo "Database '$newName' already exists. Choose a different name."
            else
                mv "./DBMS/$nameDB" "./DBMS/$newName"
                echo "Database Renamed Successfully"
                break
            fi
        done
    else
        echo "The specified database '$nameDB' does not exist."

	while true; do
	    Re_entry
	    read -p "Enter your choice (1, 2, or 3): " choice
	    case $choice in
		1)
                    RenameDB 
                    break ;;
                    
                2)
                    mainMenu ;;
                3)
                    echo -e "Exiting the DBMS script.\n\n"
                    exit ;;
                *)
                    echo "Invalid choice." ;;
            esac
        done
    fi
}
#--------------------------------------
#function drop database
function DropDB 
{
    if [ -z "$(ls -a ./DBMS)" ]; then
        echo "Error: No databases found. There's nothing to drop."
        mainMenu
    fi

    read -p "Enter Database Name: " nameDB

    if [ -z "$nameDB" ]; then
        echo "Error: Database name cannot be empty."
        return
    fi

    if [ -d "./DBMS/$nameDB" ]; then
        while true; do
            read -p "Are you sure you want to drop the database '$nameDB'? (yes/no): " confirm

            case $confirm in
                yes)
                    rm -r "./DBMS/$nameDB"
                    echo "Database '$nameDB' dropped successfully."
                    return
                    ;;
                no)
                    echo "Database drop canceled."
                    return
                    ;;
                *)
                    echo "Invalid choice. Please enter 'yes' or 'no'."
                    ;;
            esac
        done
    else
        echo "The specified database '$nameDB' does not exist."
        while true; do
	    Re_entry
	    read -p "Enter your choice (1, 2, or 3): " choice
	    case $choice in
	    1)
		    DropDB 
		    break ;;          
           2)
 		    mainMenu ;;

           3)
		    echo -e "Exiting the DBMS script.\n\n"
		    exit ;;
        *)
            echo "Invalid choice." ;;
        esac
    	done
    fi     
}
#-------------------------------------
#function Re-entry again
function Re_entry
{
     echo -e "\n+--------- Menu -------------+"
            echo      "|1. Choose a different name  |"
            echo      "|2. Back Main Menu           |"
            echo      "|3. Exit                     |"
            echo -e   "+----------------------------+"
}

#---------------------------------------

function tablesMenu {
  echo -e "\n+--------Tables Menu------------+"
  echo "| 1. Show Existing Tables       |"
  echo "| 2. Create New Table           |"
  echo "| 3. Insert Into Table          |"
  echo "| 4. Select From Table          |"
  echo "| 5. Update Table               |"
  echo "| 6. Delete From Table          |"
  echo "| 7. Drop Table                 |"
  echo "| 8. Back To Main Menu          |"
  echo "| 9. Exit                       |"
  echo "+-------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1)  ls .; tablesMenu ;;
    2)  createTable ;;
    3)  insert;;
    4)  clear; selectMenu ;;
    5)  updateTable;;
    6)  deleteFromTable;;
    7)  dropTable;;
    8) clear; cd ../.. 2>>./.error.log; mainMenu ;;
    9) exit ;;
    *) echo " Wrong Choice " ; tablesMenu;
  esac

}

function createTable {
  echo -e "Table Name: \c"
  read tableName
  if [[ -f $tableName ]]; then
    echo "table already existed ,choose another name"
    tablesMenu
  fi
  echo -e "Number of Columns: \c"
  read colsNum
  counter=1
  sep="|"
  rSep="\n"
  pKey=""
  metaData="Field"$sep"Type"$sep"key"
  while [ $counter -le $colsNum ]
  do
    echo -e "Name of Column No.$counter: \c"
    read colName

    echo -e "Type of Column $colName: "
    select var in "int" "str"
    do
      case $var in
        int ) colType="int";break;;
        str ) colType="str";break;;
        * ) echo "Wrong Choice" ;;
      esac
    done
    if [[ $pKey == "" ]]; then
      echo -e "Make PrimaryKey ? "
      select var in "yes" "no"
      do
        case $var in
          yes ) pKey="PK";
          metaData+=$rSep$colName$sep$colType$sep$pKey;
          break;;
          no )
          metaData+=$rSep$colName$sep$colType$sep""
          break;;
          * ) echo "Wrong Choice" ;;
        esac
      done
    else
      metaData+=$rSep$colName$sep$colType$sep""
    fi
    if [[ $counter == $colsNum ]]; then
      temp=$temp$colName
    else
      temp=$temp$colName$sep
    fi
    ((counter++))
  done
  touch .$tableName
  echo -e $metaData  >> .$tableName
  touch $tableName
  echo -e $temp >> $tableName
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    tablesMenu
  else
    echo "Error Creating Table $tableName"
    tablesMenu
  fi
}

function dropTable {
  echo -e "Enter Table Name: \c"
  read tName
  rm $tName .$tName 2>>./.error.log
  if [[ $? == 0 ]]
  then
    echo "Table Dropped Successfully"
  else
    echo "Error Dropping Table $tName"
  fi
  tablesMenu
}

function insert {
  echo -e "Table Name: \c"
  read tableName
  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't existed ,choose another Table"
    tablesMenu
  fi
  colsNum=`awk 'END{print NR}' .$tableName`
  sep="|"
  rSep="\n"
  for (( i = 2; i <= $colsNum; i++ )); do
    colName=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' .$tableName)
    colType=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$tableName)
    colKey=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$tableName)
    echo -e "$colName ($colType) = \c"
    read data

    # Validate Input
    if [[ $colType == "int" ]]; then
      while ! [[ $data =~ ^[0-9]*$ ]]; do
        echo -e "invalid DataType !!"
        echo -e "$colName ($colType) = \c"
        read data
      done
    fi

    if [[ $colKey == "PK" ]]; then
      while [[ true ]]; do
        if [[ $data =~ ^[`awk 'BEGIN{FS="|" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $tableName`]$ ]]; then
          echo -e "invalid input for Primary Key !!"
        else
          break;
        fi
        echo -e "$colName ($colType) = \c"
        read data
      done
    fi

    #Set row
    if [[ $i == $colsNum ]]; then
      row=$row$data$rSep
    else
      row=$row$data$sep
    fi
  done
  echo -e $row"\c" >> $tableName
  if [[ $? == 0 ]]
  then
    echo "Data Inserted Successfully"
  else
    echo "Error Inserting Data into Table $tableName"
  fi
  row=""
  tablesMenu
}

function updateTable {
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter Condition Column name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    tablesMenu
  else
    echo -e "Enter Condition Value: \c"
    read val
    res=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $tName 2>>./.error.log)
    if [[ $res == "" ]]
    then
      echo "Value Not Found"
      tablesMenu
    else
      echo -e "Enter FIELD name to set: \c"
      read setField
      setFid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' $tName)
      if [[ $setFid == "" ]]
      then
        echo "Not Found"
        tablesMenu
      else
        echo -e "Enter new Value to set: \c"
        read newValue
        NR=$(awk 'BEGIN{FS="|"}{if ($'$fid' == "'$val'") print NR}' $tName 2>>./.error.log)
        oldValue=$(awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$setFid') print $i}}}' $tName 2>>./.error.log)
        echo $oldValue
        sed -i ''$NR's/'$oldValue'/'$newValue'/g' $tName 2>>./.error.log
        echo "Row Updated Successfully"
        tablesMenu
      fi
    fi
  fi
}

function deleteFromTable {
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter Condition Column name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    tablesMenu
  else
    echo -e "Enter Condition Value: \c"
    read val
    res=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $tName 2>>./.error.log)
    if [[ $res == "" ]]
    then
      echo "Value Not Found"
      tablesMenu
    else
      NR=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print NR}' $tName 2>>./.error.log)
      sed -i ''$NR'd' $tName 2>>./.error.log
      echo "Row Deleted Successfully"
      tablesMenu
    fi
  fi
}

function selectMenu {
  echo -e "\n\n+---------------Select Menu--------------------+"
  echo "| 1. Select All Columns of a Table              |"
  echo "| 2. Select Specific Column from a Table        |"
  echo "| 3. Select From Table under condition          |"
  echo "| 4. Aggregate Function for a Specific Column   |"
  echo "| 5. Back To Tables Menu                        |"
  echo "| 6. Back To Main Menu                          |"
  echo "| 7. Exit                                       |"
  echo "+----------------------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1) selectAll ;;
    2) selectCol ;;
    3) clear; selectCon ;;
    4) ;;
    5) clear; tablesMenu ;;
    6) clear; cd ../.. 2>>./.error.log; mainMenu ;;
    7) exit ;;
    *) echo " Wrong Choice " ; selectMenu;
  esac
}

function selectAll {
  echo -e "Enter Table Name: \c"
  read tName
  column -t -s '|' $tName 2>>./.error.log
  if [[ $? != 0 ]]
  then
    echo "Error Displaying Table $tName"
  fi
  selectMenu
}

function selectCol {
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter Column Number: \c"
  read colNum
  awk 'BEGIN{FS="|"}{print $'$colNum'}' $tName
  selectMenu
}

function selectCon {
  echo -e "\n\n+--------Select Under Condition Menu-----------+"
  echo "| 1. Select All Columns Matching Condition    |"
  echo "| 2. Select Specific Column Matching Condition|"
  echo "| 3. Back To Selection Menu                   |"
  echo "| 4. Back To Main Menu                        |"
  echo "| 5. Exit                                     |"
  echo "+---------------------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1) clear; allCond ;;
    2) clear; specCond ;;
    3) clear; selectCon ;;
    4) clear; cd ../.. 2>>./.error.log; mainMenu ;;
    5) exit ;;
    *) echo " Wrong Choice " ; selectCon;
  esac
}

function allCond {
  echo -e "Select all columns from TABLE Where FIELD(OPERATOR)VALUE \n"
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter required FIELD name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    selectCon
  else
    echo -e "\nSupported Operators: [==, !=, >, <, >=, <=] \nSelect OPERATOR: \c"
    read op
    if [[ $op == "==" ]] || [[ $op == "!=" ]] || [[ $op == ">" ]] || [[ $op == "<" ]] || [[ $op == ">=" ]] || [[ $op == "<=" ]]
    then
      echo -e "\nEnter required VALUE: \c"
      read val
      res=$(awk 'BEGIN{FS="|"}{if ($'$fid$op$val') print $0}' $tName 2>>./.error.log |  column -t -s '|')
      if [[ $res == "" ]]
      then
        echo "Value Not Found"
        selectCon
      else
        awk 'BEGIN{FS="|"}{if ($'$fid$op$val') print $0}' $tName 2>>./.error.log |  column -t -s '|'
        selectCon
      fi
    else
      echo "Unsupported Operator\n"
      selectCon
    fi
  fi
}

function specCond {
  echo -e "Select specific column from TABLE Where FIELD(OPERATOR)VALUE \n"
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter required FIELD name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    selectCon
  else
    echo -e "\nSupported Operators: [==, !=, >, <, >=, <=] \nSelect OPERATOR: \c"
    read op
    if [[ $op == "==" ]] || [[ $op == "!=" ]] || [[ $op == ">" ]] || [[ $op == "<" ]] || [[ $op == ">=" ]] || [[ $op == "<=" ]]
    then
      echo -e "\nEnter required VALUE: \c"
      read val
      res=$(awk 'BEGIN{FS="|"; ORS="\n"}{if ($'$fid$op$val') print $'$fid'}' $tName 2>>./.error.log |  column -t -s '|')
      if [[ $res == "" ]]
      then
        echo "Value Not Found"
        selectCon
      else
        awk 'BEGIN{FS="|"; ORS="\n"}{if ($'$fid$op$val') print $'$fid'}' $tName 2>>./.error.log |  column -t -s '|'
        selectCon
      fi
    else
      echo "Unsupported Operator\n"
      selectCon
    fi
  fi
}

mainMenu
