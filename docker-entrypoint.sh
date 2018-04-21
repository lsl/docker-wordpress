#!/bin/sh -e

# Nginx subs, VIRTUAL_HOST is an override for nginx-proxy development setups
export SERVER_PROTO=${SERVER_PROTO:-http}
export SERVER_NAME=${VIRTUAL_HOST:-${SERVER_NAME:-localhost}}
export SERVER_ALIAS=${SERVER_ALIAS:-''}

envsubst '$SERVER_NAME $SERVER_ALIAS' < /nginx.conf.template > /etc/nginx/nginx.conf

# WordPress subs
export WP_SITE_URL=${WP_SITE_URL:-"$SERVER_PROTO://$SERVER_NAME"}
export WP_HOME=${WP_HOME:-$WP_SITE_URL}

supervisord -c /supervisord.conf
