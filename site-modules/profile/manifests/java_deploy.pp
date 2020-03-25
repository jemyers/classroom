class profile::java_deploy (
  Optional[Stdlib::HTTPUrl]      $url          = undef,
  String                         $path         = $name,
  Enum['present', 'absent']      $ensure       = present,
  Optional[String]               $owner        = undef,
  Optional[String]               $group        = undef,
  Optional[String]               $mode         = undef,
  Optional[Boolean]              $extract      = undef,
  Optional[String]               $extract_path = undef,
  Optional[String]               $creates      = undef,
  Optional[Boolean]              $cleanup      = undef,
  Optional[Stdlib::Absolutepath] $archive_path = undef,
)
  archive { "/tmp/test.txt":
    ensure       => $ensure,
    path         => '/tmp',
    extract      => true,
    extract_path => '/tmp',
    source       => '/tmp/test1',
    creates      => $creates,
    cleanup      => $cleanup,
  }
