class profile::archive {
  archive { '/tmp/test.txt':
  ensure       => present,
  extract      => true,
  extract_path => '/tmp',
  source       => 'http://central.maven.org/maven2/javax/transaction/jta/1.1/jta-1.1.jar',
  creates      => '/tmp/javax',
  cleanup      => false,
  }
}
