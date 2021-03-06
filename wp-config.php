<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// Configured by /docker-entrypoint.sh
define( 'WP_SITE_URL', getenv( 'WP_SITE_URL' ) ?: 'http://localhost' );
define( 'WP_HOME', getenv( 'WP_SITE_URL' ) ?: 'http://localhost' );
define( 'DB_NAME', getenv( 'DB_NAME' ) ?: 'wordpress' );
define( 'DB_USER', getenv( 'DB_USER' ) ?: 'wordpress' );
define( 'DB_PASSWORD', getenv( 'DB_PASSWORD' ?: 'wordpress' ) );
define( 'DB_HOST', getenv( 'DB_HOST' ) ?: 'mysql' );
define( 'DB_CHARSET', getenv( 'DB_CHARSET' ) ?: 'utf8mb4' );
define( 'DB_COLLATE', getenv( 'DB_CHARSET' ) ?: 'utf8mb4_unicode_ci' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY', getenv( 'AUTH_KEY' ) ?: '' );
define( 'SECURE_AUTH_KEY', getenv( 'SECURE_AUTH_KEY' ) ?: '' );
define( 'LOGGED_IN_KEY', getenv( 'LOGGED_IN_KEY' ) ?: '' );
define( 'NONCE_KEY', getenv( 'NONCE_KEY' ) ?: '' );
define( 'AUTH_SALT', getenv( 'AUTH_SALT' ) ?: '' );
define( 'SECURE_AUTH_SALT', getenv( 'SECURE_AUTH_SALT' ) ?: '' );
define( 'LOGGED_IN_SALT', getenv( 'LOGGED_IN_SALT' ) ?: '' );
define( 'NONCE_SALT', getenv( 'NONCE_SALT' ) ?: '' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', (bool) ( getenv( 'WP_DEBUG' ) ?: false ) );

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/**
 * Reverse Proxy Support
 *
 * @see https://codex.wordpress.org/Administration_Over_SSL
 */
define( 'FORCE_SSL_ADMIN', getenv( 'FORCE_SSL_ADMIN' ) ?: false );

if ( strpos( $_SERVER['HTTP_X_FORWARDED_PROTO'], 'https' ) !== false ) {
    $_SERVER['HTTPS'] = 'on';
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
