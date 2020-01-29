class profile::mount {
  mount { '/':
    ensure => 'mounted',
    device => '/dev/xvda1',
    fstype => 'xfs',
 }
}
