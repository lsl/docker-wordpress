# WordPress + PHP-FPM7 + Nginx + Alpine Linux

Simplifying WordPress deployment leveraging docker.

.. That's the plan anyway.

Current state comes with a lot of technical caveats.

This is not a fork or replacement for the Official [WordPress](https://hub.docker.com/_/wordpress/) image.

This image aims to solve the problems you face when deploying a single WordPress image over a k8's cluster or docker swarm.

This image is *not* intended to be used stand-alone, while it comes with a working wordpress install it is intended as a base to install plugins and themes overtop. To use standalone you would need to mount your own wp-content folder into the container at runtime.

Current limitations:
- wp-content/uploads needs to be mounted to something like NFS for use on multi-server setups.
- Plugins that leverage disk for caching need to be avoided (e.g. w3-total-cache, fvm, autoptimize.)
- plugins and themes need to be pre-installed with composer.
- wp-cli is out due to requiring an unattainable db connection.

The nginx/php-fpm setup is based off of [lslio/nginx-php-fpm](https://github.com/lsl/docker-nginx-php-fpm) but does not extend from it so we have some room to make customizations for WordPress.

To work around the limitations it is expected users either run a build step on their themes / plugins prior to building the docker image or make use of external services to handle minification and other optimizations.

A potential addition to this project might be a pre-configured varnish image that is automatically aware / linked to this image.

## [Quickstart example](https://github.com/lsl/docker-wordpress/tree/master/example)

```
    git clone git@github.com:lsl/docker-wordpress.git
    cd docker-wordpress/example
    docker-compose up -d
    xdg-open http://example.localhost
```

## [Docker Pull](https://hub.docker.com/r/lslio/wordpress/)

```
    docker pull lslio/wordpress
```


