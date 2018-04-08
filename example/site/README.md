# Example Site Dockerfile

This setup assumes you're in a position to pre-load plugins via composer and keep them up to date that way.

This setup has been designed with two main approaches in mind. Using this folder as a project folder and doing everyhing here, or having devops maintain this Docker setup and importing existing theme/plugin projects via composer.

Either approach should start with a run of composer update to setup your composer.lock file, this speeds up builds and lets others get up to speed quicker.

The resulting vendor and wp-content dirs are gitignored and dockerignored intentionally but for development you can mount them via docker-compose.yml.

If you need to make edits to specific 3rd party plugin you could check out their source tree into ./ and copy it in via the Dockerfile. I advise not to make random edits to things in vendor/wp-content and then commit them.