class profile::redis {
  class { '::redis':
    databases => '2'
 }
}
