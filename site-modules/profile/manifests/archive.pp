class profile::archive {
  archive { '/tmp/test.txt':
  ensure       => present,
  extract      => false,
  extract_path => '/tmp',
  url       => 'https://repo.jfrog.org/artifactory/distributions/images/Artifactory_120x75.png',
  creates      => '/tmp/javax',
  cleanup      => false,
  }
}
