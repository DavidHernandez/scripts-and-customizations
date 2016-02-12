#!/bin/bash

# $1: project name
# $2: domain extension

if [[ -z "$1" ]]; then
    echo "Usage: $0 [project name] [domain extension (optional)]" >&2
    exit 1
fi

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

if [[ -z "$2" ]]; then
    EXT="com"
else
    EXT=$2
fi

cp -fr /home/david/CLIENT/scripts/newproject /home/david/CLIENT/$1

sed -i -- "s/PROJECT/$1/g" /home/david/CLIENT/$1/vhost.conf
sed -i -- "s/EXT/$EXT/g" /home/david/CLIENT/$1/vhost.conf

mv /home/david/CLIENT/$1/vhost.conf $1/dev.$1.$EXT.conf

cp /home/david/CLIENT/$1/dev.$1.$EXT.conf /etc/apache2/sites-available/
ln -s /etc/apache2/sites-available/dev.$1.$EXT.conf /etc/apache2/sites-enabled/dev.$1.$EXT.conf

echo "127.0.0.1 dev.$1.$EXT" >> /etc/hosts

chown -R david:david /home/david/CLIENT/$1

service apache2 restart
