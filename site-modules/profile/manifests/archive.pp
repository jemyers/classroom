class profile::archive {
  archive { 'test.txt':
  ensure       => present,
  extract      => true,
  extract_path => '/tmp',
  source       => 'https://downloads.apache.org/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33-deployer.tar.gz',
  creates      => '/tmp/javax',
  cleanup      => false,
  }
}
