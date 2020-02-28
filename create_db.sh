#!/bin/bash

#require curl, jq

#api secret
API_SECRET=$(cat common/config/params-local.php | grep apisecret | awk -F"'" '{print $4}')

#Your domain
DOMAIN=api.toir.local.net

#sid. Int Number . Database number exmaple for default : 1 => create .db1
SID=1

#file for pid number
PID_FILE=pid.txt

echo 'Select database action:'
echo "1 - create"
echo "2 - check"
echo "3 - exit"

function create_database {

    echo "sid : "$SID
    echo "domain : "$DOMAIN

    STRING_CREATE="$SID$API_SECRET"
    HASH_CREATE=`echo -n $STRING_CREATE | md5sum`

    echo "HASH_CREATE = "$HASH_CREATE
    echo "Create service"
    echo curl "http://${DOMAIN}/control-panel/create-service?sid=$SID&hash=${HASH_CREATE:0:32}"

    JSON=$(curl "http://${DOMAIN}/control-panel/create-service?sid=$SID&hash=${HASH_CREATE:0:32}")

    echo "JSON : "$JSON

    PID=$(echo $JSON | jq '.pid' | tr -dc '0-9')

    if [ $PID ]; then
        echo "PID : "$PID
        echo "export PID to file "$PID_FILE
        echo $(echo $JSON | jq '.pid' | tr -dc '0-9' > $PID_FILE )
        check_database
    fi

}

function check_database  {
    echo "Check creating db..."
    echo "PID_FILE : " $PID_FILE

    PID=`cat $PID_FILE`

    echo "PID : "$PID
    echo "sid : "$SID
    echo "domain : "$DOMAIN
    STRING_CHECK="$SID$PID$API_SECRET"
    echo "SRING_CHECK : "$STRING_CHECK
    HASH_CHECK=`echo -n $STRING_CHECK | md5sum`
    echo "HASH_CHECK : "$HASH_CHECK
    JSON_CHECK=$(curl "http://${DOMAIN}/control-panel/check-status-migrate?sid=$SID&pid=$PID&hash=${HASH_CHECK:0:32}")
    echo "JSON_CHECK : "$JSON_CHECK
    STATUS=`echo $JSON_CHECK | jq -r '.status'`
    echo "STATUS : "$STATUS

    function call_check_database {

        JSON_CHECK=$(curl "http://${DOMAIN}/control-panel/check-status-migrate?sid=$SID&pid=$PID&hash=${HASH_CHECK:0:32}")
        echo "JSON_CHECK : "$JSON_CHECK
        STATUS=`echo $JSON_CHECK | jq -r '.status'`
        echo "STATUS : "$STATUS
        if [ $STATUS == complete ]; then
            user_login=$(echo $JSON_CHECK | jq '.username')
            password=$(echo $JSON_CHECK | jq '.password')
            echo "Create database complite"
            echo "Login : "$user_login
            echo "Password : "$password
    #        For save to file uncomment
    #        echo $user_login" : "$password > admin.txt
    #        echo "admin.txt crated"
        fi
        echo "PID : "$PID
    }


    if [[ -z $STATUS ]]; then
        echo 'STATUS error. Is empty'
        exit
    fi

    while [ $STATUS == process ] ; do
        call_check_database
        sleep 5
        echo "STATUS : "$STATUS
    done

}

read -r doing
case $doing in
1)
    echo "create database"
    create_database
    ;;
2)
    echo "check database"
    check_database
    ;;
3)
    echo "Goodbye"
    exit 0
    ;;
esac