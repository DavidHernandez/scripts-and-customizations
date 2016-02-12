#!/bin/bash

# $1: db name
# $2: username
# $3: password

if [[ -z "$1" ]]; then
    echo "Usage: $0 dbname [username [password]]" >&2
    echo "If no password is provided, username will be used." >&2
    echo "If no username is provided, db name will be used." >&2
    exit 1
else
    db=$1
fi

if [[ -z "$2" ]]; then
    user=$db
else
    user=$2
fi

if [[ -z "$3" ]]; then
    pass=$user
else
    pass=$3
fi

echo "Provide MySQL root password"
read -s ROOT

mysql -u root -p$ROOT -e "CREATE DATABASE $db"
mysql -u root -p$ROOT -e "GRANT ALL PRIVILEGES ON $db.* TO '$user'@'localhost' IDENTIFIED BY '$pass'"
