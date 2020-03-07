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
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_database' );
/** MySQL database username */
define( 'DB_USER', 'plam' );
/** MySQL database password */
define('DB_PASSWORD', 'oof' );
/** MySQL hostname */
define( 'DB_HOST', 'localhost' );
/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );
/** The Database Collate type. Do not change this if in doubt. */
define( 'DB_COLLATE', '' );

# setting security keys

define('AUTH_KEY',         'sg[Wf9X_4+>XTCP?c$-Wq2kF}U6.];&>7]7B:;_}{I4tf~v&[XK-mG<a}4I=dX^J' );
define('SECURE_AUTH_KEY',  'JDIdzS:L?1k<v%7*|a)h-cD{N=TH2VH mFF!tZ /v9fraUqV}Y3mpO)A!R/G|[d2' );
define('LOGGED_IN_KEY',    'V-7IcWD`-VEHfFQDOcB@RQ__+8&/mt:plDh(A3~UG%-(1{b_|hu7D|MW|U10PSm>' );
define('NONCE_KEY',        '=T?nK{-$+(=kJLO~-]l4{[[HrRdN97.>>_dc@f,#9Y#3]s9,_$j}R0V.(zQ~|Etl' );
define('AUTH_SALT',        'e8KaM,~)($j~=@m>?2*^:@JeRr(ZG<lFOH*<dEQu&*+l<k/m;5HZGp}S%#x90!m+' );
define('SECURE_AUTH_SALT', 'P{z){ih-xmN+WK(ERfi+J`Y)D3.KF]Un-L^)*k+FIUZQt7#2xTk`8!q^^W7|t9[m' );
define('LOGGED_IN_SALT',   'K1e)bYqLf-;SDUOi3!D8~4p=^XoE3.8-21<z9vZ+DJl<<CV:)k^!^Mk{U&}3q%H-' );
define('NONCE_SALT',       '_Ia/iuPYgw0#/wChs:&YrDBTA473v(/c&FFYo+q.=AE;Ls_=k*>C-D)ZU=8r_#1G' );

# Advanced options

/* setting table prefix (It is possible to have multiple installations in one database if you give each a unique prefix.)
	ONLY NUMBERS, LETTERS AND UNDERSCORES */

$table_prefix = 'wp_';

# WP_DISABLE_FATAL_ERROR_HANDLER (here, is deactivated)

define( 'WP_DEBUG', false );
if ( WP_DEBUG ) {
	define( 'WP_DEBUG_LOG', true );
	define( 'WP_DEBUG_DISPLAY', false );
	@ini_set( 'display_errors', 0 );
}

# ABSPATH = path of the WordPress directory

/* Absolute path to the Wordpress directory */

if ( !defined('ABSPATH') )
	define('ABSPATH',dirname(__FILE__), '/');

/* Sets up WordPress vars & included files */

require_once(ABSPATH . 'wp-settings.php');