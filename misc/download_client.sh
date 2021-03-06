#!/usr/bin/env bash

set -e

if [ "$1" = '8.0' ]; then
    client='https://my.vertica.com/client_drivers/8.0.x/8.0.1/vertica-client-8.0.1-0.x86_64.tar.gz'
elif [ "$1" = '8.1' ]; then
    client='https://my.vertica.com/client_drivers/8.1.x/8.1.1-13/vertica-client-8.1.1-13.x86_64.tar.gz'
elif [ "$1" = '9.0' ]; then
    client='https://my.vertica.com/client_drivers/9.0.x/9.0.1-4/vertica-client-9.0.1-4.x86_64.tar.gz'
elif [ "$1" = '9.1' ] ; then
    client='https://my.vertica.com/client_drivers/9.1.x/9.1.1-0/vertica-client-9.1.1-0.x86_64.tar.gz'
else
    echo "Wrong Vertica version"
    exit 1
fi

wget --no-check-certificate $client > /dev/null
tar -xvf vertica-client*.tar.gz -C /
rm -f vertica-client*.tar.gz