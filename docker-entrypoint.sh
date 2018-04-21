#!/bin/sh -e

# Nginx subs, VIRTUAL_HOST is an override for nginx-proxy development setups
SERVER_PROTO=${SERVER_PROTO:-http}
SERVER_NAME=${VIRTUAL_HOST:-${SERVER_NAME:-localhost}}
SERVER_ALIAS=${SERVER_ALIAS:-''}

envsubst '$SERVER_NAME $SERVER_ALIAS' < /nginx.conf.template > /etc/nginx/nginx.conf

# WordPress subs
WP_SITE_URL=${WP_SITE_URL:-$SERVER_PROTO://$SERVER_NAME}
WP_HOME=${WP_HOME:-$WP_SITE_URL}

supervisord -c /supervisord.conf
