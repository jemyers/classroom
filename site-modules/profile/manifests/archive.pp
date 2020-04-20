class profile::archive (
  String $filename,    # version being downloaded
 # String $created_path # Directory containg the war files

) 
{
#  $filename = hiera('profile::archive::filename')
#  $artifactory_host = heira('artifactory_host')
#  $artifactory_port = heira('artifactroy_port')

  archive { "/tmp/${filename}":
  ensure       => present,
  extract      => true,
  extract_path => '/tmp',
  source       => "https://downloads.apache.org/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33-deployer.tar.gz",
  creates      => "/tmp/${filename}",
  cleanup      => true,
  }
}
