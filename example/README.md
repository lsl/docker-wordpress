# Example lslio/wordpress setup

## Quickstart

```
    git clone https://github.com/lsl/docker-wordpress
    cd docker-wordpress/example
    docker-compose up -d
    xdg-open http://example.localhost
```

This is a simple example of how you might use [lslio/wordpress](https://hub.docker.com/r/lslio/wordpress/) in a development environment.

The docker-compose.yml contains a reverse proxy, wordpress, and mysql containers. The reverse proxy could be removed if you only have one wordpress install you want to manage through this file.

## Salts

site/Dockerfile is an example Dockerfile you might use to build your own WordPress image.

Run `docker run --rm lslio/wordpress salt` and copy the output into site/Dockerfile


## Secrets in Environment Variables

Currently DB_PASSWORD is stored as an environment variable, along with AUTH_KEY and salts.

Fixing this would probably take a decent chunk of time where anyone serious enough could easily solve the problem by dropping in a secrets mount over /var/www/wordpress/wp-config.php.