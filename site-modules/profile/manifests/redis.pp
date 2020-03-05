class profile::redis {
  class { '::redis_test':
    databases => '2'
 }
}
