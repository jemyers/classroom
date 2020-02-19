define wordpress::instance::db (
  Boolean $create_db,
  Boolean $create_db_user,
  String $db_name,
  String $db_host,
  String $db_user,
  String $db_password,
) {
  ## Set up DB using pupperlabs-mysql defined type
  if $create_db {
    mysql_database { "${db_host}/${db_name}":
      name    => $db_name,
      charset => 'utf8',
    }
  }
  if $create_db_user {
    mysql_user { "${db_user}@${db_host}":
      password_hash => mysql_password($db_password),
    }
    mysql_grant { "${db_user}@${db_host}/${db_name}.*":
      table      => "${db_name}.*",
      user       => "${db_user}@${db_host}",
      privileges => ['ALL'],
    }
  }

}
