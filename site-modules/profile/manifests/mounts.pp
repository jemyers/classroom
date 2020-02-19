class profile::mounts {
  mount { '/':
    ensure => 'mounted',
    device => '/dev/xvda1',
    fstype => 'xfs',
  }
}
