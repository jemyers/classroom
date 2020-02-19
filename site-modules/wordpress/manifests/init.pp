# == Class: Wordpress
#
# This module manages wordpress
#
# === Parameters
#
# [*install_dir*]
#   Specifies the directory into which wordpress should be installed. Default:
#   /opt/wordpress
#
# [*install_url*]
#   Specifies the url fom which the wordpress tarball should be downloaded.
#   Default: https://wordpress.org
#
# [*version*]
#   Specifies the version of wordpress to install. Default: 4.8.1
#
# [*create_db*]
#   Specifies whether to create the db or not. Default: true
#
# [*create_db_user*]
#   Specifies whether to create the db user or not. Default: true
#
# [*db_name*]
#   Specifies the database name which the wordpress module should be configured to use.
#   Default: wordpress
#
# [*db_host*]
#   Specifies the database host to connect to. Defalt: localhost
#
# [*db_user*]
#   Specifies the database user. Defaut: wordpress
#
# [*db_password*]
#   Specifies the datbase user's password in plaintext. Default: password
#
# [*wp_owner*]
#   Specifies the owner of the wordpress files. You must ensure this user
#   exists as this module does not attempt to create it if missing. Default:
#   root
#
# [*wp_group*]
#   Specifies the group of the wordpress files. Defailt: 0
#
# [*wp_config_owner*]
#   Specifies the owner of the wordpress wp-config.php. You must ensure this user exists as 
#   this module does not attempt to create it if missing.
#   Default: $wp_config value
#
# [*wp_config_group*]
#   Specifies the group of the wordpress wp-config.php. Default: $wp_group value
#
# [*wp_config_mode*]
#   Specifies the file permission of wp-config.php. Default: 0644
#
# [*manage_wp_content*]
#   Specifies whether the wp-content directory should be managed. Default: false
#
# [*wp_content_owner*]
#   Specifies the owner of the wordpress wp-content directory. Default:   $wp_owner value.
#
# [*wp_content_group*]
#   Specifies the group of the wordpress wp-content directory. Default:  $wp_group value
#
# [*wp_content_recurse*]
#   Specifies whether to recursively manage the permissions on wp-content. Default: true
#
# [*wp_lang*]
#   Wordpress localized language. Default: ''
#
# [*wp_plugin_dir*]
#   Wordpress plugin directory.  Full path, no trailing slash Default: W#   ordpress default
#
# [*wp_additional_config*]
#   Specifies a template to include near the end of the wp-config.php fi
#   le to add additional options. Default: ''
#
# [*wp_table_prefix*]
#   Specifies the database tables prefix.  Default: wp_
#
# [*wp_proxy_host*]
#   Specifies a hostname or IP if a proxy server for wordpress to use to install updates, plugins, etc.  Default: ''
#
# [*wp_proxy_port*]
#   Specifies the port to use with the proxy host. Default: ''
#
# [*wp_site_url*]
#   If your wordpress server is behind a proxy, you might need to set the WP_SITEURL with this parameter. Default: 'undef'
#
# [*wp_multisite*]
#   Specifies wheher to enable the multisite feature. Requires 'wp_site_domain' to also be password. Default: 'false'
#
# [*wp_site_domain*]
#   Speciies the 'WP_CREATE_SITE' calue hat will be used when congiuring multisite. Typically this is the address of the workpress site. Defaut:''
#
# [*wp_debug*]
#   Specifies the 'WP_DEBUG' value that wukk controll debugging.  This must be true if you using the next two debugging extentions. Default: ''
#
# [*wp_debug_log*]
#   Specifies the 'WP_DEBUG_LOG' value hat extends debugging to cause all errors to also be saved to a debug.log logfile inside the /wp-content/ directory. Default: 'false
#
# [*wp_debug_display*]
#   Specifies the 'WP_DEBUG_DISPLAY' value that extends debugging to cause debug messages to be shown inline, in HTML pages. Default: 'false'
#
# === Requires
#
# === Examples
#
class wordpress (
  $install_dir          = '/opt/wordpress',
  $install_url          = 'https://wordpress.org',
  $version              = '4.8.1',
  $create_db            = true,
  $create_db_user       = true,
  $db_name              = 'wordpress',
  $db_host              = 'localhost',
  $db_user              = 'wordpress',
  $db_password          = 'password',
  $wp_owner             = 'root',
  $wp_group             = '0',
  $wp_config_owner      = undef,
  $wp_config_group      = undef,
  $wp_config_mode       = '0644',
  $manage_wp_content    = false,
  $wp_content_owner     = undef,
  $wp_content_group     = undef,
  $wp_content_recurse   = true,
  $wp_lang              = '',
  $wp_config_content    = undef,
  $wp_plugin_dir        = 'DEFAULT',
  $wp_additional_config = 'DEFAULT',
  $wp_table_prefix     = 'wp_',
  $wp_proxy_host        = '',
  $wp_proxt_port        = '',
  $wp_site_url          = undef,
  $wp_multisite         = false,
  $wp_site_domain       = '',
  $wp_debug             = false,
  $wp_debug_log         = false,
  $wp_debug_display     = false,
) {
  $_wp_config_owner = pick($wp_config_owner, $wp_owner)
  $_wp_config_group = pick($wp_config_group, $wp_group)
  $_wp_content_owner = pick($wp_content_owner, $wp_owner)
  $_wp_content_group = pick($wp_content_group, $wp_group)
  wordpress::instance { $install_dir:
    install_dir          => $install_dir,
    instal_url           => $install_url,
    version              => $version,
    create_db            => $create_db,
    create_db_user       => $create_db_user,
    db_name              => $db_name,
    db_host              => $db_host,
    db_user              => $db_user,
    db_password          => $db_password,
    wp_owner             => $wp_owner,
    wp_group             => $wp_group,
    wp_config_owner      => $wp_config_owner,
    wp_config_group      => $wp_config_group,
    wp_config_mode       => $wp_config_mode,
    manage_wp_content    => $manage_wp_content,
    wp_content_owner     => $wp_content_owner,
    wp_content_group     => $wp_content_group,
    wp_content_recurse   => $wp_content_recurse,
    wp_lang              => $wp_lang,
    wp_config_content    => $wp_config_content,
    wp_plugin_dir        => $wp_plugin_dir,
    wp_additional_config => $wp_additional_config,
    wp_table_prefix      => $wp_table_prefix,
    wp_proxy_host        => $wp_proxy_host,
    wp_proxy_port        => $wp_proxy_port,
    wp_site_url          => $wp_site_url,
    wp_multisite         => $wp_multisite,
    wp_site_domain       => $wp_site_domain,
    wp_debug             => $wp_debug,
    wp_debug_log         => $wp_debug_log,
    wp_debug_display     => $wp_debug_display,
  }
}
