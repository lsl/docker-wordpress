#!/bin/sh -e

# Nginx subs, VIRTUAL_HOST is an override for nginx-proxy development setups
export SERVER_NAME=${VIRTUAL_HOST:-${SERVER_NAME:-localhost}}
export SERVER_ALIAS=${SERVER_ALIAS:-''}

envsubst '$SERVER_NAME $SERVER_ALIAS' < /nginx.conf.template > /etc/nginx/nginx.conf

supervisord -c /supervisord.conf
